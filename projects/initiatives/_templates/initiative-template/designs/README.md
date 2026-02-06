# Design Artifacts

## Purpose
This folder contains design briefs, wireframes, mockups, and design specifications for this initiative.

## What Goes Here
- **Design briefs** - Created with `@create-design-brief.mdc`
- **ASCII wireframes** - Quick text-based layouts for iteration
- **Mockups and screenshots** - Visual designs and prototypes
- **Design specs** - Detailed design specifications
- **Links to Figma/design tools** - References to external design files

## Creating Designs

### ASCII Wireframes (Rapid Iteration)
Ask AI to generate ASCII wireframes for quick concepts:
```
"Create an ASCII wireframe for a [feature description]"
```

Benefits:
- Instant generation
- Easy to iterate
- Great for team discussions
- No design tools needed

### Design Briefs
Use `@pm-toolkit/5-design/create-design-brief.mdc` to create comprehensive design briefs that include:
- Problem definition
- User context and journey
- Design requirements
- Constraints and success criteria

### Design References
Can reference `@pm-toolkit/5-design/design-reference-library/` for:
- Existing design patterns
- Component guidelines
- Consistency with product

## Naming Convention
- `design-brief-[feature].md` - Design briefs
- `wireframe-[feature]-[variation].txt` - ASCII wireframes
- `mockup-[feature]-[version].png` - Visual mockups
- `figma-links.md` - Links to Figma files

## Workflow

1. **Create design brief** → Use `@create-design-brief.mdc`
2. **Rapid iteration** → Generate ASCII wireframes for concepts
3. **High-fidelity design** → Create mockups in design tools
4. **Handoff** → Use `@pm-toolkit/6-delivery/handoffs/to-engineering.mdc` when ready

## Related Guides
- `@pm-toolkit/5-design/create-design-brief.mdc` - Design brief creation
- `@pm-toolkit/5-design/generate-figma-make-prompt.mdc` - Figma prompt generation
- `@pm-toolkit/6-delivery/handoffs/to-design.mdc` - Handoff to design team
