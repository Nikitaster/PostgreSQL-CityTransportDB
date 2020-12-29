

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
    address VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL
);


SELECT 'Создаем таблицу "Route"' AS msg;
CREATE TABLE "Route" (
    route_number SERIAL PRIMARY KEY,
    name VARCHAR(64) NOT NULL
);


SELECT 'Создаем таблицу "Stops_route"' AS msg;
CREATE TABLE "Stops_route" (
    id SERIAL PRIMARY KEY,
    stop_id INTEGER REFERENCES "Stop"(id) NOT NULL,
    route_id INTEGER REFERENCES "Route"(route_number) NOT NULL,
    stop_number INTEGER NOT NULL
);


SELECT 'Создаем таблицу "Vehicle"' AS msg;
CREATE TABLE "Vehicle" (
    license_number VARCHAR(6) PRIMARY KEY,
    type_id INTEGER REFERENCES "VehicleTypes"(id) NOT NULL,
    route_number INTEGER REFERENCES "Route"(route_number) NOT NULL,
    driver_id INTEGER REFERENCES "Staff"(id)
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
    vehicle VARCHAR(6) REFERENCES "Vehicle"(license_number) NOT NULL,
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


SELECT 'Заполняем таблицу "VehicleTypes"' AS msg;
INSERT INTO "VehicleTypes"(type_name, seats_number, price) values ('Автобус', 90, 55);
INSERT INTO "VehicleTypes"(type_name, seats_number, price) values ('Микроавтобус', 15, 55);
INSERT INTO "VehicleTypes"(type_name, seats_number, price) values ('Электробус', 90, 55);


SELECT 'Заполняем таблицу "Roles"' AS msg;
INSERT INTO "Roles"(name) values ('Водитель');
INSERT INTO "Roles"(name) values ('Кассир');
INSERT INTO "Roles"(name) values ('Контроллер');
INSERT INTO "Roles"(name) values ('Директор');


SELECT 'Заполняем таблицу "Staff"' AS msg;
INSERT INTO "Staff"(role_id, FIO, phone_number) values ((SELECT id FROM "Roles" WHERE name = 'Водитель'), 'Водилов Водил Водилович', '81234567890');
INSERT INTO "Staff"(role_id, FIO, phone_number) values ((SELECT id FROM "Roles" WHERE name = 'Водитель'), 'Рулилов Рулил Рулилыч', '89876543321');
INSERT INTO "Staff"(role_id, FIO, phone_number) values ((SELECT id FROM "Roles" WHERE name = 'Кассир'), 'Кассиров Кассир Кассирович', '89843241221');


SELECT 'Заполняем таблицу "Stop"' AS msg;
INSERT INTO "Stop"(address, name) values ('Улица Рабочая, дом 1', 'Улица Рабочая, 1');
INSERT INTO "Stop"(address, name) values ('Улица Рабочая, дом 12', 'Поликлиника');
INSERT INTO "Stop"(address, name) values ('Улица Капитана Воробья, дом 5', 'Лицей');
INSERT INTO "Stop"(address, name) values ('Проспект Авроры, дом 1', 'Проспект Авроры');
INSERT INTO "Stop"(address, name) values ('Улица Механиков, дом 30', 'Автобусное депо');
INSERT INTO "Stop"(address, name) values ('Улица Вялого сетевика, дом 2', 'Храм');
INSERT INTO "Stop"(address, name) values ('Улица Питонистов, дом 12', 'Городской зоопарк');
INSERT INTO "Stop"(address, name) values ('Улица Торговая, дом 50', 'Рыночный комплекс');
INSERT INTO "Stop"(address, name) values ('Улица Рабочая, дом 10', 'Улица Рабочая, 10');
INSERT INTO "Stop"(address, name) values ('Улица Рабочая, дом 42', 'Лицей');
INSERT INTO "Stop"(address, name) values ('Улица Капитана Врангеля, дом 1', 'Пирс');
INSERT INTO "Stop"(address, name) values ('Улица Строителей, дом 12', 'Музей отечественного кино');
INSERT INTO "Stop"(address, name) values ('Улица Механиков, дом 9', 'Вокзал');
INSERT INTO "Stop"(address, name) values ('Проспект Авиации, дом 1', 'Аэропорт');
INSERT INTO "Stop"(address, name) values ('Улица Торговая, дом 40', 'Кинотеатр');


SELECT 'Заполняем таблицу "Route"' AS msg;
INSERT INTO "Route" (route_number, name) values (1, '1Т');
INSERT INTO "Route" (route_number, name) values (2, '2Т');
INSERT INTO "Route" (route_number, name) values (3, '3Т');
INSERT INTO "Route" (route_number, name) values (4, '4Т');
INSERT INTO "Route" (route_number, name) values (5, '5Т');


SELECT 'Заполняем таблицу "Stops_route"' AS msg;
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (1, 1, 1);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (2, 1, 2);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (3, 1, 3);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (4, 1, 4);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (5, 1, 5);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (6, 1, 6);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (7, 1, 7);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (8, 1, 8);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (9, 1, 9);

INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (1, 2, 1);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (4, 2, 2);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (3, 2, 3);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (6, 2, 4);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (5, 2, 5);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (8, 2, 6);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (7, 2, 7);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (10, 2, 8);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (13, 2, 9);

INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (9, 3, 1);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (14, 3, 2);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (10, 3, 3);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (15, 3, 4);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (12, 3, 5);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (7, 3, 6);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (4, 3, 7);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (2, 3, 8);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (1, 3, 9);

INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (10, 4, 1);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (8, 4, 2);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (15, 4, 3);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (13, 4, 4);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (10, 4, 5);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (6, 4, 6);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (2, 4, 7);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (1, 4, 8);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (4, 4, 9);

INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (10, 5, 2);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (14, 5, 2);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (13, 5, 3);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (6, 5, 4);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (15, 5, 5);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (8, 5, 6);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (7, 5, 7);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (2, 5, 8);
INSERT INTO "Stops_route" (stop_id, route_id, stop_number) values (5, 5, 9);


SELECT 'Заполняем таблицу "Vehicle"' AS msg;
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('A123BD', 1, 1);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('A456BD', 1, 1);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('A890BD', 1, 1);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('A098BD', 2, 1);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('A765BD', 2, 1);

INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('A223BD', 1, 2);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('A256BD', 1, 2);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('A290BD', 1, 2);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('A298BD', 2, 2);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('A265BD', 2, 2);

INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('C356BD', 1, 3);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('D323BD', 1, 3);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('C390BD', 1, 3);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('E398BD', 2, 3);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('F365BD', 2, 3);

INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('L356BD', 1, 4);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('L323BD', 1, 4);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('L390BD', 1, 4);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('L398BD', 2, 4);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('L365BD', 2, 4);

INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('U356BD', 1, 5);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('U323BD', 1, 5);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('U390BD', 1, 5);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('U398BD', 2, 5);
INSERT INTO "Vehicle" (license_number, type_id, route_number) values ('U365BD', 2, 5);


SELECT 'Заполняем таблицу "Benefit_types"' AS msg;
INSERT INTO "Benefit_types" (name, cost) values ('Пенсионный', 0);
INSERT INTO "Benefit_types" (name, cost) values ('Студенческий', 500);


SELECT 'Создаем триггер на оплату проезда' AS msg;
CREATE FUNCTION payment_func() RETURNS trigger AS $$
    DECLARE
        price FLOAT := 0;
    BEGIN
        IF (SELECT ticket_id FROM "Trips_ticket" WHERE ticket_id = NEW.ticket_id) IS NOT NULL THEN
            IF ((SELECT trips_amount FROM "Trips_ticket" WHERE ticket_id = NEW.ticket_id) > 0) THEN
                EXECUTE 'UPDATE "Trips_ticket" SET trips_amount = trips_amount - 1 WHERE ticket_id = ' || NEW.ticket_id;
            ELSE 
                RAISE EXCEPTION 'НЕТ ПОЕЗДОК!';
            END IF;

        ELSEIF (SELECT ticket_id FROM "Balance_ticket" WHERE ticket_id = NEW.ticket_id) IS NOT NULL THEN
            EXECUTE FORMAT('select price_subquery.price from (
                SELECT price from "VehicleTypes" where id = (
                        SELECT type_id from "Vehicle" where license_number = %L
                    )
                ) as price_subquery',
            NEW.vehicle) into price;
            IF ((SELECT balance FROM "Balance_ticket" WHERE ticket_id = NEW.ticket_id) >= price) THEN
                EXECUTE FORMAT('UPDATE "Balance_ticket" SET balance = balance - ' || price || ' WHERE ticket_id = ' || NEW.ticket_id, NEW.vehicle);
            ELSE 
                RAISE EXCEPTION 'НЕДОСТАТОЧНО СРЕДСТВ!';
            END IF;

        ELSEIF (SELECT ticket_id FROM "Benefit_ticket" WHERE ticket_id = NEW.ticket_id) IS NOT NULL THEN
            IF (SELECT expires_date FROM "Benefit_ticket" WHERE ticket_id = NEW.ticket_id) < NOW() THEN
                RAISE EXCEPTION 'ИСТЕК СРОК ЛЬГОТЫ!';
            END IF;

        ELSE
            RAISE EXCEPTION 'Invalid ticket';
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER PAYMENT_TRIGGER BEFORE INSERT ON "Payments"
    FOR EACH ROW EXECUTE PROCEDURE payment_func();


