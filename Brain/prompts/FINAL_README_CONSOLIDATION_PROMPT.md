# Final README Consolidation Prompt

Objective: Produce ONE consolidated, sales-ready `README.md` that replaces duplicative content across `README.md`, `INSIGHTS.md`, and `BOT_PROPOSAL.md`. Preserve the full level of detail (findings narratives, KPIs, risk matrices, roadmaps, methodology, sources, examples) but eliminate redundancy (no repeated paragraphs across sections). This can be long; optimize for clarity and non-duplication, not brevity.

Non‑negotiables (must keep):
- Preserve a full Q&A section answering the business questions from the test.
- Preserve an explicit BOT Proposal section (condensed but complete and actionable).
- Cover every requirement in `Brain/task.md` (items 1–8 and Presentation Deliverables), with clear traceability.

Inputs:
- Current `README.md`
- Current `INSIGHTS.md` (Findings #1–#5, visuals references)
- Current `BOT_PROPOSAL.md`
- Optional references: images in `outputs/visualizations/findings/`

Output:
- New root-level `README.md` (overwrite existing) with:
  1) Title + Hero value proposition (2–3 lines)
  2) Executive Summary (bulleted, < 150 words)
  3) Clickable Navigation (anchor links)
  4) Key Metrics Snapshot (concise table)
  5) Q&A Section (required by test):
     - Q1 Which product has more TPV? (chart)
     - Q2 How do weekdays increase/decrease TPV? (chart)
     - Q3 Which has the biggest average ticket? (chart)
     - Q4 Which anticipation method is more used by each entity? (chart)
     - Q5 Installments Analysis (2 charts)
     - Q6 Price Tier Analysis (2 charts)
  6) Top 3 Strategic Findings (keep full detail without duplication): narrative, insights bullets, 1–2 charts, 30/60/90 mini‑roadmap table, KPIs list, compact risk matrix, plus references to Installments/Price Tier where relevant
  7) Action Plans & Timelines (30/60/90, consolidated table with KPIs and owners/placeholders)
  8) BOT Proposal (required by test): purpose, architecture/workflow, sample alerts (≥3), costs, resources, KPIs, SLAs, and examples (retain rich content but avoid repeating paragraphs already present elsewhere)
  9) Quick-Start for Evaluators (checklist + how to regenerate visuals)
  10) Methodology & Sources (PIX URLs, 4.5x method) and Risk summary
  11) Footer: Last Updated line preserved

Rules:
- Eliminate repeated paragraphs. Keep ONE clear explanation per idea.
- Prefer bullets, tables, and short paragraphs; max 6–8 lines per subsection.
- Retain numeric proofs (TPV, growth, 22% P2B benchmark) with citations.
- Keep image references stable; do not duplicate images.
- Use anchors with short descriptions: `[#executive-summary]`, `[#q-and-a]`, `[#findings]`, `[#action-plans]`, `[#ai-ops-bot]`, `[#methods]`, `[#structure]`.
- Make it presentation-ready: scanning first, detail on click.

Writing guidelines (very important):
- Clear, natural, non‑robotic language. No filler. Active voice.
- Avoid excessive emojis; none required. Use plain text headings and short, sharp bullets.
- Avoid marketing hype; state concrete outcomes, KPIs, and timelines.
- Keep a consistent tone across sections. Use the same terms as the data fields.
- Keep full detail but avoid duplication: when content appears in multiple sources, select the best phrasing once and reference it with anchors.
- Each major section begins with a short narrative (3–6 lines), followed by the full supporting bullets/tables/figures for that section.
- Prefer canonical tables and figures; do not repeat the same figure twice.

Detailed Section Spec

1. Title + Hero
- One-liner: “CloudWalk Operational Intelligence: Q1 2025 → Strategy, Execution, and AI Ops”.
- Subline: “From data to action in 30/60/90 days”.

2. Executive Summary (<150 words)
- 3 bullets for market context; 3 bullets for findings; 3 bullets for actions.

3. Navigation
- Bulleted anchor links to all major sections and appendices.

4. Key Metrics Snapshot (table)
- TPV, Growth, Approval, Denial, PF share, PIX share, Peak hours, Product concentration.

5. Q&A (must map to `Brain/task.md` points 1–6)
- Provide direct, one‑paragraph answers and include the chart immediately below each.
- Keep answers consistent with the dataset and previously computed metrics.

6. Top 3 Findings (full detail, no redundancy)
- F1: PF + Weekend (2–3 bullets) + one chart link
- F2: PIX Instant Suite (2–3 bullets) + one chart link
- F3: Anticipation → Working Capital (2–3 bullets) + one chart link
- For each finding add:
  - Short narrative (3–6 lines)
  - 6–10 bullets with insights (deduplicated from prior docs)
  - 1–2 charts (previously created images)
  - 30/60/90 mini‑roadmap table (rows ≤ 6)
  - KPI list (include baselines/targets where available)
  - Compact risk matrix (3–7 rows)

7. Action Plans & Timelines (table)
- Columns: Priority | Action | Owner (placeholder) | KPIs | Timeline

8. BOT Proposal (full but deduplicated)
  - 7–10 bullets covering features and workflow; architecture bullets; link to 3AM anomaly chart
  - ≥3 sample alerts (low TPV, segment underperforming, avg‑ticket anomaly) with short templates
  - Cost range, required roles (team), SLAs, KPIs, and a concise ROI framing
  - Include daily summary, growth comparisons (DoD, WoW, MoM), and low TPV/avg‑TPV alerts examples.

9. Quick-Start for Evaluators
- 4-step checklist + `python scripts/generate_all_visualizations.py` note

10. Methodology & Sources
- Expanded bullets: dataset fields used; PIX citations with URLs; 4.5x method paragraph with assumptions; external benchmarks; caveats/limitations.

11. Appendix (optional if already covered above)
- A1 Installments (1–2 bullets) + 2 figures
- A2 Price Tier (1–2 bullets) + 2 figures
- A3 Risk matrices (link to INSIGHTS risk tables; keep brief)

12. Footer
- `Last Updated: October 30, 2025 | Version: 3.0 - Restructured for Input-Processing-Output clarity`

Acceptance Criteria
- The new README keeps the full level of detail (length not capped) but has zero redundant paragraphs.
- No duplicated paragraphs across sections.
- All existing visuals still referenced; no broken links.
- Q&A answers all requirements in `Brain/task.md` (points 1–6) with charts.
- BOT Proposal covers all requirements in `Brain/task.md` (point 8) with examples.
- All critical claims have citations or are linked to Methodology & Sources.
- Section anchors work in GitHub/VS Code previews.

Navigation specification (improve look and clarity):
- Render a bulleted ToC immediately after Executive Summary with one‑line descriptions per section.
- Optionally add a single‑line “pills” row: `Q&A • Findings • Action Plans • BOT • Methods • Structure` beneath the ToC.
