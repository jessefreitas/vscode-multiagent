# Backend Architecture Prompts - SCPO Vibecoding

## 🏗️ System Design & Architecture

### SCPO_DATABASE_SCHEMA

```
ROLE: Backend Architect
TASK: Design normalized relational schema for [APP_TYPE]
CONSTRAINTS: 3-5 tables, optimized for performance and scaling

SCHEMA_OUTPUT:
## Table: [TABLE_NAME]
| Field | Type | Constraints | Relationships |
|-------|------|-------------|---------------|
| id | UUID | PRIMARY KEY | - |
| [field] | [type] | [constraints] | [FK to table.field] |

## Relationships
- [Table1] → [Table2]: [relationship_type] ([foreign_key])
- [Table2] → [Table3]: [relationship_type] ([foreign_key])

## Indexes
- [table].[field]: [B-tree/Hash] for [use_case]
- [composite_index]: [fields] for [query_pattern]

OPTIMIZATION: Focus on query patterns, not theoretical perfection
```

### SCPO_API_ARCHITECTURE

````
ROLE: API Architect
TASK: Design RESTful API structure for [SYSTEM_TYPE]
CONSTRAINTS: RESTful conventions, consistent patterns, scalable

API_STRUCTURE:
## Core Resources
### [Resource] (/api/v1/[resources])
- GET /{id} - Retrieve single item
- GET / - List with pagination/filtering
- POST / - Create new item
- PUT /{id} - Update existing item
- DELETE /{id} - Remove item

## Nested Resources
- GET /[parent]/{id}/[children] - Related items

## Request/Response Format
```json
{
  "success": boolean,
  "data": object|array,
  "meta": { "pagination", "filters" },
  "errors": []
}
````

AUTHENTICATION: JWT/API Key strategy
RATE_LIMITING: Requests per minute by tier

```

### SCPO_MICROSERVICES_DESIGN
```

ROLE: Solutions Architect
TASK: Break monolith into microservices for [DOMAIN]
CONSTRAINTS: Domain-driven design, minimal network calls, data consistency

SERVICE_BREAKDOWN:

## Service: [SERVICE_NAME]

- RESPONSIBILITY: Single clear purpose
- DATA_OWNERSHIP: Which entities it manages
- APIS_EXPOSED: External interfaces
- DEPENDENCIES: Other services it calls
- SCALING_NEEDS: Expected load patterns

## Communication Patterns

- SYNCHRONOUS: API calls for real-time needs
- ASYNCHRONOUS: Events for eventual consistency
- SHARED_DATA: What data crosses boundaries

DEPLOYMENT: Docker containers, orchestration strategy

```

### SCPO_CACHING_STRATEGY
```

ROLE: Performance Engineer
TASK: Design caching strategy for [APPLICATION_TYPE]
CONSTRAINTS: Cost-effective, simple to maintain, significant performance gain

CACHE_LAYERS:

## Application Cache (Redis/Memcached)

- USER_SESSIONS: 30min TTL
- API_RESPONSES: [endpoints] with [TTL]
- COMPUTED_DATA: [expensive_operations] with [invalidation_strategy]

## Database Cache

- QUERY_CACHE: Most frequent SELECT statements
- CONNECTION_POOLING: [pool_size] connections

## CDN Cache

- STATIC_ASSETS: [file_types] with [TTL]
- API_RESPONSES: [cacheable_endpoints] with [TTL]

INVALIDATION: When and how to clear stale data
MONITORING: Cache hit rates and performance metrics

```

## 🔐 Security & Authentication

### SCPO_AUTH_SYSTEM
```

ROLE: Security Architect
TASK: Design authentication system for [APP_TYPE]
CONSTRAINTS: Secure, user-friendly, scalable, compliance-ready

AUTH_FLOW:

## Registration

1. Email validation → Confirmation link
2. Password requirements: [CRITERIA]
3. Account activation process

## Login

1. Email/password or OAuth ([PROVIDERS])
2. JWT token generation (access + refresh)
3. Session management strategy

## Security Measures

- Rate limiting: [ATTEMPTS] per [TIMEFRAME]
- Password reset: Secure token flow
- Multi-factor auth: [METHOD] for sensitive operations
- RBAC: [ROLES] with [PERMISSIONS]

TOKEN_STRATEGY: JWT claims, expiration, refresh logic

```

