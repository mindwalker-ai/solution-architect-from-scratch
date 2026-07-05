# Lab — DevStack sandbox: *see* a private-cloud control plane

> **Purpose:** stand up a single-node OpenStack once, so a private cloud stops being an abstraction. You are an architect, **not** an operator — the goal is to *log into the control plane and recognize the primitives* (compute, network, storage, identity) from The Concept, then tear it down. ~30–45 min of mostly-waiting.

**This lab validates one claim:** a private cloud is the *same cloud model* as public — self-service compute/network/storage/identity — just on hardware you (would) own. DevStack is the throwaway install the OpenStack project ships for exactly this.

## What you need

- One **throwaway Linux VM** (Ubuntu LTS is the documented default). A cloud free-tier VM, a local `multipass launch`, or any spare box works.
- Give it a comfortable amount of RAM and a couple of vCPUs — DevStack runs the whole control plane on one host, so it's heavier than a normal VM. Check the current minimum in the [DevStack docs](https://docs.openstack.org/devstack/latest/) rather than trusting a number here.
- **Do not** run this on a machine you care about. DevStack takes over networking and services; it is meant to be destroyed after.

## Stand it up (copy-run)

```bash
# 1. On the throwaway VM, create a non-root 'stack' user (DevStack refuses to run as root)
sudo useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
sudo -u stack -i          # become the stack user

# 2. Grab DevStack
git clone https://opendev.org/openstack/devstack
cd devstack

# 3. Minimal config — set a password so you can log into the dashboard
cat > local.conf <<'EOF'
[[local|localrc]]
ADMIN_PASSWORD=devstacklab
DATABASE_PASSWORD=$ADMIN_PASSWORD
RABBIT_PASSWORD=$ADMIN_PASSWORD
SERVICE_PASSWORD=$ADMIN_PASSWORD
EOF

# 4. Build it. This pulls and configures Keystone, Nova, Neutron, Cinder, Glance, Horizon.
#    Expect a long, chatty run — go get coffee.
./stack.sh
```

When `stack.sh` finishes it prints the **Horizon** dashboard URL and the `admin` credentials.

## What to look at (the architect's 10 minutes)

Log into **Horizon** and find each control-plane service from the lesson's Mermaid diagram — this is the whole point of the lab:

| In Horizon, open… | You are looking at… | Public-cloud equivalent |
|---|---|---|
| **Project → Compute → Instances** | **Nova** — launch a tiny VM from a Glance image | EC2 / Compute Engine / Azure VMs |
| **Project → Network → Networks** | **Neutron** — self-service virtual networks/subnets | VPC / VNet |
| **Project → Volumes** | **Cinder** — attachable block storage | EBS / Persistent Disk |
| **Identity → Projects / Users** | **Keystone** — tenants, users, roles (IAM) | IAM / Entra ID |

Launch one micro instance, attach a volume, note that you did it **self-service through an API/portal** — that is the line between "a private cloud" and "a virtualized data center where you file a ticket." Then you're done.

## Tear it down

```bash
# From the devstack dir, as the stack user:
./unstack.sh && ./clean.sh
# Or just delete the throwaway VM — the cleanest option.
```

## What this lab is NOT

- **Not** how you'd run production OpenStack (that's a multi-node HA control plane a platform team operates — out of scope at architect altitude).
- **Not** a performance or sizing exercise — DevStack is a functional demo, single-node, non-HA.
- **Not** required to complete the lesson's deliverable. The **[Private-vs-Public Decision Matrix](../outputs/template-private-vs-public-matrix.md)** is the shippable artifact; this lab just makes the "private cloud" box on your diagram concrete so you can speak about it with confidence in the room.
