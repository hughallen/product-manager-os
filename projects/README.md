# Projects

## Overview
This folder contains all your active, continuous product management work - as opposed to the reusable toolkit.

## Structure

### `initiatives/`
**Purpose:** Active product initiatives and projects

**What lives here:**
- Individual initiative folders (created with `@setup-new-initiative.mdc`)
- Each initiative follows dual-track structure (discovery + delivery)
- Archived initiatives in `archive/`

**Key files:**
- `_templates/` - Template structure for new initiatives
- `[initiative-name]/` - Your active initiatives

**Example workflow:**
1. Create new initiative: Use `@pm-toolkit/setup-new-initiative.mdc`
2. Work within initiative: Follow dual-track model (discovery + delivery)
3. Archive when complete: Move to `archive/`

---

### `product-artifacts/`
**Purpose:** Product-level artifacts spanning multiple initiatives

**What lives here:**
- `roadmap/` - Quarterly roadmaps, strategic plans
- `backlog/` - Engineering and discovery backlogs
- `feedback/` - Centralized customer feedback and themes

**Key documents:**
- Roadmaps showing what's coming
- Prioritized backlog of validated work
- Feedback themes informing discovery

**Example workflow:**
1. **Roadmap:** Plan quarterly based on strategy and feedback
2. **Backlog:** Validated ideas ready for implementation
3. **Feedback:** Collect, synthesize, connect to opportunities

---

### `company-context/`
**Purpose:** Your actual company documentation (not tools, but your org's docs)

**What lives here:**
- `strategy/` - Your company's strategy documents
- `okrs/` - Your actual OKRs and goals
- `team/` - Your team structure and org chart

**Note:** This is YOUR company's context. The *tools* to create these live in `pm-toolkit/1-strategy/`

**Example workflow:**
1. Create strategy docs using `@pm-toolkit/1-strategy/` tools
2. Save completed docs here in `strategy/`
3. Reference them when making product decisions

---

### `meetings/`
**Purpose:** Meeting notes and documentation

**What lives here:**
- `1-1 notes/` - One-on-one meeting documentation
- `leadership/` - Leadership team meeting notes
- `product-trio/` - PM-Design-Engineering collaboration notes
- `board-n-investor/` - Board and investor meeting documentation

**Example workflow:**
1. Use `@pm-toolkit/supporting/1-1s.mdc` for meeting structure
2. Save notes here by date/topic
3. Reference when tracking action items and decisions

---

## The Toolkit vs. Projects Mental Model

**Think of it this way:**

```
pm-toolkit/     →  Your library of reusable tools (like a toolbox)
projects/       →  Your active work and continuous projects (like your workbench)
```

- **Toolkit = Reusable** - Frameworks, guides, templates you use repeatedly
- **Projects = Your Work** - Specific initiatives, roadmaps, meetings, company docs

---

## Typical Workflow

### Weekly Discovery
1. Conduct user interviews
2. Save snapshots to `projects/initiatives/[name]/interviews/snapshots/`
3. Synthesize findings using `@pm-toolkit/2-discovery/` tools
4. Update opportunities in `projects/initiatives/[name]/opportunities/`

### Sprint Planning
1. Review backlog in `product-artifacts/backlog/`
2. Pull validated work into sprint
3. Create tasks using `@pm-toolkit/6-delivery/generate-tasks.mdc`
4. Track progress in `projects/initiatives/[name]/tasks/`

### Quarterly Planning
1. Review strategy in `company-context/strategy/`
2. Analyze feedback themes in `product-artifacts/feedback/`
3. Update roadmap in `product-artifacts/roadmap/`
4. Align with OKRs in `company-context/okrs/`

---

## Best Practices

### Organization
- **One initiative = one folder** - Keep everything for an initiative together
- **Archive completed work** - Move to `archive/` when done
- **Date your artifacts** - Use YYYY-MM-DD format in file names
- **Link between folders** - Reference related docs across projects

### Naming Conventions
- **Initiatives:** `initiative-name` (kebab-case)
- **Files:** `artifact-name-YYYY-MM-DD.md`
- **Meetings:** `meeting-type-YYYY-MM-DD.md`

### .gitignore
Consider adding `projects/` to `.gitignore` if:
- You want to share the toolkit publicly without your work
- Your company docs contain sensitive information
- You prefer to keep work separate from the toolkit

---

## Adding New Projects

When starting new work:
1. **For initiatives:** Use `@pm-toolkit/setup-new-initiative.mdc`
2. **For roadmap updates:** Add to `product-artifacts/roadmap/`
3. **For feedback:** Log in `product-artifacts/feedback/`
4. **For meetings:** Save notes to appropriate `meetings/` subfolder

---

**Remember:** This is where your continuous work happens. The toolkit provides the tools; projects is where you do the work!
