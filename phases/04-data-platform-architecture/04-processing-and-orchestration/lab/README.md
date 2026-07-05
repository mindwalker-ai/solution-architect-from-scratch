# Lab — Prove a dbt Pipeline End-to-End (dbt + DuckDB)

> **Design claim to validate:** ELT with dbt gives you a *tested, lineage-tracked, recoverable* transformation layer — Bronze → Silver → Gold as plain SQL — with no cloud account and no specialist tooling. Once you have *seen* dbt build and test a medallion on your laptop, you can put it in a proposal with confidence.

This runs the core of the [Kirim Cepat pipeline design](../outputs/example-kirim-cepat-pipeline.md) on a **local, free, in-process** engine (DuckDB). It seeds raw scan events, builds a **Silver** dedupe/clean model and a **Gold** hub-SLA mart, and runs **data-quality tests** that gate the build.

Everything you need is already in this folder — no files to create by hand.

```
lab/
├── dbt_project.yml            # project + Bronze/Silver/Gold materialization config
├── profiles.yml               # points dbt at a local DuckDB file
├── seeds/
│   ├── raw_scan_events.csv     # BRONZE: raw scans (incl. a duplicate scan_id)
│   └── raw_hubs.csv            # BRONZE: hub reference
└── models/
    ├── staging/               # SILVER
    │   ├── stg_scan_events.sql # dedupe + type the scans
    │   ├── stg_hubs.sql        # hub dimension
    │   └── schema.yml          # tests: not_null · unique · relationships · accepted_values
    └── marts/                  # GOLD
        ├── agg_hub_sla_daily.sql  # per hub per day delivery success rate
        └── schema.yml             # test: not_null on the metric
```

## 1. Set up (about 2 minutes)

```bash
# From this lab/ folder. A venv keeps it isolated.
python3 -m venv .venv
source .venv/bin/activate           # Windows: .venv\Scripts\activate
pip install dbt-duckdb

# Tell dbt where the profile lives (this folder)
export DBT_PROFILES_DIR="$PWD"      # Windows (PowerShell): $env:DBT_PROFILES_DIR = $PWD
```

## 2. Build the pipeline + run the tests

```bash
dbt build      # loads seeds, builds Silver + Gold models, runs every test — in dependency order
```

`dbt build` is the whole pipeline in one command. Expect it to end with:

```
Done. PASS=15 WARN=0 ERROR=0 SKIP=0 NO-OP=0 TOTAL=15
```

That's **2 seeds + 2 Silver models + 1 Gold model + 10 tests**, all green. dbt figured out the order from the `ref()`s — you never told it what depends on what.

## 3. See what you built

```bash
# The Gold mart the hub-SLA dashboard would read:
duckdb kirim_cepat.duckdb "select * from agg_hub_sla_daily order by event_date, hub_id;"
```

Expected result:

```
 event_date │  hub_id     │ final_parcels │ delivered │ failed │ delivery_success_rate_pct
────────────┼─────────────┼───────────────┼───────────┼────────┼───────────────────────────
 2026-07-03 │ HUB-JKT-01  │       4       │     3     │   1    │           75.0
 2026-07-03 │ HUB-SBY-02  │       3       │     2     │   1    │           66.7
 2026-07-04 │ HUB-JKT-01  │       4       │     3     │   1    │           75.0
 2026-07-04 │ HUB-SBY-02  │       3       │     2     │   1    │           66.7
```

Notice the raw seed has **16** rows but Silver has **15** — `stg_scan_events` deduped the repeated `scan_id S001`, keeping the latest (`delivered`) event. That is the idempotency/dedupe pattern from the lesson, in four lines of SQL.

## 4. Prove the test gate actually stops bad data

Tests are not decoration — they *block promotion*. Break the data and watch the gate catch it:

```bash
# Add a scan with a status that isn't in the allowed set, then rebuild:
echo "S999,P999,C09,HUB-JKT-01,teleported,2026-07-04 18:00:00" >> seeds/raw_scan_events.csv
dbt build
```

The `accepted_values` test on `status` now **fails** (`ERROR`), and dbt stops — in a real pipeline the orchestrator would alert and the dashboard would keep the last good data. Remove that line to go green again:

```bash
# macOS/Linux: delete the last line you added
sed -i '' -e '$ d' seeds/raw_scan_events.csv   # (Linux: sed -i '$ d' seeds/raw_scan_events.csv)
dbt build
```

## 5. Get lineage for free

```bash
dbt docs generate       # builds the catalog + lineage graph from your ref()s
# dbt docs serve        # (optional) opens a browsable lineage UI in your browser
```

The lineage graph — `raw_* → stg_* → agg_hub_sla_daily` — was never drawn by hand; dbt derived it from the `ref()` calls. That is the "free lineage" claim from the lesson, verified.

## What this proves for the design

- **ELT works in plain SQL** — every transform here is a `SELECT`; an analyst could review it.
- **Tests gate quality** — `not_null`, `unique`, `relationships`, `accepted_values` ran automatically and a bad row failed the build.
- **Lineage is automatic** — the Bronze→Silver→Gold graph came from `ref()`, not a diagram.
- **It scales the same way** — swap DuckDB for the customer's lakehouse and add `+materialized: incremental` to the high-volume models; the *shape* is identical to the [Kirim Cepat design](../outputs/example-kirim-cepat-pipeline.md).

> Scope note: this is a **design-validation** lab, not a production build. It deliberately runs on tiny local data. The point is to see the pattern work before you commit a customer to it — orchestration (Airflow/Dagster), incremental materialization at 500M rows/month, and the backfill live in the design docs, not on your laptop.
