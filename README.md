# AuditBridge

An agentic reviewer that catches compliance violations in Terraform pull requests before they're ever deployed.

AuditBridge closes the gap between IaC scanners — which flag problems but don't explain them to anyone outside engineering — and compliance platforms which explain problems to auditors but only after the resource is already live. Reasoning runs on an NVIDIA Nemotron model served through Nebius, grounded in a RAG index of compliance frameworks and live regulatory lookups via Tavily. Every finding ships with both the fixed Terraform code and a plain-language, control-mapped narrative a compliance officer can drop straight into an audit file.


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

The Terraform stack with deliberately planted misconfigurations, used as the target for local testing and the PR-automation demo, lives in a separate repo (`AuditBridge-test-infra`, not yet pushed to GitHub). Keeping it separate means the demo's PR automation opens real pull requests against a target repo, the way it would against any real user's infrastructure, instead of committing demo branches into this tool's own history.

## Setup

Copy `.env.example` to `.env` and fill in your Nebius, Tavily, and LangSmith credentials — `auditbridge` loads `.env` automatically on import, so no further wiring is needed. LangSmith tracing (free tier) is enabled purely via env vars: once `LANGCHAIN_TRACING_V2` and `LANGCHAIN_API_KEY` are set, every LangChain/LangGraph run traces automatically at [smith.langchain.com](https://smith.langchain.com).

Further setup instructions will be filled in as each component lands (Python environment, running the agent against `test-infra/terraform/`).

## License

MIT — see [LICENSE](LICENSE).
