# Documentation Prompts - SCPO Vibecoding

## 📚 Technical Documentation

### SCPO_COMPLETE_README

````
ROLE: Technical Writer for Solo Developer
TASK: Write comprehensive README for [PROJECT_NAME]
CONSTRAINTS: Clear for newcomers, actionable steps, maintainable documentation

README_STRUCTURE:
# 🚀 [PROJECT_NAME]

> [One-line description of what this project does and why it matters]

## ✨ Features

- 🎯 **[Core Feature 1]** - [Brief benefit description]
- ⚡ **[Core Feature 2]** - [Brief benefit description]
- 🛡️ **[Core Feature 3]** - [Brief benefit description]

## 🏃 Quick Start

### Prerequisites
```bash
# Required tools and versions
Node.js >= 18.0.0
npm >= 8.0.0
[Database] >= [version]
````

### Installation

```bash
# Clone and setup
git clone [REPO_URL]
cd [PROJECT_NAME]
npm install

# Environment setup
cp .env.example .env
# Edit .env with your settings
```

### Run Development Server

```bash
npm run dev
# Open http://localhost:[PORT]
```

## 🔧 Configuration

### Environment Variables

| Variable       | Description                | Default | Required |
| -------------- | -------------------------- | ------- | -------- |
| `DATABASE_URL` | Database connection string | -       | ✅       |
| `API_KEY`      | External API key           | -       | ✅       |
| `PORT`         | Server port                | 3000    | ❌       |

### Config Files

- **`config/database.js`** - Database connection settings
- **`config/app.js`** - Application configuration
- **`.env`** - Environment-specific variables

## 📖 Usage

### Basic Example

```javascript
const [MAIN_CLASS] = require('[PROJECT_NAME]');

// Initialize
const app = new [MAIN_CLASS]({
  apiKey: 'your-api-key',
  environment: 'production'
});

// Use core functionality
const result = await app.[MAIN_METHOD]([PARAMETERS]);
console.log(result);
```

### Advanced Usage

```javascript
// More complex example with error handling
try {
  const [RESULT] = await app.[ADVANCED_METHOD]({
    option1: 'value1',
    option2: true,
    callback: (progress) => console.log(`Progress: ${progress}%`)
  });
} catch (error) {
  console.error('Operation failed:', error.message);
}
```

## 🛠️ Development

### Available Scripts

```bash
npm run dev          # Start development server
npm run build        # Build for production
npm run test         # Run test suite
npm run test:watch   # Run tests in watch mode
npm run lint         # Lint code
npm run format       # Format code with Prettier
```

### Project Structure

```
[PROJECT_NAME]/
├── src/             # Source code
├── tests/           # Test files
├── config/          # Configuration files
├── docs/            # Documentation
├── public/          # Static assets
└── scripts/         # Build and utility scripts
```

## 🚀 Deployment

### Production Build

```bash
# Build optimized version
npm run build

# Start production server
npm start
```

### Docker Deployment

```bash
# Build Docker image
docker build -t [PROJECT_NAME] .

# Run container
docker run -p [PORT]:3000 -e DATABASE_URL="[URL]" [PROJECT_NAME]
```

### Environment Setup

1. **Development:** Use `.env` file with local settings
2. **Staging:** Deploy with staging environment variables
3. **Production:** Use secure environment variable management

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🙋 Support

- 📧 Email: [CONTACT_EMAIL]
- 🐛 Issues: [GitHub Issues URL]
- 💬 Discussions: [Community Forum/Discord]

---

_Built with ❤️ by [AUTHOR_NAME]_

```

### SCPO_API_DOCUMENTATION
```

ROLE: API Documentation Specialist
TASK: Generate API documentation for [API_NAME]
CONSTRAINTS: OpenAPI standard, interactive examples, developer-friendly

API_DOCUMENTATION:

# 📡 [API_NAME] Documentation

## Base URL

```
Production: https://api.[domain].com/v1
Staging: https://staging-api.[domain].com/v1
```

## Authentication

```bash
# All requests require API key in header
curl -H "Authorization: Bearer YOUR_API_KEY" \
     -H "Content-Type: application/json"
```

## Endpoints

### 🔍 GET /[resource]

Retrieve list of [resources] with pagination and filtering.

**Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `page` | integer | No | Page number (default: 1) |
| `limit` | integer | No | Items per page (max: 100) |
| `search` | string | No | Search query |
| `status` | string | No | Filter by status |

**Example Request:**

```bash
curl "https://api.example.com/v1/[resources]?page=1&limit=20" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

**Example Response:**

```json
{
  "success": true,
  "data": [
    {
      "id": "123",
      "name": "Example Item",
      "status": "active",
      "created_at": "2024-01-01T00:00:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 150,
    "total_pages": 8
  }
}
```

### ✨ POST /[resource]

Create a new [resource].

**Request Body:**

```json
{
  "name": "string (required)",
  "description": "string (optional)",
  "status": "active|inactive (optional, default: active)"
}
```

