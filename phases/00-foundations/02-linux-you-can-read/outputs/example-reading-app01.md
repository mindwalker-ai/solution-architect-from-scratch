---
name: example-reading-app01
description: Worked example of the Linux-for-Architects worksheet — reading "app01", a struggling order-tracking server, end-to-end into a defensible one-paragraph sizing recommendation.
phase: 0
lesson: 2
audience: internal
---

# Worked Example: Reading `app01`

**Customer:** Northwind Logistics (fictional). **Situation:** the order-tracking app "falls over every afternoon." You have 45 minutes and read-only SSH. This is the [cheat sheet worksheet](./template-linux-for-architects-cheatsheet.md) filled in from the raw output.

## The raw output you were handed

**`top` (14:32):**
```
top - 14:32:07 up 87 days,  load average: 11.84, 10.02, 8.41
%Cpu(s):  9.2 us,  4.1 sy,  0.0 ni, 12.3 id, 73.8 wa,  0.4 hi,  0.2 si
MiB Mem :   7822.0 total,    201.5 free,   6903.2 used,    717.3 buff/cache
MiB Swap:   2048.0 total,     48.0 free,   2000.0 used
  PID USER      RES   S  %CPU  %MEM  COMMAND
 2891 postgres  5.1g  D   6.3  66.8  postgres
 4123 appuser   410m  R   3.1   5.2  python3
```

**`df -h`:**
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        49G   47G  1.8G  97% /
/dev/sdb1       200G  180G   20G  91% /var/lib/postgresql
```

**`journalctl` excerpt:**
```
Jul 04 14:29:51 app01 kernel: Out of memory: Killed process 4123 (python3)
Jul 04 14:30:12 app01 postgres[2891]: LOG:  could not write … No space left on device
Jul 04 14:31:03 app01 nginx[3210]: *884 upstream timed out (110: Connection timed out)
```

## Worksheet — filled in

```
SERVER: app01              ROLE: order-tracking (nginx + python app + postgres)   DISTRO: Ubuntu 22.04
CURRENT SPEC:  4 vCPU   8 GB RAM   250 GB disk (49 GB root + 200 GB data, cloud volume)

CPU     load (1/5/15): 11.84 / 10.02 / 8.41 on 4 cores    %wa: 73.8%   → cpu-bound?  N
        (load is ~3× cores, but CPUs are 74% idle-WAITING on I/O, only ~13% computing)
MEMORY  available: ~0.2 of 7.6 GB   swap used: 2000 of 2048  → mem-bound? Y
        (postgres alone = 5.1 GB / 66.8%; swap 98% consumed = RAM exhausted)
DISK    fullest FS: / at 97% ; /var/lib/postgresql at 91%   → disk-bound (capacity)? Y
        (also feeding the I/O-wait: swapping thrashes the disk)
NETWORK key listening ports: 80/443 (nginx), 5432 (postgres, localhost)

CONFIG  designed limits: (to confirm) postgres shared_buffers / work_mem, app DB pool
LOG     fingerprints: OOM-killer active · "No space left" · nginx upstream timeout

BOTTLENECK (name ONE primary): MEMORY (starvation → swap → disk thrash → I/O-wait → high load),
           with DISK CAPACITY as a stacked second constraint.
```

## The recommendation (one paragraph, defensible)

> **`app01` is memory-bound and disk-constrained, not CPU-bound.** The 4 vCPUs sit ~74% idle-waiting on I/O; the real ceilings are RAM (swap 98% consumed, Postgres alone needs 5.1 GB) and disk capacity (root 97%, data volume 91%). **Recommend:** (1) raise memory **8 GB → 24 GB** so the Postgres working set plus the app fit without swapping — expect I/O-wait to collapse and load to fall toward the 4-core line; (2) move the Postgres data directory to a **larger, higher-IOPS SSD volume** and grow / offload logs from the root disk before it hits 100%; (3) **do not** add vCPUs or scale out to multiple app nodes yet — the bottleneck is a single vertical resource and scaling out would multiply cost without touching the cause. **Sanity check:** Postgres's resident 5.1 GB already exceeds available RAM and swap is fully consumed — a textbook memory-starvation signature. **Re-measure** load and `%wa` after the RAM increase before considering further scaling.

## What this saved the customer

Northwind's own instinct was "move it to a bigger cloud instance / add CPUs" — a compute-led spend. Reading the box redirected the fix to **+16 GB RAM and a disk change**: cheaper, more precise, and it targets the actual afternoon-failure cause. That redirection *is* the value of an architect who can read Linux.

## Carry-forward → sizing note (Phase 2)

| Resource | Current | Target | Justification | Assumption to confirm |
|----------|---------|--------|---------------|-----------------------|
| RAM | 8 GB | **24 GB** | Postgres working set (~6 GB) + app + cache without swap | Working set ~6 GB — confirm with DBA (`shared_buffers`, active data size) |
| Disk (data) | 200 GB HDD-class | **300 GB SSD, higher IOPS** | End I/O-wait; 91% used and growing | Growth rate ~____ GB/month — confirm 12-month horizon |
| Disk (root) | 49 GB @ 97% | grow to 80 GB **or** offload logs | Prevent 100%-full crash | Are logs shipped off-box? If not, offload first |
| vCPU | 4 | **4 (unchanged)** | CPU is idle-waiting, not saturated | Re-measure `%wa` after RAM fix; revisit only if load stays high |

**Range, not a magic number:** 24 GB is the recommended point in a **16–32 GB** band — 16 GB if the DBA confirms a smaller working set, 32 GB to leave headroom for growth. Never present the single number without the band and the assumption behind it.
