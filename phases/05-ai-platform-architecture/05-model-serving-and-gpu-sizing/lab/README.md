# Lab — vLLM micro-bench: measure the two numbers your sizing sheet rests on

> The whole GPU BOM hangs on two figures you must **measure, not guess**: per-replica **throughput** (tokens/sec) and **TPOT** (time-per-output-token) **under load**. This lab runs vLLM on one GPU and its built-in benchmark to validate them, then shows how to scale the observed number to your replica count. Copy-run; ~30 minutes.

**Goal:** turn "≈2,500 tok/s per replica `[LAB]`" from an assumption into a measurement you can put your name on.

**You need:** one CUDA GPU (rented by the hour is fine — an A100 80GB or H100 80GB; an L40S 48GB works for a smaller model), Python 3.10+, and the model weights. **No customer data required** — this measures the *engine*, not the answers.

---

## 0. Scale the model to your GPU

If you only have one 48 GB GPU, don't try to bench the full 70B — the *method* is identical at any size. Pick a model that fits one GPU and bench that; you are validating the engine's tokens/sec and TPOT curve, then reasoning about the ratio.

| Your GPU | Bench this model (INT4/AWQ) | What you're validating |
|---|---|---|
| H100 / A100 80GB | `casperhansen/llama-3-70b-instruct-awq` (or a 70B AWQ repo) | the real replica |
| L40S 48GB / smaller | `Qwen/Qwen2.5-14B-Instruct-AWQ` or an 8B AWQ | the throughput/TPOT *shape* to extrapolate |

---

## 1. Install

```bash
python -m venv .venv && source .venv/bin/activate
pip install "vllm>=0.6.0"          # brings its own CUDA torch; use a recent version
```

## 2. Start the server (one replica, single GPU)

```bash
# swap MODEL for one that fits your GPU (see the table above)
export MODEL="Qwen/Qwen2.5-14B-Instruct-AWQ"

vllm serve "$MODEL" \
  --quantization awq \
  --gpu-memory-utilization 0.90 \   # <-- this is your KV budget: 90% of VRAM after weights goes to the cache
  --max-model-len 8192 \            # <-- your resident context (input+output); matches the sizing sheet
  --tensor-parallel-size 1 \        # <-- set to 2+ ONLY if the model needs multiple GPUs (TP inside one node)
  --port 8000
```

Watch the startup log for the line that reports the **KV-cache size / number of GPU blocks** — that is your VRAM math (§3 of the sheet) confirmed by the engine. If it logs far fewer blocks than you expected, your weights+overhead left less KV room than assumed — a finding.

## 3. Benchmark throughput + latency under load

vLLM ships a load generator. Point it at the running server and push concurrency up in steps — this traces the throughput-vs-latency curve that decides your replica count.

```bash
# from the vLLM source tree (git clone https://github.com/vllm-project/vllm), or use `vllm bench serve` on recent builds
python benchmarks/benchmark_serving.py \
  --backend vllm \
  --model "$MODEL" \
  --host localhost --port 8000 \
  --dataset-name random \
  --random-input-len 5000 \         # <-- your RAG input size (retrieved chunks + prompt)
  --random-output-len 500 \         # <-- your answer length
  --max-concurrency 16 \            # <-- sweep this: 4, 8, 16, 32, 48
  --num-prompts 200
```

Re-run at `--max-concurrency 4 8 16 32 48` and record, for each:

| Concurrency | Output tok/s (aggregate) | Median TPOT (ms) | Median TTFT (ms) | P99 end-to-end (s) |
|---|---|---|---|---|
| 4 | … | … | … | … |
| 16 | … | … | … | … |
| 32 | … | … | … | … |
| 48 | … | … | … | … |

## 4. Read the result like an architect

1. **Find where TPOT crosses your SLA.** Answer latency ≈ TTFT + output_tokens × TPOT. For a 500-token answer at a 10 s ceiling, TPOT must stay ≤ ~20 ms. The highest concurrency that still holds that is your **per-replica running-batch cap** (`[LAB]` line 6 in the sheet).
2. **Read aggregate tok/s at that concurrency.** That is your **per-replica throughput** (`[LAB]` line 5). This replaces the ~2,500 assumption with a measured number.
3. **Watch the knee.** Throughput climbs with concurrency, then flattens while TPOT keeps rising — that knee is the point past which more batching only *hurts* users. Size replicas to sit left of it.
4. **Extrapolate honestly.** If you benched a 14B on one GPU, do **not** claim the 70B/TP=2 number — state "measured shape on 14B; 70B replica to be confirmed on target hardware." A measured smaller-model curve plus a labelled extrapolation still beats a pure guess.

## 5. Feed it back

Update these lines in `../outputs/example-bumi-energi-gpu-sizing.md` (and your own sheet):
- §5 **Throughput/replica** — replace `~2,000–3,000` with your measured band.
- §5 **Latency cap** — replace `≤ ~40 / ~20 ms` with the concurrency where TPOT crossed the SLA.
- §9 register rows 5 & 6 — mark them **measured**, cite the GPU and date.

If your measured per-replica throughput is lower than assumed, your **replica count (and GPU BOM) goes up** — better to learn that in this lab than in the customer's production incident review.

---

**Safety / cost note:** rent the GPU by the hour and stop it when done. This lab needs no customer documents — it measures the serving engine, which is exactly the claim your quote depends on.
