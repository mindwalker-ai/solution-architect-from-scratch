---
name: linux-for-architects-cheatsheet
description: The ~15 read-only Linux commands that reveal a server's state in discovery, each with "what it tells you / what a bad value looks like", plus a one-server read worksheet.
phase: 0
lesson: 2
audience: internal
---

# Linux-for-Architects Cheat Sheet

> **All commands are READ-ONLY.** You are diagnosing capacity and failure in discovery — not administering the box. Nothing here changes state. If you only remember one thing: **`available` memory, not `free`; and cross-check `load` against `%wa` before blaming the CPU.**

## The 15 commands that reveal state

| # | Command | What it tells you | What a *bad* value looks like |
|---|---------|-------------------|-------------------------------|
| 1 | `cat /etc/os-release` | Distro + version → which family, which package manager, where logs live | Unsupported/EOL version (e.g. CentOS 7) → a migration line item |
| 2 | `uname -r` | Kernel version | Wildly old kernel on a "cloud-native" pitch — hidden risk |
| 3 | `uptime` | Load average (1/5/15 min) + how long up | Load ≫ core count; 300+ days uptime = un-patched, never rebooted |
| 4 | `nproc` / `lscpu` | CPU core count (the denominator for load) | Cores that don't match the invoice / the pitch |
| 5 | `top` (or `htop`) | Live CPU %, mem, and per-process consumers | High load **+** high `%wa` **+** low `%us` = disk-bound, not CPU-bound |
| 6 | `free -h` | Memory: total / used / **available** / swap | `available` near zero **and** swap filling = RAM exhausted |
| 7 | `df -h` | Disk capacity per filesystem (`Use%`) | Any filesystem > ~90%, especially `/` — imminent failure |
| 8 | `df -i` | Inodes used (file *count* limit) | `IUse%` near 100% while bytes look fine = write failures |
| 9 | `du -sh /path/*` | What is actually eating a directory | One runaway dir (logs, temp, a table) dominating a full disk |
| 10 | `lsblk` | Disk/partition topology (which volume is which) | Data on the same small disk as the OS — no room to grow |
| 11 | `iostat -xz 1` | Disk `%util` and `await` (latency, ms) | `%util` pinned ~100%; `await` in the hundreds = disk stall |
| 12 | `vmstat 1` | Swap-in/out (`si`/`so`), run queue, `wa` | Non-zero `si`/`so` = actively paging to disk (thrashing) |
| 13 | `ps aux --sort=-%mem` | Top memory (or `-%cpu`) consumers, with PIDs | One process holding most of RAM; a process stuck in `D` state |
| 14 | `systemctl list-units --failed` + `systemctl status <svc>` | Which services are broken; a service's state, PID, memory, recent logs | `failed` units; a service `MemoryMax` it keeps hitting |
| 15 | `journalctl -u <svc> --since "1 hour ago"` / `journalctl -k` | Service and **kernel** logs (OOM-killer lives here) | `Out of memory: Killed process…`, `No space left`, `Too many open files` |

**Bonus — network & GPU:**
- `ss -tulpn` — every listening port and the process behind it (feeds firewall/LB design later).
- `ip a` / `ip r` — addresses, NICs, routes.
- `nvidia-smi` — on AI/GPU servers: utilisation and **memory used / total** per GPU (the extra meter for Phase 5 sizing).

**Reading config vs. log — the two text files that carry the signal:**
- **Config** (`/etc/…`) = *designed* capacity: `worker_processes`/`worker_connections`, `max_connections`, pool sizes, `MemoryMax`/`LimitNOFILE`.
- **Log** (`/var/log/…`, `journalctl`) = *observed* reality: skim for `ERROR`, `WARN`, `Killed`, `timed out`, `No space left`, `pool exhausted`.

## The four-meter reasoning model

```
RESOURCE   READ WITH        "HOW FULL"          SATURATION SIGNATURE
────────────────────────────────────────────────────────────────────────
CPU        uptime / top     load vs nproc       load ≫ cores AND %us high
Memory     free -h          available (not free) available ~0 + swap filling
Disk       df -h / iostat   Use% ; await/%util   >90% full OR %util ~100%
Network    ss -tulpn / ip   ports in use         (rarely the bottleneck on 1 box)
────────────────────────────────────────────────────────────────────────
Golden rule: a HIGH LOAD with HIGH %wa is a DISK or MEMORY problem
             wearing a CPU costume. Never size CPU off load alone.
```

## One-server read worksheet (fill this in per box)

```
SERVER: ____________________   ROLE: ____________________   DISTRO: ____________________
CURRENT SPEC:  ____ vCPU   ____ GB RAM   ____ GB disk   ( SSD / HDD / cloud volume )

CPU     load (1/5/15): __________ on ____ cores    %wa: ____%    → cpu-bound?  Y / N
MEMORY  available: ______ of ______ GB   swap used: ______ of ______  → mem-bound? Y / N
DISK    fullest FS: __________ at ____%   await/%util: __________     → disk-bound? Y / N
NETWORK key listening ports: ________________________________________

CONFIG  designed limits (workers / pools / max_conn): ________________________________
LOG     fingerprint lines seen (OOM / no space / timeout / pool): ___________________

BOTTLENECK (name ONE primary): ______________________________________________________
RECOMMENDATION (one paragraph — what to change, and what NOT to buy):
____________________________________________________________________________________
____________________________________________________________________________________
ASSUMPTION a customer could challenge: ______________________________________________
SANITY-CHECK RANGE (not a single number): ___________________________________________
```

## How to use it

1. Get read access (SSH) or a support bundle; run commands 1–15 top to bottom.
2. Fill the worksheet — one line per meter.
3. Name **one** primary bottleneck. Resist "add everything."
4. Write the recommendation as a paragraph tied to the evidence, and state what the customer should *not* spend on.
5. Carry the numbers forward into the sizing note / BOM in later phases.

> See [`example-reading-app01.md`](./example-reading-app01.md) for this worksheet filled in against a real (fictional) struggling server.
