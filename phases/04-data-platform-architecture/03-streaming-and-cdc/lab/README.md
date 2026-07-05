# Lab — Local Kafka: create a topic, produce, and consume

> **Goal:** make the log / topic / consumer-group model concrete before you defend a streaming design for a customer. You'll run a single-broker Kafka locally, create a topic, produce a few events, consume them, and *feel* replay and independent consumer groups. ~15 minutes, no cloud account, no cost.
>
> **Why an architect does this once:** you won't operate Kafka for a living, but you *will* recommend topics, partition keys, retention, and delivery guarantees. Feeling the produce → append → consume → replay loop yourself keeps those recommendations honest — and lets you answer "is Kafka a queue?" correctly (it isn't).

## Prerequisites

- **Docker** (or Podman — swap `docker` for `podman`).
- Verify it's running:

```bash
docker version
```

## Step 1 — Run a single-broker Kafka (KRaft mode, no ZooKeeper)

Modern Kafka runs without ZooKeeper. One container is enough for the lab:

```bash
docker run -d --name kafka -p 9092:9092 \
  -e KAFKA_CFG_NODE_ID=0 \
  -e KAFKA_CFG_PROCESS_ROLES=controller,broker \
  -e KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=0@localhost:9093 \
  -e KAFKA_CFG_LISTENERS=PLAINTEXT://:9092,CONTROLLER://:9093 \
  -e KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092 \
  -e KAFKA_CFG_CONTROLLER_LISTENER_NAMES=CONTROLLER \
  -e KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT \
  bitnami/kafka:3.7
```

Give it ~10 seconds, then confirm it's up (should list no topics yet):

```bash
docker exec kafka kafka-topics.sh --bootstrap-server localhost:9092 --list
```

## Step 2 — Create the topic (with partitions — the ordering knob)

Create `parcel-events` with 3 partitions. Partitions are where per-key ordering and consumer parallelism come from:

```bash
docker exec kafka kafka-topics.sh --bootstrap-server localhost:9092 \
  --create --topic parcel-events --partitions 3 --replication-factor 1
```

Inspect it — note the partition list and that each has a leader:

```bash
docker exec kafka kafka-topics.sh --bootstrap-server localhost:9092 \
  --describe --topic parcel-events
```

## Step 3 — Produce events (keyed, so order is per-parcel)

Produce a handful of keyed events. The **key** (before the `:`) is the `parcel_id` — Kafka hashes it to a partition, so every event for one parcel lands in the same partition and stays ordered:

```bash
docker exec -i kafka kafka-console-producer.sh --bootstrap-server localhost:9092 \
  --topic parcel-events --property parse.key=true --property key.separator=: <<'EOF'
KC001:created
KC002:created
KC001:picked_up
KC001:at_hub_JKT
KC002:picked_up
KC001:delivered
EOF
```

You just appended six events to the log. Nothing has been "consumed away" — they're all still there.

## Step 4 — Consume from the beginning (proof it's a log, not a queue)

Read the whole topic from offset 0. Because Kafka retains events, you can read them even though they were produced before this consumer existed:

```bash
docker exec kafka kafka-console-consumer.sh --bootstrap-server localhost:9092 \
  --topic parcel-events --from-beginning --property print.key=true \
  --timeout-ms 5000
```

You'll see all six events. Run the **exact same command again** — you get all six *again*. A queue would have emptied. A log lets you **replay**. That single property is why one CDC stream can safely feed both a live dashboard and the lakehouse bronze.

## Step 5 — Two consumer groups read the same log independently

Open the same events under a named group, then again under a *different* group. Each group tracks its own offsets, so both see every event — this is the "dashboard group and bronze-sink group read the same topic, once each" model from the lesson:

```bash
# group A — pretend this is the real-time dashboard
docker exec kafka kafka-console-consumer.sh --bootstrap-server localhost:9092 \
  --topic parcel-events --from-beginning --group realtime-dashboard --timeout-ms 5000

# group B — pretend this is the bronze sink, reading the SAME events
docker exec kafka kafka-console-consumer.sh --bootstrap-server localhost:9092 \
  --topic parcel-events --from-beginning --group bronze-sink --timeout-ms 5000
```

Check each group's committed offsets — proof they progress independently:

```bash
docker exec kafka kafka-consumer-groups.sh --bootstrap-server localhost:9092 \
  --describe --group realtime-dashboard
```

## What you just proved (map it back to the lesson)

| You did | The architecture concept |
|---|---|
| Created a topic with 3 partitions | Partitions = parallelism + per-key ordering; the **key** picks the partition. |
| Produced `KC001:...` keyed events | `key = parcel_id` keeps every event for one parcel **ordered** in one partition. |
| Consumed `--from-beginning` twice | Kafka is a **log, not a queue** — events are retained and **replayable**. |
| Read under two `--group`s | Consumer **groups** read the same log independently — one stream, many uses. |
| Described group offsets | Consumers track **their own offset**; nobody's read position affects another's. |

## Cleanup

```bash
docker stop kafka && docker rm kafka
```

---

**Takeaway:** the mechanics are a 15-minute loop. The architect's value isn't running these commands — it's deciding the **key** (what must stay ordered), the **partition count** (parallelism, not bytes), the **retention** (transport, not system of record), and the **delivery guarantee per use case**. That's the design you ship; this lab just makes it real in your hands.