**Example Request:**

```bash
curl -X POST "https://api.example.com/v1/[resources]" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "New Item",
    "description": "Item description"
  }'
```

**Response (201 Created):**

```json
{
  "success": true,
  "data": {
    "id": "124",
    "name": "New Item",
    "description": "Item description",
    "status": "active",
    "created_at": "2024-01-01T10:30:00Z"
  }
}
```

## Error Handling

### Error Response Format

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [
      {
        "field": "name",
        "message": "Name is required"
      }
    ]
  }
}
```

### Common Error Codes

| Code               | Status | Description                |
| ------------------ | ------ | -------------------------- |
| `UNAUTHORIZED`     | 401    | Invalid or missing API key |
| `FORBIDDEN`        | 403    | Insufficient permissions   |
| `NOT_FOUND`        | 404    | Resource not found         |
| `VALIDATION_ERROR` | 422    | Request validation failed  |
| `RATE_LIMITED`     | 429    | Too many requests          |

## Rate Limits

- **Free tier:** 100 requests/hour
- **Pro tier:** 1,000 requests/hour
- **Enterprise:** Custom limits

## SDKs & Libraries

- **JavaScript:** `npm install [api-client-name]`
- **Python:** `pip install [api-client-name]`
- **PHP:** `composer require [vendor/api-client]`

```

### SCPO_ARCHITECTURE_DOCS
```

ROLE: Software Architect
TASK: Document system architecture for [SYSTEM_NAME]
CONSTRAINTS: Technical and business stakeholder audiences, visual diagrams, decision rationale

ARCHITECTURE_DOCUMENTATION:

# 🏗️ [SYSTEM_NAME] Architecture

## System Overview

[SYSTEM_NAME] is a [system_type] designed to [primary_purpose]. The architecture follows [architectural_pattern] principles to ensure [key_benefits].

## High-Level Architecture

### System Context

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Users     │───▶│   System    │───▶│  External   │
│             │    │             │    │  Services   │
└─────────────┘    └─────────────┘    └─────────────┘
```

### Component Diagram

```
┌──────────────────────────────────────┐
│              Frontend                │
│  ┌────────────┐  ┌────────────────┐  │
│  │    Web     │  │     Mobile     │  │
│  │    App     │  │      App       │  │
│  └────────────┘  └────────────────┘  │
└─────────────┬────────────────────────┘
              │ HTTPS/REST API
              ▼
┌──────────────────────────────────────┐
│              Backend                 │
│  ┌─────────┐  ┌─────────┐  ┌──────┐  │
│  │   API   │  │Business │  │ Auth │  │
│  │Gateway  │  │ Logic   │  │ Svc  │  │
│  └─────────┘  └─────────┘  └──────┘  │
└─────────────┬────────────────────────┘
              │
              ▼
┌──────────────────────────────────────┐
│             Data Layer               │
│  ┌─────────┐  ┌─────────┐  ┌──────┐  │
│  │Primary  │  │ Cache   │  │Queue │  │
│  │Database │  │(Redis)  │  │      │  │
│  └─────────┘  └─────────┘  └──────┘  │
└──────────────────────────────────────┘
```

## Core Components

### Frontend Layer

- **Technology:** [Frontend_Framework]
- **Responsibility:** User interface and user experience
- **Communication:** REST API calls to backend
- **Key Features:**
  - Responsive design for mobile/desktop
  - Real-time updates via WebSocket
  - Client-side routing and state management

### API Gateway

- **Technology:** [Gateway_Technology]
- **Responsibility:** Request routing, rate limiting, authentication
- **Key Features:**
  - Load balancing across backend instances
  - Request/response transformation
  - API versioning and deprecation management

### Business Logic Services

- **Technology:** [Backend_Framework]
- **Responsibility:** Core business rules and data processing
- **Architecture Pattern:** [Microservices/Modular_Monolith]
- **Key Services:**
  - [Service_1]: [Responsibility]
  - [Service_2]: [Responsibility]
  - [Service_3]: [Responsibility]

### Data Storage

- **Primary Database:** [Database_Type] for transactional data
- **Cache Layer:** Redis for session and frequently accessed data
- **Message Queue:** [Queue_Technology] for asynchronous processing

## Design Decisions

### Technology Choices

| Component | Technology   | Rationale              |
| --------- | ------------ | ---------------------- |
| Frontend  | [Technology] | [Reasoning for choice] |
| Backend   | [Technology] | [Reasoning for choice] |
| Database  | [Technology] | [Reasoning for choice] |

### Architecture Patterns

- **[Pattern_1]:** Used for [component] because [benefits]
- **[Pattern_2]:** Implemented in [component] to achieve [goals]

## Security Architecture

### Authentication Flow

1. User login with credentials
2. JWT token generation and signing
3. Token validation on protected endpoints
4. Refresh token rotation for long-lived sessions

### Data Security

- Encryption at rest using [encryption_method]
- TLS 1.3 for data in transit
- Input validation and sanitization
- SQL injection prevention through parameterized queries

