# Code Optimization Prompts - SCPO Vibecoding

## ⚡ Performance Analysis & Optimization

### SCPO_PERFORMANCE_PROFILE

```
ROLE: Performance Engineer
TASK: Profile [CODE_COMPONENT] for bottlenecks
CONSTRAINTS: Real-world scenarios, measurable improvements, maintainable solutions

PROFILING_ANALYSIS:
## Current Performance Baseline
- Execution time: [benchmark_results]
- Memory usage: [memory_footprint]
- CPU utilization: [processor_load]
- I/O operations: [database/network_calls]

## Bottleneck Identification
### Primary Bottleneck: [ISSUE_NAME]
- Location: [file:line or function]
- Impact: [performance_cost]
- Frequency: [how_often_executed]
- Root cause: [technical_explanation]

### Secondary Issues
- [List 2-3 other performance impacts]

## Optimization Options

### Option A: [OPTIMIZATION_NAME]
**Implementation:**
- Technical approach: [specific_changes]
- Code complexity: [LOW/MEDIUM/HIGH]
- Development time: [estimate]

**Trade-offs:**
- Performance gain: [quantified_improvement]
- Maintenance burden: [ongoing_complexity]
- Memory impact: [increase/decrease]
- Risk level: [LOW/MEDIUM/HIGH]

### Option B: [ALTERNATIVE_APPROACH]
**Implementation:**
- Technical approach: [specific_changes]
- Code complexity: [LOW/MEDIUM/HIGH]
- Development time: [estimate]

**Trade-offs:**
- Performance gain: [quantified_improvement]
- Maintenance burden: [ongoing_complexity]
- Memory impact: [increase/decrease]
- Risk level: [LOW/MEDIUM/HIGH]

**RECOMMENDATION:** [Option A/B] because [reasoning based on context]
**MONITORING:** Key metrics to track post-optimization
```

### SCPO_ALGORITHM_OPTIMIZATION

````
ROLE: Algorithm Specialist
TASK: Optimize algorithm efficiency for [ALGORITHM_TYPE]
CONSTRAINTS: Maintain correctness, improve time/space complexity

ALGORITHMIC_ANALYSIS:
## Current Implementation
- Time complexity: O([current_complexity])
- Space complexity: O([current_space])
- Input size handling: [scalability_limits]

## Optimization Strategies
### Strategy 1: [APPROACH_NAME]
- New complexity: O([improved_complexity])
- Implementation changes: [key_modifications]
- Trade-offs: [what_we_give_up]

### Strategy 2: [ALTERNATIVE_APPROACH]
- New complexity: O([improved_complexity])
- Implementation changes: [key_modifications]
- Trade-offs: [what_we_give_up]

## Code Comparison
```javascript
// Before (O(n²))
function inefficientSolution(data) {
  // [current_implementation]
}

// After (O(n log n))
function optimizedSolution(data) {
  // [optimized_implementation]
}
````

**BENCHMARK:** Performance improvement on typical dataset sizes
**VALIDATION:** How to ensure correctness is maintained

```

### SCPO_DATABASE_OPTIMIZATION
```

ROLE: Database Performance Tuner
TASK: Optimize database queries for [APPLICATION_AREA]  
CONSTRAINTS: Maintain data integrity, minimize query complexity

QUERY_OPTIMIZATION:

## Slow Query Analysis

### Query: [QUERY_DESCRIPTION]

```sql
-- Original Query (Execution time: Xms)
SELECT [original_query]
```

**Issues Identified:**

- Missing indexes: [table.column]
- N+1 queries: [relationship_loading]
- Unnecessary JOINs: [table_relationships]
- Large result sets: [pagination_missing]

## Optimization Solutions

### Option A: Index Optimization

```sql
-- Add strategic indexes
CREATE INDEX idx_[table]_[columns] ON [table]([columns]);
-- Estimated improvement: X% faster
```

### Option B: Query Restructuring

```sql
-- Optimized Query (Target time: Yms)
SELECT [optimized_query]
```

**Implementation Plan:**

1. Backup current performance metrics
2. Apply indexes in staging environment
3. Test query performance and plan changes
4. Deploy with rollback strategy

**MONITORING:** Query execution times, index usage stats

```

### SCPO_CACHING_OPTIMIZATION
```

ROLE: Caching Specialist
TASK: Implement caching strategy for [PERFORMANCE_BOTTLENECK]
CONSTRAINTS: Cache invalidation strategy, memory efficiency

CACHING_STRATEGY:

## Cache Implementation

### Cache Layer: [REDIS/MEMCACHED/APPLICATION]

- Key pattern: [cache_key_structure]
- TTL strategy: [time_to_live_logic]
- Size limits: [memory_constraints]

### Cache-Aside Pattern

```javascript
async function getCachedData(key) {
  // Check cache first
  let data = await cache.get(key);
  if (!data) {
    // Cache miss - fetch from source
    data = await fetchFromDatabase(key);
    await cache.set(key, data, TTL);
  }
  return data;
}
```

## Cache Invalidation

### Strategies:

- Time-based: [TTL_duration] for [data_types]
- Event-based: Invalidate on [specific_events]
- Manual: Admin controls for [cache_categories]

### Cache Warming

- Preload: [frequently_accessed_data]
- Background refresh: [refresh_schedule]

**PERFORMANCE IMPACT:** Expected hit ratio and response time improvement
**MONITORING:** Cache hit/miss rates, memory usage, invalidation frequency

```

## 🔍 Code Quality & Refactoring