SELECT 'Создаем триггер на пополнение билета с балансом' AS msg;
CREATE FUNCTION balance_top_up() RETURNS trigger AS $$
    BEGIN
        EXECUTE 'UPDATE "Balance_ticket" SET balance = balance + ' || NEW.income || ' WHERE id = ' || NEW.ticket_id;
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

CREATE TRIGGER PAYMENT_TRIGGER AFTER INSERT ON "Top_UPs_Balance"
    FOR EACH ROW EXECUTE PROCEDURE balance_top_up();


SELECT 'Создаем триггер на продление льготных билетов' AS msg;
CREATE FUNCTION benefit_top_up() RETURNS trigger AS $$
    BEGIN
        IF NEW.income >= (SELECT bt.cost FROM "Benefit_types" bt 
            inner join "Benefit_ticket" b on b.benefit_type_id = bt.id 
            WHERE b.id = NEW.ticket_id
        ) THEN
            EXECUTE FORMAT('UPDATE "Benefit_ticket" SET expires_date = %L WHERE id = ' || NEW.ticket_id, ('now'::timestamp + '1 month'::interval));
        ELSE
            RAISE EXCEPTION 'НЕ ХВАТАЕТ СРЕДСТВ ДЛЯ АКТИВАЦИИ ЛЬГОТНОГО ТАРИФА!';
        END IF;
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

