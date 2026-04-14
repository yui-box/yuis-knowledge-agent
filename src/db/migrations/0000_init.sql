CREATE EXTENSION IF NOT EXISTS vector;

CREATE TYPE connector_type AS ENUM ('discord');

CREATE TABLE orgs (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT        NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE users (
  id      UUID  PRIMARY KEY DEFAULT gen_random_uuid(),
  org_id  UUID  NOT NULL REFERENCES orgs(id) ON DELETE CASCADE,
  email   TEXT  NOT NULL UNIQUE,
  role    TEXT  NOT NULL
);

CREATE TABLE connectors (
  id           UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
  org_id       UUID            NOT NULL REFERENCES orgs(id) ON DELETE CASCADE,
  type         connector_type  NOT NULL,
  config       JSONB           NOT NULL DEFAULT '{}',
  last_sync_at TIMESTAMPTZ
);

CREATE TABLE documents (
  id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  org_id        UUID        NOT NULL REFERENCES orgs(id) ON DELETE CASCADE,
  connector_id  UUID        NOT NULL REFERENCES connectors(id) ON DELETE CASCADE,
  external_id   TEXT        NOT NULL,
  title         TEXT,
  url           TEXT,
  author        TEXT,
  updated_at    TIMESTAMPTZ,
  content_hash  TEXT
);

CREATE TABLE chunks (
  id           UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
  document_id  UUID          NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  content      TEXT          NOT NULL,
  embedding    vector(1536),
  token_count  INTEGER,
  position     INTEGER       NOT NULL
);

CREATE TABLE queries (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  org_id      UUID        NOT NULL REFERENCES orgs(id) ON DELETE CASCADE,
  user_id     UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  question    TEXT        NOT NULL,
  answer      TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE citations (
  id               UUID  PRIMARY KEY DEFAULT gen_random_uuid(),
  query_id         UUID  NOT NULL REFERENCES queries(id) ON DELETE CASCADE,
  chunk_id         UUID  NOT NULL REFERENCES chunks(id) ON DELETE CASCADE,
  relevance_score  REAL  NOT NULL
);

-- Vector similarity search index
CREATE INDEX ON chunks USING hnsw (embedding vector_cosine_ops);

-- Full-text search index
CREATE INDEX ON chunks USING GIN (to_tsvector('english', content));
