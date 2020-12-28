

SELECT 'Создаем пользователя "admin"' AS msg;
CREATE USER admin WITH ENCRYPTED PASSWORD 'admin';

SELECT 'Создаем базу данных "CityTransportDB"' AS msg;

SELECT 'Выдаем все права пользователю "admin" к базе "CityTransportDB"' AS msg;
GRANT ALL PRIVILEGES ON DATABASE "CityTransportDB" to admin;


SELECT 'Создаем таблицу "Roles"' AS msg;
CREATE TABLE "Roles" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL
);


SELECT 'Создаем таблицу "Staff"' AS msg;
CREATE TABLE "Staff" (
    id SERIAL PRIMARY KEY,
    role_id INTEGER REFERENCES "Roles"(id) NOT NULL,
    FIO VARCHAR(255) NOT NULL,
    phone_number VARCHAR(32) NOT NULL,

    CONSTRAINT check_min_length CHECK (LENGTH(phone_number) >= 11)
);


SELECT 'Создаем таблицу "VehicleTypes"' AS msg;
CREATE TABLE "VehicleTypes" (
    id SERIAL PRIMARY KEY,
    type_name VARCHAR(255) NOT NULL,
    seats_number INTEGER NOT NULL,
    max_speed INTEGER,
    fuel_consumption INTEGER,
    tank_volume INTEGER,
    category CHAR(1) DEFAULT 'D',
    price FLOAT DEFAULT 30.0
);


SELECT 'Создаем таблицу "Stop"' AS msg;
CREATE TABLE "Stop" (
    id SERIAL PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);


SELECT 'Создаем таблицу "Stops_route"' AS msg;
CREATE TABLE "Stops_route" (
    id SERIAL PRIMARY KEY,
    stop_id INTEGER REFERENCES "Stop"(id) NOT NULL,
    stop_number INTEGER NOT NULL
);


SELECT 'Создаем таблицу "Route"' AS msg;
CREATE TABLE "Route" (
    route_number SERIAL PRIMARY KEY,
    stops_route_id INTEGER REFERENCES "Stops_route"(id) NOT NULL,
    name VARCHAR(64) NOT NULL
);


SELECT 'Создаем таблицу "Vehicle"' AS msg;
CREATE TABLE "Vehicle" (
    license_number INTEGER PRIMARY KEY,
    type_id INTEGER REFERENCES "VehicleTypes"(id) NOT NULL,
    route_number INTEGER REFERENCES "Route"(route_number) NOT NULL,
    driver_id INTEGER REFERENCES "Staff"(id) NOT NULL
);


SELECT 'Создаем таблицу "TripTicketCosts"' AS msg;
CREATE TABLE "TripTicketCosts" (
    id SERIAL PRIMARY KEY,
    trips_amount INTEGER NOT NULL,
    trip_cost FLOAT NOT NULL
);


SELECT 'Создаем таблицу "Ticket"' AS msg;
CREATE TABLE "Ticket" (
    id SERIAL PRIMARY KEY
);


SELECT 'Создаем таблицу "Payments"' AS msg;
CREATE TABLE "Payments" (
    id SERIAL PRIMARY KEY,
    ticket_id INTEGER REFERENCES "Ticket"(id) NOT NULL,
    vehicle_id INTEGER REFERENCES "Vehicle"(license_number) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


SELECT 'Создаем таблицу "Trips_ticket"' AS msg;
CREATE TABLE "Trips_ticket" (
    id SERIAL PRIMARY KEY,
    ticket_id INTEGER REFERENCES "Ticket"(id) NOT NULL,
    trips_amount INTEGER NOT NULL
);

SELECT 'Создаем таблицу "Balance_ticket"' AS msg;
CREATE TABLE "Balance_ticket" (
    id SERIAL PRIMARY KEY,
    ticket_id INTEGER REFERENCES "Ticket"(id) NOT NULL,
    balance INTEGER NOT NULL
);


SELECT 'Создаем таблицу "Top_UPs_Balance"' AS msg;
CREATE TABLE "Top_UPs_Balance" (
    id SERIAL PRIMARY KEY,
    ticket_id INTEGER REFERENCES "Balance_ticket"(id) NOT NULL,
    income FLOAT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


SELECT 'Создаем таблицу "Benefit_types"' AS msg;
CREATE TABLE "Benefit_types" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    cost FLOAT NOT NULL
);


SELECT 'Создаем таблицу "Benefit_ticket"' AS msg;
CREATE TABLE "Benefit_ticket" (
    id SERIAL PRIMARY KEY,
    ticket_id INTEGER REFERENCES "Ticket"(id) NOT NULL,
    benefit_type_id INTEGER REFERENCES "Benefit_types"(id) NOT NULL,
    expires_date TIMESTAMPTZ
);


SELECT 'Создаем таблицу "Top_UPs_Benefits"' AS msg;
CREATE TABLE "Top_UPs_Benefits" (
    id SERIAL PRIMARY KEY,
    ticket_id INTEGER REFERENCES "Balance_ticket"(id) NOT NULL,
    income FLOAT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


