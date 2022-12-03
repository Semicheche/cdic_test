-- variáveis
\set dbuser 'motors'
\set dbname 'motors'
\set passwd '\''motors'\''


-- remover banco de dados
DROP DATABASE IF EXISTS :dbname;
DROP USER IF EXISTS :dbuser;


-- criar usuário e banco de dados
CREATE USER :dbuser NOSUPERUSER CREATEDB CREATEROLE LOGIN CONNECTION LIMIT -1 PASSWORD :passwd;
CREATE DATABASE :dbname WITH OWNER :dbuser;


-- atribuir de privilegios
GRANT pg_read_server_files TO :dbuser;      -- leitura de arquivos externos
GRANT pg_execute_server_program TO :dbuser; -- exectuar arquivos externos
GRANT pg_write_server_files TO :dbuser;     -- escrita de arquivos


-- conectar a banco de dados
\connect :dbname


-- definir usuario atual
-- SET ROLE :dbuser;
SET SESSION AUTHORIZATION :dbuser;

-- executar scripts
\i ./cre_carros.sql
\i ./popul_carros.sql
