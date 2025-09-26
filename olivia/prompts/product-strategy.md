# Product Strategy Prompts - SCPO Vibecoding

## 🎯 Product Vision & Strategy

### SCPO_PRODUCT_VISION

```
ROLE: Senior Product Strategist
TASK: Define clear product vision for [APP_TYPE]
CONSTRAINTS: Solo dev/small team, realistic scope, measurable outcomes

OUTPUT_FORMAT:
1. VALUE_PROPOSITION: One sentence describing unique value
2. USER_PAINS: 3 core problems this solves
3. FEATURE_ROADMAP:
   - MVP: 3 essential features
   - V2: 2 advanced features
4. SUCCESS_METRICS:
   - Launch: 2 key metrics
   - Growth: 2 long-term metrics

OPTIMIZATION: Focus on validation over perfection. Prioritize user feedback loops.
```

### SCPO_MVP_DEFINITION

```
ROLE: Product Manager
TASK: Define MVP scope for [PRODUCT_CONCEPT]
CONSTRAINTS: 3-month timeline, single developer, limited budget

ANALYSIS_FRAMEWORK:
1. CORE_VALUE: What's the one thing users can't live without?
2. ASSUMPTIONS: List 3 biggest risks to validate
3. FEATURE_CUTS: What can wait for V2?
4. SUCCESS_CRITERIA: How do we know if MVP works?

OUTPUT: Prioritized feature list with effort estimates (S/M/L)
```

### SCPO_COMPETITIVE_ANALYSIS

```
ROLE: Market Research Analyst
TASK: Analyze competitive landscape for [PRODUCT_CATEGORY]
CONSTRAINTS: Focus on differentiation opportunities, not feature parity

STRUCTURE:
1. DIRECT_COMPETITORS: 3 main players
   - Strengths, weaknesses, pricing
2. INDIRECT_COMPETITORS: Adjacent solutions users might choose
3. WHITE_SPACE: Underserved user segments or use cases
4. DIFFERENTIATION: Our unique positioning angle

TOKENS_SAVED: Skip lengthy company histories, focus on actionable insights
```

### SCPO_USER_PERSONAS

```
ROLE: UX Researcher
TASK: Create focused user personas for [TARGET_MARKET]
CONSTRAINTS: Data-driven, actionable, not demographic fiction

PERSONA_TEMPLATE:
## [PERSONA_NAME] - [JOB_TITLE]
- GOALS: What they want to achieve
- FRUSTRATIONS: Current solution pain points
- BEHAVIORS: How they currently solve this problem
- SUCCESS_METRICS: How they measure progress

LIMIT: 2-3 personas maximum. Quality over quantity.
```

### SCPO_MONETIZATION_STRATEGY

```
ROLE: Business Strategist
TASK: Design monetization strategy for [PRODUCT_TYPE]
CONSTRAINTS: Sustainable for indie dev, user-friendly, scalable

REVENUE_MODELS:
1. PRIMARY: Main revenue stream with pricing rationale
2. SECONDARY: Additional income sources
3. FREEMIUM_BALANCE: What's free vs paid
4. PRICING_PSYCHOLOGY: Why users will pay this amount

VALIDATION: How to test pricing before full launch
```

## 🚀 Go-to-Market Strategy

### SCPO_LAUNCH_PLAN

```
ROLE: Growth Marketer
TASK: Create 90-day launch plan for [PRODUCT_NAME]
CONSTRAINTS: Organic growth focus, minimal ad spend, content-driven

TIMELINE:
## Pre-Launch (30 days)
- Week 1-2: [SPECIFIC_ACTIONS]
- Week 3-4: [SPECIFIC_ACTIONS]

## Launch (30 days)
- Week 1: Launch day tactics
- Week 2-4: Momentum maintenance

## Post-Launch (30 days)
- Optimization based on data
- Feature iteration priorities

SUCCESS_METRICS: Downloads, engagement, retention rates
```

### SCPO_CONTENT_STRATEGY

```
ROLE: Content Strategist
TASK: Build content strategy for [PRODUCT_LAUNCH]
CONSTRAINTS: Solo creator, authentic voice, value-first approach

CONTENT_PILLARS:
1. EDUCATIONAL: Solve user problems (40%)
2. PRODUCT: Features and updates (20%)
3. COMMUNITY: User stories and wins (25%)
4. PERSONAL: Behind-the-scenes, lessons (15%)

DISTRIBUTION:
- Primary channel: [PLATFORM]
- Secondary: [PLATFORM]
- Repurposing strategy across formats

CADENCE: Realistic posting schedule you can maintain
```

## 📊 Validation & Metrics

### SCPO_VALIDATION_EXPERIMENTS

```
ROLE: Lean Startup Coach
TASK: Design validation experiments for [HYPOTHESIS]
CONSTRAINTS: Low cost, fast turnaround, clear success criteria

EXPERIMENT_DESIGN:
1. HYPOTHESIS: We believe [ASSUMPTION]
2. TEST: We will [SPECIFIC_ACTION]
3. METRIC: We will measure [SPECIFIC_METRIC]
4. CRITERIA: Success means [SPECIFIC_THRESHOLD]
5. TIMELINE: Results expected in [TIMEFRAME]

BUDGET: Under $100 per experiment
LEARNING: What will this tell us about user behavior?
```

### SCPO_ANALYTICS_SETUP

```
ROLE: Product Analytics Expert
TASK: Define analytics strategy for [PRODUCT_LAUNCH]
CONSTRAINTS: Privacy-first, actionable metrics only, simple setup

KEY_METRICS:
## Acquisition
- Traffic sources and conversion rates
- Cost per user by channel

## Activation
- Onboarding completion rate
- Time to first value

## Retention
- Daily/Weekly/Monthly active users
- Feature usage patterns

## Revenue
- Conversion to paid
- Customer lifetime value

TOOLS: Recommend 2-3 privacy-focused analytics tools
```

## 💡 Innovation & Ideation

### SCPO_FEATURE_BRAINSTORM

```
ROLE: Innovation Facilitator
TASK: Generate feature ideas for [PRODUCT_AREA]
CONSTRAINTS: Think outside the box but stay feasible

IDEATION_METHOD:
1. CURRENT_STATE: How users solve this now
2. PAIN_POINTS: What frustrates them most
3. DREAM_SCENARIO: Perfect world solution
4. CONSTRAINTS: Technical/business limitations
5. CREATIVE_SOLUTIONS: 10 ideas bridging dream and reality

EVALUATION: Rate each idea on Impact (1-5) and Effort (1-5)
```

### SCPO_TREND_ANALYSIS

```
ROLE: Technology Trend Analyst
TASK: Identify opportunities in [INDUSTRY/TECH_AREA]
CONSTRAINTS: Focus on actionable trends, not hype

TREND_EVALUATION:
## Emerging Trend: [TREND_NAME]
- ADOPTION_STAGE: Early/Growth/Mature
- OPPORTUNITY_WINDOW: How long do we have?
- BARRIERS_TO_ENTRY: What's stopping others?
- MONETIZATION_POTENTIAL: Revenue opportunities
- RISK_FACTORS: What could go wrong?

RECOMMENDATION: Pursue, monitor, or skip with reasoning
```

---

_These prompts are designed for maximum token efficiency while generating comprehensive strategic outputs. Each follows SCPO principles of structured thinking and actionable results._
