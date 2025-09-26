# Testing & Quality Assurance Prompts - SCPO Vibecoding

## 🧪 Test Suite Generation

### SCPO_COMPLETE_TEST_SUITE

````
ROLE: Senior Test Engineer
TASK: Generate comprehensive test suite for [FUNCTION/MODULE/CLASS]
CONSTRAINTS: Edge cases covered, maintainable tests, clear documentation

TEST_SUITE_STRUCTURE:
## Unit Tests
### Happy Path Tests
```javascript
describe('[COMPONENT_NAME] - Happy Path', () => {
  test('should [EXPECTED_BEHAVIOR] when [CONDITION]', () => {
    // Arrange
    const [input] = [VALID_INPUT];

    // Act
    const result = [FUNCTION_CALL](input);

    // Assert
    expect(result).toBe([EXPECTED_OUTPUT]);
  });
});
````

### Edge Cases

```javascript
describe("[COMPONENT_NAME] - Edge Cases", () => {
  test("should handle empty input gracefully", () => {
    const result = [FUNCTION_CALL]();
    expect(result).toBe([DEFAULT_BEHAVIOR]);
  });

  test("should handle maximum boundary values", () => {
    const result = [FUNCTION_CALL]([MAX_VALUE]);
    expect(result).toBe([EXPECTED_MAX_BEHAVIOR]);
  });

  test("should handle minimum boundary values", () => {
    const result = [FUNCTION_CALL]([MIN_VALUE]);
    expect(result).toBe([EXPECTED_MIN_BEHAVIOR]);
  });
});
```

### Error Conditions

```javascript
describe("[COMPONENT_NAME] - Error Handling", () => {
  test("should throw [ERROR_TYPE] when [INVALID_CONDITION]", () => {
    expect(() => {
      [FUNCTION_CALL]([INVALID_INPUT]);
    }).toThrow([ERROR_MESSAGE]);
  });
});
```

## Integration Tests

### API Endpoint Tests

```javascript
describe("[ENDPOINT] Integration", () => {
  test("should return [STATUS_CODE] with valid data", async () => {
    const response = await request(app)
      .post("[ENDPOINT]")
      .send([VALID_PAYLOAD]);

    expect(response.status).toBe([EXPECTED_STATUS]);
    expect(response.body).toMatchObject([EXPECTED_SHAPE]);
  });
});
```

**TEST_COVERAGE_TARGET:** 90%+ for critical paths, 80%+ overall
**PERFORMANCE_TESTS:** Include load/stress tests for bottleneck areas

```

### SCPO_TDD_WORKFLOW
```

ROLE: TDD Practitioner
TASK: Design TDD workflow for [FEATURE_DEVELOPMENT]
CONSTRAINTS: Red-Green-Refactor cycle, incremental development

TDD_IMPLEMENTATION:

## Phase 1: Red (Failing Test)

```javascript
// Test: Define expected behavior before implementation
describe("UserValidator", () => {
  test("should validate email format correctly", () => {
    const validator = new UserValidator();

    // This will fail initially - no implementation yet
    expect(validator.isValidEmail("test@example.com")).toBe(true);
    expect(validator.isValidEmail("invalid-email")).toBe(false);
  });
});
```

## Phase 2: Green (Minimal Implementation)

```javascript
// Implementation: Just enough code to make test pass
class UserValidator {
  isValidEmail(email) {
    // Minimal implementation
    return email && email.includes("@") && email.includes(".");
  }
}
```

## Phase 3: Refactor (Improve Design)

```javascript
// Refactored: Better implementation while keeping tests green
class UserValidator {
  isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }
}
```

## TDD Benefits Tracking

- **Design Quality:** How tests influence API design
- **Regression Prevention:** Catching breaks early
- **Documentation:** Tests as living specifications
- **Confidence:** Safe refactoring with test coverage

**CYCLE_TIME:** Aim for 2-5 minute Red-Green-Refactor cycles
**INTEGRATION:** Regular integration with CI/CD pipeline

```

### SCPO_MOCK_STRATEGY
```

ROLE: Test Architecture Specialist  
TASK: Design mocking strategy for [SYSTEM_DEPENDENCIES]
CONSTRAINTS: Isolated tests, realistic mocks, maintainable test doubles

MOCKING_APPROACH:

## External Dependencies

### Database Layer

```javascript
// Mock database operations
const mockRepository = {
  findById: jest.fn(),
  save: jest.fn(),
  delete: jest.fn(),
};

