# Specs - Delivery Track

**Purpose:** Requirements documents for validated solutions ready to build

---

## Folder Contents

```
specs/
└── planning/             # Strategic planning docs (moved from root)
    ├── activation-improvement-plan.md
    └── experiment-ideas.md
```

---

## Current State

**Status:** Planning docs created but need revision

**Issue:** Plans assume Persona 1 (Beginner) has activation problem without data validation

**Fix Needed:** Reframe as conditional scenarios:
- IF data shows Persona 1 is problem, THEN [these solutions]
- IF data shows Persona 3 is problem, THEN [these solutions]
- IF data shows multiple personas, THEN [prioritization approach]

---

## When to Create PRDs

Per AGENTS.md workflow:
1. **Discovery validates opportunity** (interviews/, opportunities/)
2. **Solutions explored and tested** (solutions/, assumptions/)
3. **Data shows problem + solution-market fit**
4. **THEN create PRD** using `@pm-toolkit/3-planning/create-prd.mdc`

**Current:** Still in discovery/validation phase - PRDs premature until data analysis done

---

## Next Steps

1. Complete data analysis to determine which persona
2. Revise activation-improvement-plan.md to be data-dependent
3. Revise experiment-ideas.md to be hypothesis-driven
4. After interview: Create actual PRDs for validated solutions
