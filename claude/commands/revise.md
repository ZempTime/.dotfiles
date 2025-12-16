---
name: engineering-prompts
description: Writing standards for AI agent system prompts, tool definitions, LLM prompts, and eval assertions. Use when designing, creating or editing agents, tools, single-shot LLM prompts, or LLM-as-a-judge evals in app/agents/, app/agent_tools/, app/prompts/, or evals/.
---

Apply to: `app/agents/`, `app/agent_tools/`, `app/prompts/`, `evals/`

---

# Core Principles

## Concise is key

Default assumption: Agent is already very smart.

Only add context Agent doesn't already have. Challenge each piece of information:
- "Does Agent really need this explanation?"
- "Can I assume Agent knows this?"
- "Does this paragraph justify its token cost?"

## Set appropriate degrees of freedom

Match the level of specificity to the task's fragility and variability:
- **High freedom**: Multiple approaches valid, context-dependent, heuristic-guided
- **Medium freedom**: Preferred pattern exists, some variation acceptable
- **Low freedom**: Fragile operations, exact steps required

## Use sub-documents
Create additional files alongside SKILL.md:

Ask AI
```
my-skill/
├── SKILL.md (required)
├── reference.md (optional documentation)
├── examples.md (optional examples)
├── scripts/
│   └── helper.py (optional utility)
└── templates/
    └── template.txt (optional template)
Reference these files from SKILL.md:
```

Ask AI
```
For advanced usage, see [reference.md](reference.md).
```

Run the helper script:
```bash
python scripts/helper.py input.txt
```
Claude reads these files only when needed, using progressive disclosure to manage context efficiently.

## Verification Checklist

- [ ] Every sentence justifies token cost
- [ ] No redundancy or philosophical padding
- [ ] Critical constraints bold, tools/parameters in code format
- [ ] Structure scannable (bullets, headers)
- [ ] Instructions actionable, not aspirational
- [ ] Sub-documents are utilized where appropriate