// Test with mocked dependency
test("should update user successfully", async () => {
  // Arrange
  mockRepository.findById.mockResolvedValue(existingUser);
  mockRepository.save.mockResolvedValue(updatedUser);

  const userService = new UserService(mockRepository);

  // Act
  const result = await userService.updateUser(userId, updateData);

  // Assert
  expect(mockRepository.save).toHaveBeenCalledWith(expectedUserData);
  expect(result).toEqual(updatedUser);
});
```

### API Calls

```javascript
// Mock HTTP requests
jest.mock('axios');
const mockedAxios = axios as jest.Mocked<typeof axios>;

test('should handle external API failure', async () => {
  // Arrange
  mockedAxios.get.mockRejectedValue(new Error('Network error'));

  // Act & Assert
  await expect(externalService.fetchData()).rejects.toThrow('Network error');
});
```

## Mock Best Practices

### When to Mock

- External services (APIs, databases)
- Slow operations (file I/O, network calls)
- Non-deterministic behavior (random, time-based)

### When NOT to Mock

- Pure functions without side effects
- Simple data transformations
- Your own domain logic (integration test instead)

**MOCK_MAINTENANCE:** Keep mocks synchronized with real implementations
**INTEGRATION_BALANCE:** 70% unit tests (mocked), 30% integration tests (real dependencies)

```

## 🔍 Quality Assurance Strategies

### SCPO_CODE_REVIEW_CHECKLIST
```

ROLE: Code Review Specialist
TASK: Create comprehensive code review checklist for [PROJECT_TYPE]
CONSTRAINTS: Actionable items, consistent standards, learning-focused feedback

CODE_REVIEW_FRAMEWORK:

## Functionality Review

### Logic & Correctness

- [ ] Code does what it's supposed to do
- [ ] Edge cases are handled appropriately
- [ ] Error conditions are managed gracefully
- [ ] Business logic is correct and complete

### Testing Coverage

- [ ] Unit tests cover happy path and edge cases
- [ ] Integration tests verify component interaction
- [ ] Test names clearly describe what they verify
- [ ] Mock usage is appropriate and realistic

## Code Quality

### Readability & Maintainability

- [ ] Variable and function names are descriptive
- [ ] Functions are focused and single-purpose
- [ ] Code complexity is manageable (cyclomatic < 10)
- [ ] Comments explain "why" not "what"

### Performance Considerations

- [ ] No obvious performance bottlenecks
- [ ] Database queries are efficient
- [ ] Memory leaks are prevented
- [ ] Caching is used appropriately

## Security & Best Practices

### Security Checks

- [ ] Input validation and sanitization
- [ ] SQL injection prevention
- [ ] XSS protection in place
- [ ] Authentication/authorization properly implemented

### Architecture Alignment

- [ ] Follows established patterns and conventions
- [ ] Proper separation of concerns
- [ ] Dependencies are minimal and justified
- [ ] API contracts are maintained

**FEEDBACK_STYLE:** Constructive suggestions with reasoning
**LEARNING_OPPORTUNITIES:** Share knowledge and alternative approaches

```

### SCPO_AUTOMATED_TESTING
```

ROLE: Test Automation Engineer
TASK: Set up automated testing pipeline for [APPLICATION_TYPE]
CONSTRAINTS: Fast feedback, reliable results, minimal maintenance

AUTOMATION_PIPELINE:

## Test Pyramid Structure

### Unit Tests (70%)

- **Runtime:** < 5 minutes total
- **Scope:** Individual functions/classes
- **Mocking:** External dependencies
- **Frequency:** Every commit

### Integration Tests (20%)

- **Runtime:** < 15 minutes total
- **Scope:** Component interactions
- **Database:** Test database with fixtures
- **Frequency:** Before merge to main

### End-to-End Tests (10%)

- **Runtime:** < 30 minutes total
- **Scope:** Full user workflows
- **Environment:** Staging replica
- **Frequency:** Nightly and before releases

## CI/CD Integration

```yaml
# GitHub Actions example
name: Test Pipeline
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Run Unit Tests
        run: npm test -- --coverage

      - name: Run Integration Tests
        run: npm run test:integration

      - name: Run E2E Tests (on main branch)
        if: github.ref == 'refs/heads/main'
        run: npm run test:e2e
