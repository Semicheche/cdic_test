\echo '++++++  Executing popul_carros.sql file ....'

-- https://www.postgresql.org/docs/9.2/sql-copy.html

\COPY cars FROM './carros.csv' CSV DELIMITER ',' ENCODING 'UTF8' HEADER;

\COPY acessories FROM './acessorios.csv' CSV DELIMITER ',' ENCODING 'UTF8' HEADER;
