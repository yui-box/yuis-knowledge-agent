# claude-project-boilerplate

A minimal, reusable starter template for building Claude-powered applications and services.

## Features

- Standardized project structure for Claude-based projects
- Preconfigured environment variables for Claude API keys
- Example prompts and integration patterns
- Basic logging, error handling, and configuration setup
- Ready for extension into prototypes or production services

## Getting Started

1. Clone the repository:
   ```bash
   git clone git@github.com:AndreaSoto/claude-project-boilerplate.git
   cd claude-project-boilerplate
   ```

2. Install dependencies:
   ```bash
   # example for Node
   npm install
   ```

3. Configure environment:
   ```bash
   cp .env.example .env
   # fill in your Claude / API keys
   ```

4. Run the project:
   ```bash
   npm run dev
   ```

## Local Development Environment

Follow these steps exactly to get the project running on your machine for the first time.

### Prerequisites

Make sure the following are installed before you begin:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) — runs the database
- [Node.js 20+](https://nodejs.org/) — runs the Next.js app
- [npm](https://www.npmjs.com/) — comes bundled with Node.js

---

### Step 1 — Copy environment variables

```bash
cp .env.example .env
```

Open `.env` and fill in the required values:

| Variable | Description |
|---|---|
| `POSTGRES_USER` | Admin username for the database (e.g. `admin`) |
| `POSTGRES_PASSWORD` | Admin password — use something strong |
| `POSTGRES_DB` | Database name (e.g. `knowledge_agent`) |
| `APP_DB_USER` | Limited app user (e.g. `app`) |
| `APP_DB_PASSWORD` | Password for the app user — use something strong |
| `DATABASE_URL` | Built from the app user: `postgresql://app:<password>@localhost:5432/knowledge_agent` |
| `ANTHROPIC_API_KEY` | Your Anthropic API key from [console.anthropic.com](https://console.anthropic.com) |
| `NEXTAUTH_SECRET` | Random secret — generate with `openssl rand -base64 32` |

---

### Step 2 — Start Docker Desktop

Open the **Docker Desktop** application and wait until it shows **"Docker is running"** in the menu bar (the whale icon stops animating).

---

### Step 3 — Start the database

```bash
docker compose up -d
```

This pulls the PostgreSQL image and starts the database in the background. The first run may take a minute to download the image.

Verify it is running:

```bash
docker compose ps
```

You should see `postgres` with status `running`.

---

### Step 4 — Install dependencies

```bash
cd src
npm install
```

---

### Step 5 — Run database migrations

```bash
npm run db:migrate
```

---

### Step 6 — Start the development server

```bash
npm run dev
```

---

### Step 7 — Open the app

Visit **[http://localhost:3000](http://localhost:3000)** in your browser.

---

### Stopping the environment

To stop the Next.js server press `Ctrl + C` in the terminal where it is running.

To stop the database:

```bash
docker compose down
```

To stop the database and **delete all data** (full reset):

```bash
docker compose down -v
```

---

## Usage

- Use the included example scripts as a reference for calling Claude.
- Extend the handlers, routes, or agents to match your application needs.

## Project Structure

- `src/` – application code and Claude integration logic
- `config/` – configuration and environment handling
- `scripts/` – example scripts and utilities
- `tests/` – test setup and sample tests

## Contributing

Contributions are welcome. Please open an issue or submit a pull request.

## Credits

This project uses [Claude](https://claude.ai) by [Anthropic](https://anthropic.com) and the following Claude Code plugin:

- **[everything-claude-code](https://www.npmjs.com/package/ecc)** (`ecc@ecc`) — a Claude Code plugin that provides agents, hooks, and workflow automation for Claude-powered development environments. All credits and licenses belong to its respective authors. See the [everything-claude-code license](https://github.com/disler/everything-claude-code/blob/main/LICENSE) for details.

## License

MIT