# Lab — Feel Block vs Object (MinIO, with a single-node Ceph option)

> **Why this lab exists.** You are an architect, not a storage admin — you will never operate this cluster. You run this once so the object tier stops being an abstraction: you will *see* that an object store is an HTTP API returning immutable, versioned buckets, not a disk you format. That felt difference is what makes you size the T3 tier correctly on the next deal. **~20 minutes. Local + free. Read-only intent — tear it down when done.**

Everything here is **copy-run**. You need Docker (Desktop or Engine). No cloud account, no cost.

---

## Part A — Object storage in 5 minutes (MinIO)

MinIO is an S3-compatible object store — the same shape as the T3 tier in the Garuda design. Stand it up:

```bash
# 1. Run MinIO (S3 API on :9000, web console on :9001)
docker run -d --name lab-minio -p 9000:9000 -p 9001:9001 \
  -e MINIO_ROOT_USER=labadmin \
  -e MINIO_ROOT_PASSWORD=labsecret123 \
  quay.io/minio/minio server /data --console-address ":9001"

# 2. Confirm it's up
docker ps --filter name=lab-minio
```

Open the console at **http://localhost:9001** (login `labadmin` / `labsecret123`). You are looking at storage as a *service with a URL*, not a mounted disk — that is the whole point of object.

Now drive it from the S3 client (`mc`), so you see the API an application actually uses:

```bash
# 3. Get the mc client shell inside the container
docker exec -it lab-minio sh

# --- inside the container ---
mc alias set local http://localhost:9000 labadmin labsecret123

# 4. Create a bucket = the unit of object storage
mc mb local/kyc-documents

# 5. Put an object (a fake KYC scan) and list it
echo "customer 8421 — KYC passport scan (pretend PDF)" > /tmp/passport.txt
mc cp /tmp/passport.txt local/kyc-documents/cust-8421/passport.txt
mc ls --recursive local/kyc-documents
```

You just wrote an object addressed by a **key** (`cust-8421/passport.txt`) inside a **bucket** — a flat namespace over HTTP. No partition, no filesystem, no mount. That is why object scales to billions of KYC scans while a block volume cannot.

## Part B — See immutability (WORM), the thing OJK asks about

The Garuda design puts **WORM / object-lock** on backups and audit. Feel why that is an object-storage superpower:

```bash
# --- still inside the container ---
# 6. Turn on versioning, then object-lock semantics via retention
mc version enable local/kyc-documents

# 7. Overwrite the object — the OLD version is retained, not destroyed
echo "TAMPERED content" > /tmp/passport.txt
mc cp /tmp/passport.txt local/kyc-documents/cust-8421/passport.txt

# 8. List all versions — the original is still there
mc ls --versions local/kyc-documents/cust-8421/passport.txt
```

You will see **two versions**: the tamper did not erase the original. That is the audit/ransomware story an SA promises the regulator — and it is native to object, awkward to impossible on a block volume. (For a true immutable lock, a bucket created with `mc mb --with-lock` plus a retention policy prevents deletion entirely; versioning above is enough to *see* the concept.)

```bash
exit   # leave the container shell
```

## Part C — Contrast: block behaves like a disk

You do not need a full Ceph cluster to feel the difference — a loopback block device shows it:

```bash
# 9. Create a 512 MB file and expose it as a BLOCK device
dd if=/dev/zero of=/tmp/lab-block.img bs=1M count=512
LOOP=$(sudo losetup --find --show /tmp/lab-block.img)   # e.g. /dev/loop0
sudo mkfs.ext4 "$LOOP"                                    # you FORMAT block; you never format object
sudo mkdir -p /mnt/lab-block && sudo mount "$LOOP" /mnt/lab-block
df -h /mnt/lab-block
```

Notice what block forced you to do that object did not: **partition, format a filesystem, mount to a single host.** That ceremony is the price of low-latency, single-host semantics — exactly what a database wants and a document store does not. One host mounts this; you cannot hand the same block device to 400 clients the way a bucket handles them.

## Optional — Single-node Ceph (unified block + file + object)

To see all three access types from **one** cluster (the Ceph value proposition in *Compare It*), MicroCeph gives a single-node cluster in a few commands (Ubuntu):

```bash
sudo snap install microceph
sudo microceph cluster bootstrap
sudo microceph disk add loop,4G,3          # 3 virtual OSDs on loopback
sudo microceph.ceph status                 # HEALTH + OSD tree — your failure domains
# Then: microceph enable rgw  → S3 object;  rbd  → block;  cephfs  → file — all from one cluster.
```

Watch `ceph status` report `3 osds`: this is the **failure-domain count** from the sizing math. On 3 OSDs you can do replication ×3 but **not** EC 4+2 (which needs ≥6) — the §5 cluster-minimum constraint, made concrete.

## Tear down (leave nothing running)

```bash
# MinIO
docker rm -f lab-minio && docker volume prune -f

# Block loopback (Part C)
sudo umount /mnt/lab-block 2>/dev/null; sudo losetup -d "$LOOP" 2>/dev/null; rm -f /tmp/lab-block.img

# MicroCeph (if installed)
sudo snap remove microceph 2>/dev/null
```

## What you should carry back to the design

| You saw… | So on the next sizing… |
|---|---|
| Object is a bucket + key over HTTP, no mount, unbounded | Put documents, backups, logs on the **object (T3)** tier — never a block volume |
| Versioning kept the pre-tamper copy | Promise **WORM/object-lock** for backups + audit; it's the OJK/ransomware answer |
| Block made you partition, format, mount to one host | Reserve **block (T1/T2)** for databases and VM disks that need low latency |
| Ceph `status` showed 3 OSDs = 3 failure domains | Remember EC 4+2 needs ≥6 — the **cluster-minimum** line in your BOM is real |

> This lab validates one design claim: **block and object are different products for different jobs.** It is not a step toward operating storage — that stays with the customer's platform team.
