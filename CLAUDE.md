# Claude Guidelines for Personal Development Projects

> **Subagent Integration**: These standards are referenced by specialized subagents:
>
> - `software-architect`: Tech stacks, project structure, deployment strategy, infrastructure decisions
> - `code-reviewer`: Code style, error handling, naming conventions, quality standards
> - `developer`: Commands, development workflow, implementation patterns
> - `security-engineer`: Security practices and compliance requirements
> - `qa-specialist`: Testing approaches and quality gates
> - `investigator`: Debugging techniques and analysis methods

## Tech Stacks

*Referenced by: `software-architect` for technology decisions*

- Frontend: NextJS with Vercel deployment
- API: Node.js with TypeScript
- Data: Python with Pandas, dbt, Airflow
- GraphQL: Apollo Server/Client
- Database: PostgreSQL, Redshift, TimescaleDB
- Environment: asdf for version management, pipenv for python, npm for node packages
- Deployment: Vercel for frontend, digitalocean for backend
- Instrumentation: Sentry for error tracking, loki for logging, grafana for monitoring

## Commands

*Referenced by: `developer` and `software-architect` for development workflow*

- Frontend: `npm run dev` (NextJS development)
- API: `npm run start:dev` (Node development)
- Tests: `npm test` or `python -m pytest`
- Linting: `npm run lint` or `flake8`
- CI Linting: `npm run lint:ci` or `eslint`
- Type checking: `npm run typecheck` or `mypy`
- Python env: `pipenv install` and `pipenv shell`
- dbt: `dbt run`, `dbt test`

## Code Style

*Referenced by: `code-reviewer` for quality standards and `developer` for implementation*

- Naming: prefer case insensitive schemes such as kebab-case (URLs, filenames) or snake_case (variables)
- Clean Code: Agile Software Craftsmanship principles thoughtfully applied to all projects
- DRY: Don't Repeat Yourself
- Favors simplicity over complexity
- Consistent formatting with Prettier and Black
- Linting with ESLint and Flake8
- TypeScript:
  - Strong typing with interfaces/types
  - Functional components for React
  - Named exports preferred
- Python:
  - Type hints required
  - Black for formatting
  - Pandas for data manipulation

## Project Structure

*Referenced by: `software-architect` for architectural decisions and `developer` for implementation*

- NextJS: pages/app router with /components, /hooks, /utils
- Node API: /controllers, /services, /models, /middleware
- GraphQL: Apollo Server with type definitions and resolvers
- Data: Airflow DAGs, dbt models, Python with pandas

## Error Handling

*Referenced by: `code-reviewer` for quality standards and `developer` for implementation*

- Use typed errors and proper status codes
- Consistent error response format
- Client-side error boundaries

## Agent Delegation Guidelines

Use specialized subagents for focused work that preserves context and applies domain expertise:

### When to Delegate

- **Complex analysis** (>10 minutes of investigation) → `/agents investigator`
- **Feature implementation** or substantial coding → `/agents developer`
- **Security-sensitive changes** → `/agents security-engineer` (mandatory for auth, data, APIs, input validation)
- **Code quality review** → `/agents code-reviewer`
- **Test strategy and comprehensive testing** → `/agents qa-specialist`
- **Technology decisions and architecture** → `/agents software-architect`

### Typical Workflows

**Bug Investigation:**

```
User reports bug → /agents investigator → /agents developer → /agents security-engineer (if needed) → /agents code-reviewer → /agents qa-specialist
```

**Feature Development:**

```
Feature request → /agents software-architect → /agents developer → /agents security-engineer → /agents code-reviewer → /agents qa-specialist
```

**Code Quality Improvement:**

```
Quality concerns → /agents investigator → /agents software-architect → /agents developer → /agents code-reviewer → /agents qa-specialist
```

### Agent Specializations

- **investigator**: Deep codebase analysis, bug hunting, performance bottleneck identification, technical research
- **developer**: Implementation, bug fixes, code documentation, following established patterns
- **security-engineer**: Security assessment, threat modeling, compliance validation (mandatory security gate)
- **code-reviewer**: Code quality, maintainability, standards compliance, documentation review
- **qa-specialist**: Test writing, edge case discovery, comprehensive quality assurance
- **software-architect**: Technology decisions, system design, architectural patterns, deployment strategy

Each agent maintains specialized knowledge entities and builds expertise over time through persistent memory.