```

## Quality Gates

### Required Checks

- [ ] All tests pass
- [ ] Code coverage > 80%
- [ ] No critical security vulnerabilities
- [ ] Performance benchmarks within thresholds

**FLAKY_TEST_HANDLING:** Quarantine and fix strategy
**PARALLEL_EXECUTION:** Split tests for faster feedback

```

### SCPO_BUG_REPRODUCTION
```

ROLE: QA Engineer
TASK: Reproduce and document bug report for [BUG_DESCRIPTION]
CONSTRAINTS: Minimal reproduction case, clear steps, actionable information

BUG_REPRODUCTION_REPORT:

## Bug Summary

- **Title:** [Concise description of the issue]
- **Severity:** [Critical/High/Medium/Low]
- **Priority:** [P0/P1/P2/P3]
- **Component:** [Affected system component]

## Environment Details

- **OS:** [Operating system and version]
- **Browser:** [Browser and version if applicable]
- **App Version:** [Build number or version]
- **Dependencies:** [Relevant library versions]

## Reproduction Steps

### Minimal Reproduction Case

1. **Setup:** [Initial state/data required]
2. **Action 1:** [Specific user action]
3. **Action 2:** [Next specific action]
4. **Trigger:** [Final action that causes bug]

### Expected vs Actual Behavior

- **Expected:** [What should happen]
- **Actual:** [What actually happens]
- **Evidence:** [Screenshots, logs, error messages]

## Technical Details

### Error Information

```
[Stack trace or error logs]
```

### Browser Console (if applicable)

```
[Console errors or warnings]
```

### Network Activity

- API calls that failed: [endpoints and status codes]
- Timing issues: [if performance related]

## Debugging Information

### Potential Root Causes

1. [Hypothesis 1 with supporting evidence]
2. [Hypothesis 2 with supporting evidence]

### Workarounds

- [Temporary solutions for users]
- [Conditions where bug doesn't occur]

**REPRODUCIBILITY:** [Always/Sometimes/Rare] with frequency percentage
**IMPACT:** [User impact assessment and affected user segments]

```

## 📊 Test Data & Environment Management

### SCPO_TEST_DATA_STRATEGY
```

ROLE: Test Data Manager
TASK: Design test data strategy for [APPLICATION_DOMAIN]
CONSTRAINTS: Realistic data, privacy compliant, maintainable

TEST_DATA_FRAMEWORK:

## Data Categories

### Static Test Data (Fixtures)

```javascript
// User fixtures for consistent testing
const testUsers = {
  adminUser: {
    id: 1,
    email: "admin@test.com",
    role: "admin",
    permissions: ["read", "write", "delete"],
  },
  regularUser: {
    id: 2,
    email: "user@test.com",
    role: "user",
    permissions: ["read"],
  },
};
```

### Dynamic Test Data (Factories)

```javascript
// Generate test data on demand
const UserFactory = {
  create: (overrides = {}) => ({
    id: Math.random(),
    email: `user${Date.now()}@test.com`,
    createdAt: new Date(),
    ...overrides,
  }),
};
```

## Data Management

### Database Seeding

```sql
-- Seed script for test environment
INSERT INTO users (email, role) VALUES
('test1@example.com', 'user'),
('admin@example.com', 'admin');
```

### Data Cleanup

```javascript
// Cleanup after each test
afterEach(async () => {
  await testDatabase.cleanup();
  await clearTestFiles();
});
```

## Privacy & Compliance

### Data Anonymization

- Remove or mask PII in test datasets
- Generate synthetic data that matches production patterns
- Regular audits of test data for sensitive information

### Data Retention

- Automatic cleanup of temporary test data
- Clear policies on test data storage duration
- Secure deletion of sensitive test information

**MAINTENANCE:** Automated test data validation and refresh cycles
**PERFORMANCE:** Optimize test data size for fast test execution

```

---

*These testing and quality assurance prompts follow SCPO optimization principles: comprehensive coverage with token-efficient structures, actionable checklists, and maintainable test strategies.*
```
