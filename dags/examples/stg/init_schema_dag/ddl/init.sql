
drop schema dds cascade;
create schema dds;
DROP TABLE IF EXISTS dds.fct_product_sales;
DROP TABLE IF EXISTS dds.srv_wf_settings;
DROP TABLE IF EXISTS dds.dm_orders;
DROP TABLE IF EXISTS dds.dm_products;
DROP TABLE IF EXISTS dds.dm_restaurants;
DROP TABLE IF EXISTS dds.dm_users;
DROP TABLE IF EXISTS dds.dm_timestamps;


CREATE TABLE dds.srv_wf_settings(
    id int NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,

    workflow_key varchar UNIQUE,
    workflow_settings text
);

CREATE TABLE dds.dm_restaurants(
    id int NOT NULL PRIMARY KEY,

    restaurant_id varchar NOT NULL,
    restaurant_name text NOT NULL,

    active_from timestamp NOT NULL,
    active_to timestamp NOT NULL
);

CREATE TABLE dds.dm_products (
    id int NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,

    product_id varchar NOT NULL,
    product_name text NOT NULL,
    product_price numeric(19, 5) NOT NULL DEFAULT 0 CHECK (product_price >= 0),

    active_from timestamp NOT NULL,
    active_to timestamp NOT NULL,

    restaurant_id int NOT NULL REFERENCES dds.dm_restaurants(id)
);
CREATE UNIQUE INDEX dm_products_product_id_idx on dds.dm_products (product_id);

CREATE TABLE IF NOT EXISTS dds.dm_timestamps(
    id int NOT NULL PRIMARY KEY,

    ts timestamp NOT NULL UNiQUE,

    year int NOT NULL CHECK(year >= 2020 AND year < 2500),
    month int NOT NULL CHECK(month >= 0 AND month <= 12),
    day int NOT NULL CHECK(day >= 0 AND day <= 31),
    time time NOT NULL,
    date date NOT NULL
);

CREATE TABLE dds.dm_users(
    id int NOT NULL PRIMARY KEY,

    user_id varchar NOT NULL,
    user_name varchar NOT NULL,
    user_login varchar NOT NULL
);

drop table if exists dds.dm_couriers;
create table dds.dm_couriers(
id integer primary key,
courier_id varchar not null,
courier_name varchar not null
);

CREATE TABLE dds.dm_orders(
    id int NOT NULL PRIMARY KEY,

    order_key varchar NOT NULL,
    order_status varchar NOT NULL,

    restaurant_id int NOT NULL REFERENCES dds.dm_restaurants(id),
    timestamp_id int NOT NULL REFERENCES dds.dm_timestamps(id),
    user_id int NOT NULL REFERENCES dds.dm_users(id)
);
CREATE UNIQUE INDEX dm_orders_id_idx on dds.dm_orders (id);

drop table if exists dds.dm_deliveries;
create table dds.dm_deliveries(
id integer primary key,
delivery_id varchar not null,
address varchar not null,
order_id integer not null,
courier_id integer not null,
timestamp_id integer not null,
constraint delivery_order_fk foreign key(order_id) references dds.dm_orders(id),
constraint delivery_courier_fk foreign key(courier_id) references dds.dm_couriers(id),
constraint delivery_timestamp_fk foreign key(timestamp_id) references dds.dm_timestamps(id)
);

drop table if exists dds.fct_deliveries;
create table dds.fct_deliveries(
id integer primary key,
delivery_id integer not null,
rate integer not null,
sum decimal(14,2) not null,
tip_sum decimal(14,2) not null,
order_id integer not null,
courier_id integer not null,
timestamp_id integer not null,
constraint fct_del_fk foreign key(delivery_id) references dds.dm_deliveries(id),
constraint fct_del_order_fk foreign key(order_id) references dds.dm_orders(id),
constraint fct_del_courier_fk foreign key(courier_id) references dds.dm_couriers(id),
constraint fct_del_timestamp_fk foreign key(timestamp_id) references dds.dm_timestamps(id)
);

CREATE TABLE dds.fct_product_sales (
    id int NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    product_id int NOT NULL REFERENCES dds.dm_products(id),
    order_id int NOT NULL REFERENCES dds.dm_orders(id),
    count int NOT NULL DEFAULT 0 CHECK (count >= 0),
    price numeric(19, 5) NOT NULL DEFAULT 0 CHECK (price >= 0),
    total_sum numeric(19, 5) NOT NULL DEFAULT 0 CHECK (total_sum >= 0),
    bonus_payment numeric(19, 5) NOT NULL DEFAULT 0 CHECK (bonus_payment >= 0),
    bonus_grant numeric(19, 5) NOT NULL DEFAULT 0 CHECK (bonus_grant >= 0),
    courier_tips_sum numeric(19, 5) NOT NULL DEFAULT 0 CHECK (courier_tips_sum >= 0)
);
CREATE UNIQUE INDEX fct_product_sales_idx on dds.fct_product_sales (order_id, product_id);