### SCPO_CODE_REFACTORING
```

ROLE: Senior Developer
TASK: Refactor [CODE_SECTION] for better maintainability
CONSTRAINTS: Preserve functionality, improve readability, reduce complexity

REFACTORING_PLAN:

## Code Smells Identified

1. **[SMELL_NAME]:** [description_and_location]

   - Impact: [maintenance_difficulty]
   - Frequency: [how_often_modified]

2. **[SMELL_NAME]:** [description_and_location]
   - Impact: [maintenance_difficulty]
   - Frequency: [how_often_modified]

## Refactoring Strategies

### Extract Method

```javascript
// Before: Long method with multiple responsibilities
function complexFunction() {
  // [complex_logic_block_1]
  // [complex_logic_block_2]
  // [complex_logic_block_3]
}

// After: Broken into focused methods
function mainFunction() {
  const step1Result = handleStep1();
  const step2Result = handleStep2(step1Result);
  return handleStep3(step2Result);
}
```

### Eliminate Duplication

- Duplicate code locations: [file_references]
- Extraction target: [shared_function_or_class]
- Reusability scope: [where_else_applicable]

**TESTING STRATEGY:** Ensure behavior unchanged with comprehensive test coverage
**ROLLOUT:** Incremental refactoring with regular integration

```

### SCPO_ARCHITECTURE_REVIEW
```

ROLE: Software Architect  
TASK: Review architecture of [SYSTEM_COMPONENT] for scalability
CONSTRAINTS: Identify coupling issues, suggest decoupling strategies

ARCHITECTURE_ANALYSIS:

## Current Structure

- Components: [list_main_components]
- Dependencies: [component_relationships]
- Data flow: [how_information_moves]

## Issues Identified

### Tight Coupling

- Location: [specific_classes_or_modules]
- Problem: [why_this_is_problematic]
- Impact: [maintenance_and_scaling_difficulties]

### Single Responsibility Violations

- Component: [component_name]
- Multiple responsibilities: [list_what_it_does]
- Suggested split: [how_to_separate_concerns]

## Improvement Recommendations

### Dependency Injection

```javascript
// Before: Hard dependencies
class OrderService {
  constructor() {
    this.paymentService = new PaymentService();
    this.emailService = new EmailService();
  }
}

// After: Injected dependencies
class OrderService {
  constructor(paymentService, emailService) {
    this.paymentService = paymentService;
    this.emailService = emailService;
  }
}
```

### Interface Segregation

- Define focused interfaces for [component_interactions]
- Reduce coupling through [abstraction_strategy]

**MIGRATION PATH:** Step-by-step refactoring plan with minimal risk

```

## 🚀 Scalability & Performance

### SCPO_LOAD_TESTING
```

ROLE: Performance Test Engineer
TASK: Design load testing strategy for [SYSTEM_UNDER_TEST]
CONSTRAINTS: Realistic user patterns, identify breaking points

LOAD_TEST_DESIGN:

## Test Scenarios

### Scenario 1: Normal Load

- Concurrent users: [baseline_user_count]
- Request pattern: [user_behavior_simulation]
- Duration: [test_length]
- Success criteria: [response_time_thresholds]

### Scenario 2: Peak Load

- Concurrent users: [peak_user_count]
- Request pattern: [peak_behavior_simulation]
- Duration: [sustained_peak_time]
- Success criteria: [degraded_but_acceptable_performance]

### Scenario 3: Stress Test

- Load progression: Gradual increase until failure
- Breaking point identification: [resource_exhaustion_signs]
- Recovery testing: [system_behavior_after_overload]

## Monitoring During Tests

### Application Metrics

- Response times: [percentile_measurements]
- Throughput: [requests_per_second]
- Error rates: [acceptable_error_thresholds]

### System Metrics

- CPU usage: [percentage_limits]
- Memory consumption: [memory_leak_detection]
- Database performance: [query_response_times]

**TOOLS:** [Load_testing_framework] with [monitoring_stack]
**REPORTING:** Performance baseline establishment and bottleneck identification

```

### SCPO_HORIZONTAL_SCALING
```

ROLE: Scalability Engineer  
TASK: Design horizontal scaling strategy for [APPLICATION_TYPE]
CONSTRAINTS: Stateless design, load distribution, data consistency

SCALING_ARCHITECTURE:

## Load Balancing

### Strategy: [ROUND_ROBIN/LEAST_CONNECTIONS/WEIGHTED]

- Health checks: [endpoint_monitoring]
- Session handling: [sticky_sessions_or_stateless]
- Failover: [automatic_instance_replacement]

## Instance Management

### Auto-scaling Rules

```yaml
scaling_policy:
  min_instances: 2
  max_instances: 10
  scale_up_threshold: CPU > 70% for 5 minutes
  scale_down_threshold: CPU < 30% for 15 minutes
  cooldown_period: 10 minutes
```

### Container Orchestration

- Platform: [KUBERNETES/DOCKER_SWARM/ECS]
- Resource limits: [CPU_and_memory_constraints]
- Rolling deployments: [zero_downtime_strategy]

## Data Layer Scaling

### Database Scaling

- Read replicas: [replication_strategy]
- Connection pooling: [pool_configuration]
- Cache layer: [distributed_caching]

### Session Storage

- Shared session store: [REDIS/DATABASE]
- Session serialization: [data_format_and_size]

**MONITORING:** Instance health, auto-scaling events, distributed tracing
**COST OPTIMIZATION:** Right-sizing instances, spot instances usage

```

---

*These optimization prompts are designed for maximum token efficiency while providing comprehensive performance improvement strategies. Each follows SCPO principles of structured analysis and actionable recommendations.*
```
