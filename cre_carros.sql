\echo '++++++  Executing cre_carros.sql file ....'
--drop table if exists acessories;
--drop table if exists cars;

CREATE TABLE cars (
    car_id INT,                       -- identificador do carro
    name VARCHAR(50) NOT NULL,        -- nome do carro
    motor VARCHAR(50) NOT NULL,       -- motor do carro
    year varCHAR(20) NOT NULL,            -- ano do carro
    km_driven varCHAR(20),                -- km rodado do carro
    value varCHAR(20) NOT NULL,           -- valor do carro
    location VARCHAR(50) NOT NULL,    -- cidade do carro
    category VARCHAR(10) NOT NULL,    -- categoria do carro (NOVO, USADO)
    url_photo TEXT,                    -- url da foto do carro
    CONSTRAINT cars_pk PRIMARY KEY (car_id)
);

create table acessories 
(
	acessorie_id integer,           -- identificador do acess�rio
	car_id     integer ,            -- identificador do carro
	acessory_title varchar(255),    -- descri��o do acess�rio
    CONSTRAINT acessories_pk PRIMARY KEY (acessorie_id),
    CONSTRAINT cars_fk FOREIGN KEY (car_id) REFERENCES cars(car_id)
);