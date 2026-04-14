\getenv postgres_user POSTGRES_USER
\getenv postgres_password POSTGRES_PASSWORD
\getenv app_db_user APP_DB_USER
\getenv app_db_password APP_DB_PASSWORD
\getenv postgres_db POSTGRES_DB

-- Ensure admin password is set
ALTER USER :"postgres_user" WITH PASSWORD :'postgres_password';

-- Create limited app user
CREATE USER :"app_db_user" WITH PASSWORD :'app_db_password';
GRANT CONNECT ON DATABASE :"postgres_db" TO :"app_db_user";
GRANT USAGE ON SCHEMA public TO :"app_db_user";
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO :"app_db_user";
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO :"app_db_user";
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO :"app_db_user";
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT USAGE, SELECT ON SEQUENCES TO :"app_db_user";
