---
title: Product Manager OS - Vision and Core Concepts
category: Product Vision
tags: [PM, AI-agents, productivity, workflow, automation, side-project]
created_date: 04-02-2026
updated_date: 06-02-2026
status: In Development
related_to: Vibe code productivity tooling goal
---

# Product Manager OS - Vision and Core Concepts

## Overview

Building a Product Manager OS that goes beyond simple prompt libraries to create an agentic workflow system for product management processes.

### Progress Summary

**✅ Foundation Complete:** Comprehensive workflow-based toolkit with dual-track continuous discovery structure, 60+ PM tools organized across 9 stages, agent memory system, and extensive handoff guides.

**🔄 Current Phase:** Transitioning from prompt-based tools to autonomous agent orchestration.

**🎯 Vision:** Full agent automation with tool integrations, adaptive learning, and active thought partnership.

---

# CURRENT STATE: What's Implemented

## Repository Structure

### PM Toolkit (`pm-toolkit/`)
**Reusable tools organized by 9 workflow stages:**

1. **Strategy** - Vision, strategy review, OKRs, strategic planning
2. **Discovery** - User research, opportunity identification (Continuous Discovery Habits framework)
3. **Planning** - PRDs, one-pagers, specifications
4. **Prioritization** - ICE scoring, prioritization frameworks
5. **Design** - Design briefs, wireframes, design reference library
6. **Delivery** - Task generation, handoffs to all teams
7. **Experimentation** - Experiment frameworks (placeholder)
8. **Analytics** - Quick insights, data analysis
9. **Evals** - AI evaluation tools (placeholder)
10. **Supporting** - Cross-cutting tools (meetings, writing, team structure)

### Projects (`projects/`)
**Active work and continuous initiatives:**

