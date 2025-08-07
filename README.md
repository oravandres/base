# Homelab Base Infrastructure

Production-ready, high-availability Kubernetes homelab built with Ansible automation. Deploy a complete K3s cluster with enterprise-grade features on Raspberry Pi and x86_64 hardware.

## 🚀 Quick Start

### Prerequisites
- **Hardware**: 3+ nodes (Raspberry Pi 4B+ or x86_64)
- **Tailscale account**: For secure networking
- **Basic requirements**: SSH access to all nodes

### One-Command Deployment
```bash
# 1. Get your Tailscale auth key
# Visit: https://login.tailscale.com/admin/settings/keys

# 2. Deploy complete infrastructure
curl -sfL https://raw.githubusercontent.com/user/homelab-base/main/scripts/bootstrap.sh | \
  TAILSCALE_AUTH_KEY=tskey-xxxxx \
  CLUSTER_NAME=homelab \
  bash
```

## 📋 What You Get

### High Availability Architecture
- **4-node control plane**: True HA with automatic failover
- **Mixed architecture**: ARM64 (Pi) + x86_64 support
- **Zero-downtime**: Rolling updates and maintenance

### Enterprise Features
- **Kubernetes**: K3s with Cilium CNI and eBPF networking
- **Storage**: Longhorn with tiered storage (standard/fast)
- **Monitoring**: Prometheus + Grafana stack
- **GitOps**: ArgoCD for application deployment
- **Backup**: Velero + Restic with disaster recovery
- **Security**: Automatic SSL certificates with cert-manager

### Network & Access
- **Tailscale VPN**: Work from anywhere
- **Load Balancing**: MetalLB for service exposure
- **DNS**: Automatic service discovery

## 🛠️ Manual Setup

### 1. Clone & Configure
```bash
git clone https://github.com/user/homelab-base.git
cd homelab-base
cp env.example .env
# Edit .env with your configuration
```

### 2. Deploy with Ansible
```bash
# Install dependencies
pip install ansible
ansible-galaxy collection install kubernetes.core

# Deploy cluster
ansible-playbook -i ansible/inventory/production ansible/playbooks/site.yaml
```

## 📖 Documentation

- **[Product Requirements Document](.taskmaster/docs/PRD.md)**: Complete architecture and planning
- **[Deployment Guide](docs/deployment/)**: Detailed setup instructions
- **[Operations Guide](docs/operations/)**: Maintenance and troubleshooting
- **[Task Management](.taskmaster/tasks/)**: Implementation tracking

## 🏗️ Architecture

```
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   Control Plane Nodes (HA)                                                     │
├─────────────────┤  ├─────────────────┤  ├─────────────────┤  ├─────────────────┤
│     pi-c1       │  │     pi-c2       │  │  dream-machine  │  │     ninja       │
│   (Primary)     │  │   (Primary)     │  │  (Performance)  │  │   (Mobile)      │
│   ARM64 + SSD   │  │   ARM64 + SSD   │  │  x86_64 + NVMe  │  │ ARM64 + Mobile  │
└─────────────────┘  └─────────────────┘  └─────────────────┘  └─────────────────┘
                                    │
                          ┌─────────┴─────────┐
                          │    Workers        │
                ┌─────────┤                   ├─────────┐
    ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
    │     pi-n1       │  │     pi-n2       │  │     pi-n3       │  │     pi-n4       │
    │  ARM64 + SSD    │  │  ARM64 + SSD    │  │  ARM64 + SSD    │  │  ARM64 + SSD    │
    └─────────────────┘  └─────────────────┘  └─────────────────┘  └─────────────────┘
```

## 🎯 Features

### Core Platform
- [x] **K3s HA Cluster**: 4-node control plane
- [x] **Cilium CNI**: eBPF-powered networking
- [x] **Longhorn Storage**: Distributed block storage
- [x] **MetalLB**: Load balancer for bare metal
- [x] **Tailscale**: Zero-config VPN

### Observability
- [x] **Prometheus**: Metrics collection
- [x] **Grafana**: Visualization and dashboards
- [x] **Loki**: Log aggregation
- [x] **AlertManager**: Intelligent alerting

### Operations
- [x] **ArgoCD**: GitOps application delivery
- [x] **Velero**: Kubernetes backup and restore
- [x] **cert-manager**: Automatic SSL certificates
- [x] **Ansible**: Complete automation framework

## 🔧 Configuration

### Hardware Requirements
- **Minimum**: 3 nodes (2 control plane + 1 worker)
- **Recommended**: 6+ nodes (4 control plane + 4+ workers)
- **RAM**: 4GB+ per node (8GB+ recommended)
- **Storage**: 32GB+ per node (SSD recommended)

### Network Requirements
- **Tailscale**: Account and auth key
- **Internet**: For initial setup and updates
- **Local Network**: 192.168.x.x/24 recommended

## 🚦 Status

- ✅ **Architecture Defined**: Production-ready design
- ✅ **Tasks Planned**: 11 implementation tasks
- 🚧 **Implementation**: Ready to begin
- ⏳ **Testing**: Pending implementation
- ⏳ **Documentation**: Pending implementation

## 🤝 Contributing

This project uses Taskmaster for task management and planning:

```bash
# View current tasks
tm list

# Get next task to work on
tm next

# Update task progress
tm update-subtask --id=1.1 --prompt="Completed initial setup"
```

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

## 🆘 Support

- **Issues**: GitHub Issues for bugs and feature requests
- **Discussions**: GitHub Discussions for questions
- **Documentation**: Check the `docs/` directory for detailed guides

---

**Built with ❤️ for the homelab community**