CREATE TRIGGER PAYMENT_TRIGGER AFTER INSERT ON "Top_UPs_Benefits"
    FOR EACH ROW EXECUTE PROCEDURE benefit_top_up();


SELECT 'Создаем билеты' AS msg;

INSERT INTO "Ticket" DEFAULT VALUES;
INSERT INTO "Trips_ticket"(ticket_id, trips_amount) VALUES (1, 2);

INSERT INTO "Payments" (ticket_id, vehicle) VALUES (1, 'A890BD');
INSERT INTO "Payments" (ticket_id, vehicle) VALUES (1, 'A890BD');
SELECT * FROM "Payments";
SELECT * FROM "Trips_ticket";


INSERT INTO "Ticket" DEFAULT VALUES;
INSERT INTO "Balance_ticket"(ticket_id, balance) VALUES (2, 100);

INSERT INTO "Payments" (ticket_id, vehicle) VALUES (2, 'A890BD');
INSERT INTO "Top_UPs_Balance"(ticket_id, income) values (1, 1000);
SELECT * FROM "Payments";
SELECT * FROM "Balance_ticket";


INSERT INTO "Ticket" DEFAULT VALUES;
INSERT INTO "Benefit_ticket"(ticket_id, benefit_type_id, expires_date) VALUES (3, 2, to_timestamp('01-01-2019', 'DD-MM-YYYY'));

-- INSERT INTO "Payments" (ticket_id, vehicle) VALUES (3, 'A890BD');
INSERT INTO "Top_UPs_Benefits"(ticket_id, income) values (1, 1000);
SELECT * FROM "Payments";
SELECT * FROM "Benefit_ticket";





SELECT 'Создаем пользователя "admin"' AS msg;
CREATE USER admin WITH ENCRYPTED PASSWORD 'admin';

SELECT 'Выдаем полные парва пользователю "admin" к базе "CityTransportDB" и всем таблицам' AS msg;
GRANT ALL PRIVILEGES ON DATABASE "CityTransportDB" to admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to admin;