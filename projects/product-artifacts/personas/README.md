# Personas

## Purpose
This folder contains your user and buyer personas - the people you're building for.

## What Goes Here

### User Personas
Profiles of the people who use your product:
- Demographics and role
- Goals and motivations
- Pain points and frustrations
- Behavioral patterns
- Jobs-to-be-Done
- Use scenarios

### Buyer Personas (B2B)
Profiles of people involved in purchase decisions:
- **Economic Buyer:** Budget authority (CEO, VP, Department Head)
- **Functional Buyer:** Evaluates day-to-day fit (Manager, PM)
- **Technical Buyer:** Evaluates technical fit (CTO, IT)

### Anti-Personas
Who you're NOT building for - helps maintain focus

## File Format

Save personas as markdown files:
- `persona-[name].md` - Individual persona files
- `personas.md` - Consolidated persona document
- `anti-personas.md` - Users you don't target

## How Skills Use This

Many PM toolkit skills read from this folder to:
- Personalize messaging and positioning
- Design user-appropriate workflows
- Map buying processes
- Understand target segments
- Ground decisions in user needs

**Skills that reference personas:**
- `pm-toolkit/1-strategy/skills/positioning-statement-generator.mdc`
- `pm-toolkit/1-strategy/skills/go-to-market-strategy.mdc`
- `pm-toolkit/2-discovery/skills/persona-generator.mdc`
- `pm-toolkit/5-design/skills/onboarding-flow-designer.mdc`
- And more...

## Getting Started

### Option 1: Generate from Research
Use `@pm-toolkit/2-discovery/skills/persona-generator.mdc` to create data-driven personas from interview transcripts and user research.

### Option 2: Start with Template
Create a `personas.md` file with basic structure:

```markdown
# Persona: [Name]

**Role:** [Job title]
**Company Size:** [SMB / Mid-market / Enterprise]
**Experience Level:** [Beginner / Intermediate / Expert]

## Goals
- [Primary goal]
- [Secondary goal]

## Pain Points
- [Main frustration]
- [Another pain point]

## Jobs-to-be-Done
When [situation], I want to [motivation], so I can [outcome]

## Behaviors
- **Triggers:** [What causes them to engage]
- **Workflow:** [How they work]
- **Frequency:** [How often they use product]
```

## Tips

1. **Keep personas updated** - Personas based on old research lose value
2. **Ground in evidence** - Link each trait to actual research, not assumptions
3. **Focus on behavior** - What users DO matters more than demographics
4. **Make them actionable** - Every trait should inform product decisions
5. **Don't create too many** - 2-4 primary personas is usually enough

## Related
- See `projects/company-context/` for company strategy and OKRs
- See `projects/product-artifacts/` for product roadmap
- See `projects/competitors/` for competitive positioning