- **initiatives/** - Dual-track structure (discovery + delivery)
  - `.agent-memory/` - Context, decisions, next steps tracking
  - `interviews/` - User research (transcripts, snapshots, synthesis)
  - `opportunities/` - Identified needs
  - `solutions/` - Solution ideas
  - `assumptions/` - Tests and validation
  - `specs/` - PRDs and requirements
  - `designs/` - Design work
  - `tasks/` - Implementation tracking
  - `data/` - Analytics and metrics

- **product-artifacts/** - Product-level work
  - `roadmap/` - Quarterly roadmaps
  - `backlog/` - Engineering and discovery backlogs
  - `feedback/` - Centralized customer feedback

- **company-context/** - Company documentation
  - `strategy/` - Strategy documents
  - `okrs/` - Goals and OKRs
  - `team/` - Team structure

- **meetings/** - Meeting notes (1-1s, leadership, product trio, board)

### AI Configuration
- **AGENTS.md** - Central "README for AI" with behavioral rules, navigation patterns, dual-track workflow, and PM best practices

## Implemented Capabilities

### ✅ Workflow-Based Organization
- All PM tools organized by workflow stage
- Clear separation between reusable tools and active work
- Stage-specific README files for navigation

### ✅ Dual-Track Continuous Discovery
- **Discovery Track (Continuous):** Weekly user research, opportunity identification, solution validation
- **Delivery Track (Sprint-based):** Building and shipping validated solutions
- **Analytics:** Continuous measurement informing both tracks

### ✅ Initiative Templates
- Complete dual-track folder structure
- Agent memory system (`.agent-memory/`)
- Setup automation (`setup-new-initiative.mdc`)

### ✅ Handoff Guides
Comprehensive templates for:
- Engineering handoffs
- Design collaboration
- Leadership updates
- Sales enablement
- Marketing launches
- Customer success

### ✅ Framework Integration
- **Continuous Discovery Habits** (Teresa Torres)
  - Interview snapshots
  - Synthesis documents
  - Opportunity mapping
  - Solution generation
  - Assumption testing
- **Evidence-Guided** (Itamar Gilad)
  - ICE scoring
  - Prioritization frameworks

### ✅ Quick Analysis Tools
- 30-second data insights with ASCII visualizations
- CSV analysis and pattern recognition
- User feedback synthesis

### ✅ Design Reference Library
- Placeholder structure for design patterns
- On-the-fly ASCII wireframe generation
- Design brief templates

### ✅ Context Management
- Organized folder structure for AI accessibility
- Persistent memory within initiatives
- Cross-reference capability between documents

## Current Limitations

### 🚧 Not Yet Implemented
- Full agent automation (still prompt-based)
- Tool integrations (Jira, Figma, analytics)
- Learning and adaptation
- Multi-step process orchestration
- Active thought partnership (requires manual prompting)

### 📝 Placeholders
- Experimentation frameworks (7-experimentation/)
- AI evaluation tools (9-evals/)
- Some company context folders (empty)

---

# FUTURE VISION: Where We're Going

## Core Concept: Beyond Prompts to Agents

### Traditional Approach (What NOT to do)
- Static prompts and skills
- Manual execution of PM processes
- Disconnected tools and workflows
- One-shot interactions

### Product Manager OS Approach (The Vision)
**Not just functions/skills (prompts), but agents that run specific processes**

Key principles:
1. **Agent-driven processes** - Agents execute complete PM workflows, not just respond to prompts
2. **Prompt composition** - Agents combine multiple prompts/skills to handle complex processes
3. **Colleague handoff** - Agents can prepare work for handoff to human colleagues
4. **Thought partnership** - Agents act as active thought partners throughout product processes

## Use Cases

### Agent as Process Runner
Instead of: "Here's a prompt for writing a PRD"
Product Manager OS: Agent that runs the entire PRD creation process:
- Gathers context from previous docs
- Asks clarifying questions
- Combines problem definition + solution design + impact modeling
- Produces complete PRD ready for review

### Agent as Thought Partner
Instead of: "Here's how to run discovery"
Product Manager OS: Agent that partners through discovery:
- Suggests research questions based on problem space
- Helps analyze findings
- Identifies patterns and contradictions
- Recommends next steps in discovery process

### Agent as Handoff Coordinator
Instead of: "Here's a template to share with engineering"
Product Manager OS: Agent that prepares work for handoff:
- Compiles relevant context from multiple sources
- Formats for specific audience (engineering, design, leadership)
- Identifies gaps or questions
- Creates actionable next steps for recipient

### Agent as Design Generator
Instead of: "Here's a wireframe template"
Product Manager OS: Agent that creates design files based on reference library:
- Reads design reference library (patterns, components, best practices)
- Understands existing design system and patterns
- Generates new design specs that follow established patterns
- Ensures consistency with existing product design
- Creates well-structured designs based on best practices
- Outputs design files ready for designer refinement

## Technical Architecture

### Components
1. **Prompt Library** - Core skills and templates (foundation)
2. **Process Definitions** - PM workflows broken into steps
3. **Agent Layer** - Orchestrates prompts + processes + context
4. **Memory System** - Maintains context across interactions
5. **Design Reference Library** - Folder of design references, patterns, and best practices
6. **Integration Layer** - Connects to tools (Jira, Figma, analytics, etc.)

### Agent Capabilities
- **Sequential execution** - Run multi-step processes
- **Prompt chaining** - Combine multiple prompts intelligently
- **Context awareness** - Remember previous conversations and decisions
- **Adaptive behavior** - Adjust approach based on feedback
- **Human-in-the-loop** - Know when to ask for input vs. proceed
- **Design pattern recognition** - Read design references and apply patterns to new features
- **Consistency enforcement** - Ensure new designs follow established best practices
- **Design pattern recognition** - Read design references and apply patterns to new features
- **Consistency enforcement** - Ensure new designs follow established best practices

## Design Reference Library Concept

### How It Works
1. **Library Structure**
   - Organized folder of design references
   - Existing designs, patterns, components
   - Best practice guides
   - Design system documentation
   - UI patterns and conventions

2. **Agent Reads References**
   - Understands design patterns
   - Learns component usage
   - Recognizes consistency rules
   - Identifies best practices

3. **Agent Generates New Designs**
   - Creates design files for new features
   - Follows established patterns
   - Uses approved components
   - Maintains visual consistency
   - Applies best practices automatically

4. **Output**
   - Well-structured design files
   - Consistent with existing product
   - Ready for designer refinement
   - Includes rationale for design decisions

### Benefits
- **Consistency** - New features automatically follow established patterns
- **Speed** - Start with design that's 80% correct vs. blank canvas
- **Best practices** - Built-in guardrails prevent common design mistakes
- **Scalability** - Design quality doesn't depend on individual PM knowledge
- **Documentation** - Design decisions explained based on references

### Example Use Case
**Creating a new dashboard feature:**
1. PM describes feature requirements
2. Agent reads design reference library
3. Agent identifies relevant patterns (dashboard layouts, card designs, navigation)
4. Agent generates design file with:
   - Layout following dashboard pattern
   - Cards using established component
   - Navigation consistent with existing UI
   - Spacing, colors, typography matching design system
5. Designer reviews and refines (not starting from scratch)

### Technical Implementation Note
**Model Selection:** Gemini 3 is the best at visual design generation. For the design reference agent and design file generation capabilities, Gemini 3 should be the primary model used to ensure high-quality visual output and pattern recognition.

## Differentiation

### vs. Prompt Libraries (ChatGPT, Claude)
- Not just one-shot prompts
- Maintains process state
- Active orchestration of workflows

### vs. PM Tools (Jira, ProductBoard)
- Not just task management
- Active intelligence and guidance
- Thought partnership, not just tracking

### vs. Generic AI Assistants
- PM-specific processes and knowledge
- Understands product workflows
- Tailored for PM decision-making

### vs. Traditional Design Systems
- Not just static documentation
- Active generation of new designs
- Applies patterns automatically
- Learns and adapts from references

## Product Processes to Automate

### Discovery & Research
- User interview analysis
- Competitive analysis synthesis
- Problem space exploration
- Opportunity sizing

### Strategy & Planning
- Vision/strategy development
- Roadmap creation
- Prioritization frameworks
- OKR development

### Execution
- PRD writing
- Sprint planning support
- Stakeholder communication
- Launch planning
- **Design file generation** (NEW)

### Design & Specification
- **Design reference library management**
- **Pattern-based design generation**
- **Design consistency checking**
- **Component usage recommendations**
- **Design system evolution**

### Analysis & Iteration
- Metrics analysis
- A/B test evaluation
- Retrospectives
- Impact assessment

## Key Insights

1. **PMs need processes, not just prompts** - Single prompts don't capture the iterative nature of PM work

2. **Agents enable true automation** - Move from "AI helps me write" to "AI runs the process"

3. **Context is critical** - Agents must understand project history, team dynamics, company goals

4. **Handoff is a feature** - Not everything needs to be AI-complete; preparing work for humans is valuable

5. **Thought partnership > Task completion** - Best use is collaborative problem-solving, not just output generation

6. **Design consistency is scalable** - Agent that reads design references ensures new features follow established patterns without manual checking

7. **Reference library = AI design system** - Design references become the foundation for AI-generated, consistent designs

## Roadmap

### ✅ Phase 0: Foundation (COMPLETED)
   - ✅ Created AGENTS.md (README for AI)
   - ✅ Organized context: pm-toolkit/ and projects/ structure
   - ✅ Defined best practices and behavioral rules
   - ✅ Implemented dual-track workflow organization
   - ✅ Built initiative templates with agent memory
   - ✅ Created comprehensive handoff guides
   - ✅ Integrated Continuous Discovery Habits framework

### 🔄 Phase 1: Core Process Agents (IN PROGRESS)
Current state: Prompt-based tools (manual invocation)
Next: Agent-driven automation

   - 🚧 PRD agent (currently: PRD creation prompt)
   - 🚧 Discovery synthesis agent (currently: synthesis prompt with ASCII visualization)
   - 🚧 Prioritization agent (currently: ICE scoring prompt)
   - 🚧 Design reference agent (currently: design brief + ASCII wireframing prompts)
   - ✅ Data analysis agent (30-second insights with ASCII charts)

**Next Step:** Convert prompts to autonomous agents that orchestrate multi-step processes

### 📋 Phase 2: Design System Integration (PLANNED)
   - Build out Design Reference Library structure
   - Include ASCII patterns for rapid ideation
   - Agent reads and understands design patterns
   - Generate design files based on references (using Gemini 3)
   - Parallel prototyping with worktrees/branches
   - Ensure consistency across new features

### 📋 Phase 3: Integration Layer (PLANNED)
   - Connect to PM tools (Jira, Linear, etc.)
   - Connect to design tools (Figma, etc.)
   - Connect to data sources (analytics, user research)
   - Pull context automatically
   - Push outputs to right places
   - MCP integrations (Model Context Protocol)

### 📋 Phase 4: Learning & Adaptation (PLANNED)
   - Learn from user feedback
   - Adapt to team-specific workflows
   - Evolve design patterns based on usage
   - Build personalized PM OS
   - Continuous improvement of AGENTS.md

### Open Questions
- [ ] Which PM process to start with? (PRD writing? Discovery? Design generation?)
- [ ] How to handle company-specific processes?
- [ ] Balance between automation and human oversight?
- [ ] Integration strategy - which tools first?
- [ ] How to structure design reference library? (Format, organization, versioning?)
- [ ] How much design refinement should agent do vs. hand off to designer?
- [ ] How to handle design system evolution and updates?
- [ ] Pricing/business model?

### Technical Decisions
- ✅ **Design model:** Use Gemini 3 for visual design generation (best performance)
- ✅ **General purpose:** Claude Opus 4.5 for complex reasoning
- ✅ **Fast iteration:** Gemini 3 Flash for quick tasks
- ✅ **Context organization:** Implemented pm-toolkit/ and projects/ structure
- ✅ **AI onboarding:** AGENTS.md with dual-track workflow and behavioral rules
- ✅ **Workflow stages:** 9-stage organization (Strategy → Evals)
- ✅ **Dual-track structure:** Separate discovery and delivery tracks in initiatives
- ✅ **Agent memory:** Persistent context tracking within initiatives
- [ ] Validation: Implement linters and tests for self-verification
- [ ] Multi-model strategy: When to use which model for specific agents?
- [ ] MCP integrations: Priority order for tool connections?

## Implementation Patterns from Cursor for PMs

### Key Workflow Patterns (Source: [Cursor for Product Managers](https://amankhan1.substack.com/p/cursor-for-product-managers))

**1. Data Analysis Workflow (30 seconds)**
- Upload user feedback/data (CSVs, etc.)
- Ask for high-level takeaways with ASCII visualizations
- Get: Top complaints by frequency, 2x2 matrices, user journey maps
- **Application to PM OS:** Quick analysis agent for user research, metrics, feedback

**2. Brainstorming with Context**
- AGENTS.md file = "README for your AI" (onboarding document)
- Include: codebase overview, product features, folder structure, specs, research links, behavioral rules
- Ask for feature gaps and UX designs
- **Generate ASCII wireframes** (hundreds per day without Figma)
- **Application to PM OS:** Design Reference Library can include ASCII patterns

**3. Parallel Prototyping**
- Use worktrees (branches) for parallel development
- Run multiple agents simultaneously on different features
- Test and merge what works
- **Application to PM OS:** Multiple design explorations in parallel

### The New PM Workflow: Prompt, Evaluate, Iterate

**Old way:** Waterfall with standups
1. PM writes spec
2. Designer mocks in Figma
3. Engineers sprint for weeks
4. QA catches bugs
5. Ship after two months

**New way:** Overlapping roles
- Designers ship code
- PMs build prototypes
- Engineers do product thinking
- Everyone is technical
- Venn diagrams of responsibilities overlap

### Critical Success Factors

**1. Organize Context FOR AI**
```
/specs       - Requirements documents
/interviews  - User research
/data        - Analytics, CSVs
/designs     - Design references (Design Reference Library)
```

**2. Give AI Validation Tools**
- Linters catch syntax errors
- Tests verify AI's own work
- Code review catches what was missed
- TDD (Test-Driven Development) = acceptance criteria for AI

**3. Embed Expertise in AGENTS.md**
Best practices inheritance:
- "Add complexity only when justified"
- "Simple code is easier to maintain"
- "Always edit existing files instead of creating new ones"
- Design patterns and conventions
- Company-specific processes

**4. Use Plan Mode**
- Restricts tool access until approval
- Like a kickoff meeting with engineer
- Aligns implicit wants → explicit instructions
- Review before execution

### Model Selection Notes
- **Claude Opus 4.5** - General purpose
- **Gemini 3 Flash** - Fast iteration
- **Gemini 3** - Visual design (best performance for design generation)

### Why This Matters for PM OS

**Problem with ChatGPT:**
- "PhD with memory of a hamster"
- Forgets between sessions
- No context on user, codebase, research

**Solution: Cursor = ChatGPT with:**
1. **Files** - Docs, markdown, spreadsheets, PDFs, code
2. **External data** - Google Drive, Notion, Figma, Jira, Linear
3. **Persistent workflows** - Repeatable tasks through files

**PM OS Advantage:**
- Design Reference Library = persistent visual memory
- Process definitions = persistent workflow memory
- AGENTS.md = persistent behavioral rules
- All context organized FOR the AI

### ASCII Wireframing Insight
**Game-changer:** AI can generate ASCII wireframes instantly
- No need to open Figma for initial explorations
- Hundreds of concepts per day
- Fast iteration before high-fidelity design
- **Application to PM OS:** Design Reference Library could include ASCII patterns as lightweight references

### Validation: "You can't feel a spec, but you can feel the UI"
- Prototypes are cheaper than ever
- Explore 10 ideas before committing to one
- Working prototype beats detailed spec
- **Application to PM OS:** Rapid design generation from Design Reference Library enables this

## Related Insights
- [[ide-artifacts-proximity-insight.md]] - Artifacts in IDE concept applies to PM OS
- Connection to "vibe code productivity tooling" goal
- Builds on Personal OS learnings
- Cursor for PMs article: Parallel prototyping, AGENTS.md pattern, ASCII wireframing

## Potential Value Proposition

**For PMs:**
- Faster execution of routine processes
- Better thought partnership on complex decisions
- Reduced cognitive load on process execution
- More time for strategic thinking

**For Teams:**
- Consistent PM practices
- Better documentation
- Clearer handoffs
- Improved cross-functional communication

**For Companies:**
- Scalable PM excellence
- Reduced ramp time for new PMs
- More strategic PM capacity
- Better product outcomes