### SCPO_API_SECURITY
```

ROLE: API Security Specialist  
TASK: Secure API endpoints for [APPLICATION]
CONSTRAINTS: Defense in depth, performance impact minimal

SECURITY_LAYERS:

## Input Validation

- Schema validation for all requests
- SQL injection prevention
- XSS protection in responses
- File upload restrictions

## Authentication & Authorization

- Bearer token validation
- Role-based access control
- Resource-level permissions
- API key management for integrations

## Rate Limiting & DoS Protection

- Request throttling by user/IP
- Payload size limits
- Connection limits
- Bot detection

MONITORING: Security events, anomaly detection

```

## 📊 Data Management

### SCPO_DATA_MODELING
```

ROLE: Data Architect
TASK: Model data relationships for [DOMAIN]  
CONSTRAINTS: Normalized structure, query performance, future flexibility

ENTITY_RELATIONSHIPS:

## Core Entities

### [Entity1]

- Attributes: [list core fields]
- Business rules: [validation/logic]
- Relationships: [to other entities]

### [Entity2]

- Attributes: [list core fields]
- Business rules: [validation/logic]
- Relationships: [to other entities]

## Relationship Types

- One-to-Many: [examples with foreign keys]
- Many-to-Many: [junction tables needed]
- One-to-One: [rare cases, justification]

DENORMALIZATION: Where to break normal forms for performance

```

### SCPO_MIGRATION_STRATEGY
```

ROLE: Database Administrator
TASK: Plan database migration for [MIGRATION_TYPE]
CONSTRAINTS: Zero downtime, rollback plan, data integrity

MIGRATION_PLAN:

## Pre-Migration

1. Backup strategy and verification
2. Performance baseline measurement
3. Rollback scripts preparation

## Migration Steps

1. Schema changes (DDL scripts)
2. Data transformation (DML scripts)
3. Index creation/optimization
4. Constraint validation

## Post-Migration

1. Performance validation
2. Application compatibility testing
3. Monitoring for issues

RISK_MITIGATION: Blue-green deployment, feature flags
TIMELINE: [estimated duration] with checkpoints

```

## ⚡ Performance & Scaling

### SCPO_PERFORMANCE_OPTIMIZATION
```

ROLE: Performance Engineer
TASK: Optimize [SYSTEM_COMPONENT] for scale
CONSTRAINTS: Measure first, optimize bottlenecks, maintain code quality

OPTIMIZATION_APPROACH:

## Current Performance

- Baseline metrics: [response_times, throughput]
- Bottleneck identification: [profiling_results]
- Resource utilization: [CPU, memory, I/O]

## Option A: [OPTIMIZATION_NAME]

- Implementation: [technical_approach]
- Expected gain: [performance_improvement]
- Trade-offs: [complexity, maintenance, cost]
- Risk level: [LOW/MEDIUM/HIGH]

## Option B: [ALTERNATIVE_OPTIMIZATION]

- Implementation: [technical_approach]
- Expected gain: [performance_improvement]
- Trade-offs: [complexity, maintenance, cost]
- Risk level: [LOW/MEDIUM/HIGH]

MONITORING: Key metrics to track post-optimization

```

### SCPO_SCALING_STRATEGY
```

ROLE: Infrastructure Architect
TASK: Plan scaling strategy for [EXPECTED_LOAD]
CONSTRAINTS: Cost-effective, gradual scaling, monitoring-driven

SCALING_PLAN:

## Horizontal Scaling

- Load balancing strategy
- Session management (sticky vs stateless)
- Database read replicas
- CDN implementation

## Vertical Scaling

- Resource upgrade triggers
- Performance monitoring thresholds
- Auto-scaling rules

## Database Scaling

- Read replicas for [use_cases]
- Sharding strategy if needed
- Connection pooling optimization

COST_ANALYSIS: Scaling costs vs performance gains
IMPLEMENTATION: Phased rollout plan

```

---

*These backend architecture prompts follow SCPO principles: structured output, token efficiency, and actionable technical specifications. Each prompt generates comprehensive yet focused architectural decisions.*
```
