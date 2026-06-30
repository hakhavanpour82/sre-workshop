🟢 SRE Workshop: 
Automated GitOps CI/CD Infrastructure PipelineThis repository hosts a production-grade, fully automated GitOps continuous deployment pipeline. 
Every commit pushed to the main branch triggers an automated lifecycle: 
validating configuration code formatting, injecting secure remote environment authentication wrappers, and executing atomic workload deployments straight onto a remote Kubernetes (K3s) cluster hosted on a Hetzner Cloud server.
The project workspace is fully integrated with a WSL (Ubuntu) local terminal inside VS Code, establishing a complete, decoupled development-to-production ecosystem.

🏗️ Project Architecture & LayoutThe project enforces the core DevOps principle of Separation of Concerns. 
Infrastructure provisioning, configuration management, and application lifecycles are decoupled into isolated subdirectories to minimize blast radius risks:
bash
sre-workshop/
├── .github/workflows/
│   └── deploy.yml      # GitHub Actions: Native linting, context injections, & atomic applies
├── k8s/
│   ├── deployment.yml  # Kubernetes Workloads: Dual-replica Nginx engine with rigid memory barriers
│   ├── service.yml     # Kubernetes Network: ClusterIP discovery routing abstraction layer
│   └── kubeconfig      # Cluster Context: Local backup connection target configuration
└── ansible/
    ├── inventory.ini   # System Maps: Target host infrastructure operational records
    └── site.yml        # Configuration Management: Server OS baseline health guidelines

🛠️ Tech Stack & Automation Flow[ WSL Terminal ] ──(git push)──> [ GitHub Repository ]
                                         │
                                (GitHub Actions Runner)
                                         │
                                ├── Step 1: Install & Run Native YAML Lint
                                ├── Step 2: Set up K8s Context (Secrets Injection)
                                └── Step 3: Atomic Workload Deployment
                                         │
                                    (Port 6443)
                                         ▼
                             [ Hetzner Cloud K3s Cluster ]

Local Sandbox (WSL / VS Code): 
Used as the local development workspace to compose, test, and commit declarative configurations.

Source of Truth (GitHub Engine): 
Acts as the single central ledger tracking the desired operational state of the architecture.

Continuous Integration (Native Linting): 
Runs native, automated Linux static code analysis (yamllint) on the GitHub runner to catch syntax anomalies before execution.

Continuous Delivery (GitOps Engine): 
Dynamically injects secure context maps to execute seamless deployments directly over the secure Kubernetes management API port (6443).

Target Cluster Runtime (Hetzner Cloud K3s): 
Host nodes processing live, self-healing containerized environments.

🚀 Key SRE Principles ImplementedShift-Left Testing (Fail-Fast Pattern): 
By running inline syntax linting steps at the absolute start of the pipeline execution tree, syntax errors are caught in seconds before reaching live clusters.

Immutable Version Pinning: 
Pipeline actions are tightly pinned to exact semantic release versions (actions/checkout@v4.2.2, azure/k8s-set-context@v4.0.2) to eliminate runtime engine variation and protect against breaking upstream changes.

Deterministic Secret Isolation: 
Critical authentication files (kubeconfig) are kept out of plain-text tracking repositories and injected via encrypted platform secrets (${{ secrets.KUBECONFIG }}).

Strict Resource Boundaries: 
Containers are guarded by rigid hardware allocations (limits and requests) to proactively insulate host kernels against malicious memory leaks or accidental CPU saturation.

⚙️ Quick Start & Local Verification
To audit or check the real-time operational status of your architecture from your WSL terminal, invoke the following system validation tracks:
1. Synchronize Your Local Copy with the Upstream Statebashcd /mnt/e/sre-workshop
    git pull origin main
2. Verify Your Active Infrastructure Targetsbashkubectl get deployments,services,pods -o wide --namespace default
3. Check Live Workload Footprints and Cluster Healthbashkubectl describe pod -l app=web-service

🗣️ SRE Interview Highlight Notes
When presenting this architecture to technical interviewers, emphasize these core troubleshooting experiences gained during implementation:

Debugging Context Mismatches: 
Handled and resolved cluster timeouts (dial tcp 127.0.0.1:443: connect: connection refused) by identifying local-loopback API configuration drifts and swapping them out for public remote endpoint definitions over port 6443.

Mitigating Node.js Platform Upgrades: 
Bypassed automated platform deprecations by structuring runner variable injections (FORCE_JAVASCRIPT_ACTIONS_TO_NODE24) to guarantee non-breaking pipeline compilation cycles.

Resolving Git Divergence Conflicts: 
Responded to out-of-band manual changes ([rejected] main -> main (fetch first)) by applying clean 
git pull --rebase actions, 
keeping the repository commit history perfectly linear, clear, and traceable.
