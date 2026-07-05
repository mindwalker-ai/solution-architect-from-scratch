# Lab — Build an image, run a local registry, push and pull

> **Goal:** make "an image lives in a registry" concrete before you govern one for a customer. You'll build one image, run your own private registry locally, push the image to it, pull it back, and run it. ~15 minutes, no cloud account, no cost.
>
> **Why an architect does this once:** you don't ship Dockerfiles for a living, but you *will* recommend a private registry, a scan gate, and a signing policy. Feeling the build → push → pull → run loop yourself keeps those recommendations honest.

## Prerequisites

- **Docker** (or Podman — the commands are drop-in compatible; swap `docker` for `podman`).
- Verify it's running:

```bash
docker version
```

## Step 1 — Build one image

Create a tiny app and a Dockerfile in an empty folder.

```bash
mkdir garuda-lab && cd garuda-lab

cat > app.sh <<'EOF'
#!/bin/sh
echo "Garuda Finance demo service — image pulled from a private registry."
echo "hostname: $(hostname)"
EOF

cat > Dockerfile <<'EOF'
FROM alpine:3.20
COPY app.sh /app.sh
RUN chmod +x /app.sh
CMD ["/app.sh"]
EOF
```

Build it and tag it:

```bash
docker build -t garuda-demo:1.0 .
```

Inspect the **layers** the registry will store and de-duplicate (this is the "image = layers" concept from the lesson):

```bash
docker history garuda-demo:1.0
```

## Step 2 — Run a local private registry

Run the open-source registry (the same engine Harbor wraps with scanning, RBAC, and signing) as a container on port 5000:

```bash
docker run -d -p 5000:5000 --name registry registry:2
```

Confirm it's up (empty catalog is expected):

```bash
curl -s http://localhost:5000/v2/_catalog
# {"repositories":[]}
```

## Step 3 — Push the image to your private registry

Re-tag the image with the registry's address, then push:

```bash
docker tag garuda-demo:1.0 localhost:5000/garuda-demo:1.0
docker push localhost:5000/garuda-demo:1.0
```

The image now lives in **your** registry, not on public Docker Hub. Verify:

```bash
curl -s http://localhost:5000/v2/_catalog
# {"repositories":["garuda-demo"]}
curl -s http://localhost:5000/v2/garuda-demo/tags/list
# {"name":"garuda-demo","tags":["1.0"]}
```

## Step 4 — Pull it back and run it

Prove the loop closes: remove the local copies, pull only from the registry, and run.

```bash
docker rmi garuda-demo:1.0 localhost:5000/garuda-demo:1.0
docker run --rm localhost:5000/garuda-demo:1.0
```

You should see the demo service's output. It ran from an image that came *only* from the registry you control — exactly the "no public registry in the production path" posture the lesson recommends for Garuda.

## What you just proved (map it back to the lesson)

| You did | The architecture concept |
|---|---|
| `docker history` showed stacked layers | An image is read-only **layers**; the registry stores and de-dupes them. |
| Ran `registry:2` locally | A **private registry** — the thing Harbor productizes with scan + sign + RBAC. |
| Re-tagged with `localhost:5000/...` then pushed | Curating what enters your registry, instead of pulling unknown images off the internet. |
| Removed local copies, pulled, ran | The **build → push → pull → run** supply chain — the path you govern with scanning and signing. |

## Optional — feel the scan gate

If you have [Trivy](https://trivy.dev/) installed, scan the image for known CVEs — this is the "Critical blocks promotion" gate from the lesson, in one command:

```bash
trivy image localhost:5000/garuda-demo:1.0
```

Now imagine that gate wired into the registry so a Critical finding *stops the push*. That's the policy you specified for Garuda in the assessment.

## Cleanup

```bash
docker stop registry && docker rm registry
docker rmi registry:2 localhost:5000/garuda-demo:1.0 2>/dev/null
cd .. && rm -rf garuda-lab
```

---

**Takeaway:** the mechanics are a 15-minute loop. The architect's value isn't running these commands — it's deciding *which* workloads earn this treatment (the readiness matrix) and *how* the images are proven safe (scan, sign, private registry) before the whole estate trusts them.
