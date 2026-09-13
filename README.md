# AuditBridge

An agentic reviewer that catches compliance violations in Terraform pull requests before they're ever deployed.

AuditBridge closes the gap between IaC scanners like Checkov — which flag problems but don't explain them to anyone outside engineering — and compliance platforms like Vanta or Drata — which explain problems to auditors but only after the resource is already live. Reasoning runs on an NVIDIA Nemotron model served through Nebius, grounded in a RAG index of compliance frameworks and live regulatory lookups via Tavily. Every finding ships with both the fixed Terraform code and a plain-language, control-mapped narrative a compliance officer can drop straight into an audit file.

Built for the Nebius x NVIDIA Global AI Hackathon.

## Status

Early scaffolding — see the build plan for the current milestone. Not yet functional end-to-end.

## Architecture (planned)

- **Static analysis** — Checkov scans a Terraform pull request and produces structured findings.
- **RAG grounding** — findings are matched against an embedded index of PCI-DSS, SOC 2 CC controls, and AWS Well-Architected guidance.
- **Agentic reasoning** — a LangGraph graph takes the finding + retrieved control text and calls an NVIDIA Nemotron model (served via Nebius) to reason about the fix, behind a thin `ModelProvider` interface so the inference backend can be swapped without touching agent logic.
- **Live lookups** — Tavily fills in for low-confidence or fast-moving compliance questions the static RAG index doesn't cover.
- **Output** — a real GitHub pull request carrying the fixed Terraform code and an audit-grade narrative (finding / control mapped / risk / remediation / evidence).

## Repository layout

- `src/auditbridge/` — application code (providers, agent graph, RAG index, GitHub automation).
- `test-infra/terraform/` — a throwaway Terraform stack with deliberately planted misconfigurations, used as the target for local testing and for the PR-automation demo.

## Setup

Setup instructions will be filled in as each component lands (Nebius/Tavily credentials, Python environment, running the agent against `test-infra/terraform/`).

## License

MIT — see [LICENSE](LICENSE).
