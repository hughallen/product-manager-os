# Cursor for Product Managers 

Welcome to **Cursor for Product Managers**! This repository provides a comprehensive toolkit and framework designed to supercharge your product management workflow using Cursor as an AI-native PM copilot. Originally inspired by the [Maven course on AI-native PMs](https://maven.com/p/0a96cb/cursor-isn-t-just-for-coding-how-ai-native-p-ms-work), the [AI Dev Tasks](https://github.com/snarktank/ai-dev-tasks/tree/main) structured workflow approach, and [Lee Robinson's YouTube video](https://www.youtube.com/watch?v=8QN23ZThdRY), this toolkit transforms Cursor from a coding tool into a powerful product thinking, strategic decision-making, and document creation platform.

Stop wrestling with fragmented product management tools and start building a unified, AI-powered PM workspace that grows smarter with every conversation!

## The Core Idea

Product management involves complex workflows across research, discovery, and delivery. This toolkit aims to bring structure, clarity, and AI-native efficiency to the process by:

1. **Unified Context Management**: Centralizing all PM knowledge, frameworks, and insights in one AI-accessible workspace
2. **Structured Discovery**: Leveraging proven frameworks like Continuous Discovery Habits for systematic user research
3. **AI-Native Workflows**: Using Cursor's capabilities for document-centric work, selective context, and visual diffs
4. **Iterative Improvement**: Building documents that grow smarter with every AI interaction

This approach helps ensure your AI copilot stays on track, makes it easier to manage complex product initiatives, and gives you confidence in AI-generated strategic content.

## Product Development Model

This toolkit supports a **dual-track continuous discovery approach**:

- **🔍 Discovery Track (Continuous):** Weekly user research, opportunity identification, and solution validation
- **🚀 Delivery Track (Sprint-based):** Building and shipping validated solutions in 2-week sprints
- **📊 Analytics & Learning:** Continuous measurement informing both tracks

See `AGENTS.md` for detailed workflow and file organization.

---

## Repository Structure

### AI Configuration
- **AGENTS.md**: Central "README for AI" with behavioral rules, navigation patterns, dual-track workflow, and PM best practices

### PM Toolkit (`pm-toolkit/`)
**All reusable prompts and guides organized by workflow stage**

- **1-strategy/**: Vision, strategy review, OKRs, strategic planning
- **2-discovery/**: User research, opportunity identification (Continuous Discovery Habits framework)
- **3-planning/**: PRDs, one-pagers, specifications
- **4-prioritization/**: ICE scoring, prioritization frameworks
- **5-design/**: Design briefs, wireframes, design reference library
- **6-delivery/**: Task generation, handoffs to all teams
- **7-experimentation/**: Experiment frameworks (placeholder)
- **8-analytics/**: Quick insights, data analysis
- **9-evals/**: AI evaluation tools (placeholder)
- **supporting/**: Cross-cutting tools (meetings, writing, team structure)

See [`pm-toolkit/README.md`](pm-toolkit/README.md) for detailed tool catalog.

### Projects (`projects/`)
**Your continuous work and active initiatives**

- **initiatives/**: Active product initiatives with dual-track structure
  - `_templates/`: Template for new initiatives with discovery + delivery tracks
  - `[initiative-name]/`: Your active initiatives
  - `archive/`: Completed initiatives
- **product-artifacts/**: Product-level artifacts
  - `roadmap/`: Quarterly roadmaps and strategic planning
  - `backlog/`: Engineering and discovery backlogs
  - `feedback/`: Centralized customer feedback and themes
- **company-context/**: Your company documentation
  - `strategy/`: Your actual strategy documents
  - `okrs/`: Your actual OKRs and goals
  - `team/`: Your team structure and org chart
- **meetings/**: Meeting notes
  - `1-1 notes/`: One-on-one documentation
  - `leadership/`: Leadership team notes
  - `product-trio/`: PM-Design-Engineering collaboration
  - `board-n-investor/`: Board and investor meetings

See [`projects/README.md`](projects/README.md) for workflow guidance.

> Tip: When referencing files in Cursor, use the exact path names above.

## Quick Start

1. **Clone this repository** to your local workspace
2. **Read `AGENTS.md`** - This onboards AI to your workspace (AI reads this automatically)
3. **Browse `pm-toolkit/`** - Explore tools by workflow stage
4. **Customize your context:**
   - Add company strategy to `projects/company-context/strategy/`
   - Add your OKRs to `projects/company-context/okrs/`
   - Customize `pm-toolkit/1-strategy/pm-strategic-copilot.mdc`
5. **Start using tools:**
   - Create initiative: `@projects/initiatives/_templates/setup-new-initiative.mdc`
   - Generate PRD: `@pm-toolkit/3-planning/create-prd.mdc`
   - Analyze data: `@pm-toolkit/8-analytics/quick-insights.mdc`
   - Create handoffs: `@pm-toolkit/6-delivery/handoffs/`

##  How to Use

### 1️. Setup Your AI-Native PM Workspace

First, ensure you have Cursor installed and these framework files accessible:

1. Clone or download this repository to your local workspace
2. In Cursor's Agent chat, reference files with `@` (e.g., `@pm-toolkit/2-discovery/continuous-discovery-habits/create-interview-snapshots.mdc`)
3. Browse tools by workflow stage in `pm-toolkit/`
4. Work on active initiatives in `projects/initiatives/`

### 2️. Leverage AI Dev Tasks Framework

This toolkit integrates with the [AI Dev Tasks](https://github.com/snarktank/ai-dev-tasks/tree/main) structured workflow for complex product initiatives:

1. **Create PRDs**: Use AI to generate comprehensive Product Requirement Documents
2. **Break Down Tasks**: Decompose PRDs into actionable, granular task lists
3. **Iterative Implementation**: Guide AI through one task at a time with verification checkpoints
4. **Progress Tracking**: Visual representation of completed tasks and next steps

### 3️. Document-Centric Workflow

Instead of chat-based interactions, work directly in documents that grow smarter:

- **Selective Context**: Provide only necessary information to AI for focused assistance
- **Visual Diffs**: Clearly see AI-generated content changes and modifications
- **Continuous Learning**: Documents improve with every AI interaction and iteration

## Common Workflows

### 1. Strategy (Quarterly)
- **Review Strategy**: `@pm-toolkit/1-strategy/product-strategy-review.mdc`
- **Evaluate Vision**: `@pm-toolkit/1-strategy/product-vision-review.mdc`
- **Coach OKRs**: `@pm-toolkit/1-strategy/okr-sparring-partner.mdc`

### 2. Discovery (Weekly)
- **User Interviews**: `@pm-toolkit/2-discovery/continuous-discovery-habits/create-interview-snapshots.mdc`
- **Synthesize Research**: `@pm-toolkit/2-discovery/continuous-discovery-habits/synthesize-interview-snapshots.mdc`
- **Identify Opportunities**: `@pm-toolkit/2-discovery/continuous-discovery-habits/create-opportunities.mdc`
- **Generate Solutions**: `@pm-toolkit/2-discovery/continuous-discovery-habits/generate-solutions.mdc`

### 3. Planning
- **Create PRD**: `@pm-toolkit/3-planning/create-prd.mdc`
- **Create One-Pager**: `@pm-toolkit/3-planning/create-1-pager.mdc`

### 4. Prioritization
- **Score Ideas**: `@pm-toolkit/4-prioritization/calculate-ice-score.mdc`

### 5. Design
- **Design Brief**: `@pm-toolkit/5-design/create-design-brief.mdc`
- **Figma Prompts**: `@pm-toolkit/5-design/generate-figma-make-prompt.mdc`
- **ASCII Wireframes**: Ask AI to generate on-the-fly

### 6. Delivery
- **Break Down Tasks**: `@pm-toolkit/6-delivery/generate-tasks.mdc`
- **Process Tasks**: `@pm-toolkit/6-delivery/process-task-list.mdc`
- **Handoffs**: `@pm-toolkit/6-delivery/handoffs/to-[audience].mdc`

### 8. Analytics
- **Quick Insights**: `@pm-toolkit/8-analytics/quick-insights.mdc`

### Initiative Management
- **Start New Initiative**: `@projects/initiatives/_templates/setup-new-initiative.mdc`
- **Browse toolkit by stage**: See `pm-toolkit/README.md`


## Acknowledgments

- **[Cursor isn't just for coding: how AI-native PMs work](https://maven.com/p/0a96cb/cursor-isn-t-just-for-coding-how-ai-native-p-ms-work)** - Tal Raviv and Hilary Gridley's course on transforming Cursor into a PM AI copilot
- **[AI Dev Tasks](https://github.com/snarktank/ai-dev-tasks/tree/main)** - Structured workflow framework for AI-assisted development that inspired our PM workflow approach
- **[Cursor AI Agents Work Like 10 Developers (Cursor VP Live Demo)](https://www.youtube.com/watch?v=8QN23ZThdRY)** - Lee Robinson demonstrates how Cursor AI agents automate developer tasks.

- **[Continuous Discovery Habits](https://www.youtube.com/watch?v=9RFaz9ZBXpk)** - Teresa Torres' framework on continuous discovery
- **[Evidence-Guided](https://www.youtube.com/watch?v=aJWSn-tz3jQ)** - Itamar Gilad's framework on evidence-guided product development

---

Happy AI-assisted product managing! 
