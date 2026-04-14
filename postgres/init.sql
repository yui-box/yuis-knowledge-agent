-- Create limited app user
CREATE USER app WITH PASSWORD :'app_db_password';

-- Grant connection to the database
GRANT CONNECT ON DATABASE knowledge_agent TO app;

-- Grant schema usage and DML privileges
GRANT USAGE ON SCHEMA public TO app;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO app;

-- Apply same privileges to future tables/sequences
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO app;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT USAGE, SELECT ON SEQUENCES TO app;