## Deployment Architecture

### Environment Structure

- **Development:** Local development with Docker Compose
- **Staging:** Kubernetes cluster mirroring production
- **Production:** Multi-zone deployment with auto-scaling

### CI/CD Pipeline

```
GitHub → Tests → Build → Deploy to Staging → Manual Approval → Production
```

## Monitoring & Observability

### Metrics Collection

- Application metrics: Response times, error rates
- Infrastructure metrics: CPU, memory, disk usage
- Business metrics: User activity, feature usage

### Logging Strategy

- Structured JSON logs with correlation IDs
- Centralized logging with [logging_solution]
- Log retention policy: 30 days for debug, 1 year for audit

## Scalability Considerations

### Current Capacity

- Handles [current_load] concurrent users
- Database supports [data_volume] records
- API throughput: [requests_per_second] RPS

### Scaling Strategy

- **Horizontal scaling:** Auto-scaling groups for API servers
- **Database scaling:** Read replicas and connection pooling
- **Caching:** Distributed caching for session and computed data

**MAINTENANCE:** This document is updated with each major architectural change
**REVIEWS:** Architecture review meetings occur quarterly

```

## 📝 Process Documentation

### SCPO_DEPLOYMENT_GUIDE
```

ROLE: DevOps Engineer  
TASK: Create deployment guide for [APPLICATION_NAME]
CONSTRAINTS: Step-by-step instructions, rollback procedures, monitoring setup

DEPLOYMENT_GUIDE:

# 🚀 Deployment Guide - [APPLICATION_NAME]

## Pre-Deployment Checklist

- [ ] Code reviewed and approved
- [ ] Tests passing in CI/CD pipeline
- [ ] Database migrations tested
- [ ] Environment variables configured
- [ ] Monitoring and alerting ready
- [ ] Rollback plan prepared

## Environment Setup

### Production Environment

```bash
# Server requirements
- CPU: 4 cores minimum
- RAM: 8GB minimum
- Storage: 50GB SSD
- OS: Ubuntu 20.04 LTS or newer
```

### Dependencies Installation

```bash
# System dependencies
sudo apt update
sudo apt install -y nodejs npm nginx postgresql redis

# Application dependencies
npm ci --production

# Database setup
sudo -u postgres createdb [app_database]
npm run migrate:production
```

## Deployment Process

### 1. Code Deployment

```bash
# Pull latest code
git fetch origin
git checkout [release_branch]

# Build application
npm run build

# Install dependencies
npm ci --production
```

### 2. Database Migration

```bash
# Backup current database
pg_dump [app_database] > backup_$(date +%Y%m%d_%H%M%S).sql

# Run migrations
npm run migrate:production

# Verify migration success
npm run migrate:status
```

### 3. Application Start

```bash
# Stop current application
pm2 stop [app_name]

# Start with new code
pm2 start ecosystem.config.js --env production

# Verify application health
curl http://localhost:3000/health
```

### 4. Web Server Configuration

```nginx
# /etc/nginx/sites-available/[app_name]
server {
    listen 80;
    server_name [your_domain];

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## Health Checks & Monitoring

### Application Health Check

```bash
# Verify all services are running
systemctl status nginx
systemctl status postgresql
systemctl status redis
pm2 status

# Test application endpoints
curl -f http://localhost:3000/health || exit 1
curl -f http://localhost:3000/api/status || exit 1
```

### Performance Monitoring

```bash
# Monitor resource usage
htop
df -h
free -h

# Check application logs
pm2 logs [app_name] --lines 50
tail -f /var/log/nginx/access.log
```

## Rollback Procedures

### Quick Rollback (Code)

```bash
# Revert to previous version
git checkout [previous_release_tag]
npm run build
pm2 restart [app_name]
```

### Database Rollback

```bash
# Restore database backup (if needed)
pg_restore -d [app_database] backup_[timestamp].sql

# Run down migrations (if available)
npm run migrate:down -- --to [previous_version]
```

## Troubleshooting

### Common Issues

| Problem                    | Symptoms                  | Solution                               |
| -------------------------- | ------------------------- | -------------------------------------- |
| App won't start            | PM2 shows error status    | Check logs: `pm2 logs`                 |
| Database connection failed | Connection errors in logs | Verify DB credentials and connectivity |
| High memory usage          | System slowdown           | Restart app: `pm2 restart [app_name]`  |
| 502/504 errors             | Nginx proxy errors        | Check upstream health                  |

### Emergency Contacts

- **Primary:** [Primary_Contact] - [Phone/Email]
- **Secondary:** [Secondary_Contact] - [Phone/Email]
- **Escalation:** [Manager_Contact] - [Phone/Email]

**POST_DEPLOYMENT:** Monitor application for 30 minutes after deployment
**COMMUNICATION:** Notify stakeholders of deployment completion and status

```

---

*These documentation prompts generate comprehensive, maintainable technical documentation following SCPO token efficiency principles while ensuring clarity for different audiences.*
```
