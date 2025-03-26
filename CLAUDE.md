# Claude Guidelines for Personal Development Projects

## Tech Stacks
- Frontend: NextJS with Vercel deployment
- API: Node.js with TypeScript
- Data: Python with Pandas, dbt, Airflow
- GraphQL: Apollo Server/Client
- Database: PostgreSQL, Redshift, TimescaleDB
- Environment: asdf for version management, pipenv for python, npm for node packages
- Deployment: Vercel for frontend, digitalocean for backend
- Instrumentation: Sentry for error tracking, loki for logging, grafana for monitoring

## Commands
- Frontend: `npm run dev` (NextJS development)
- API: `npm run start:dev` (Node development)
- Tests: `npm test` or `python -m pytest`
- Linting: `npm run lint` or `flake8`
- CI Linting: `npm run lint:ci` or `eslint`
- Type checking: `npm run typecheck` or `mypy`
- Python env: `pipenv install` and `pipenv shell`
- dbt: `dbt run`, `dbt test`

## Code Style
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
- NextJS: pages/app router with /components, /hooks, /utils
- Node API: /controllers, /services, /models, /middleware
- GraphQL: Apollo Server with type definitions and resolvers
- Data: Airflow DAGs, dbt models, Python with pandas

## Error Handling
- Use typed errors and proper status codes
- Consistent error response format
- Client-side error boundaries
