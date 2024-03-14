DROP TABLE IF EXISTS stg.ordersystem_orders;
CREATE TABLE stg.ordersystem_orders (
    id serial4 NOT NULL,
    object_id varchar NOT NULL,
    object_value text NOT NULL,
    update_ts timestamp NOT NULL,
    CONSTRAINT ordersystem_orders_pkey PRIMARY KEY (id)
);
CREATE UNIQUE INDEX ordersystem_orders_object_id_idx on stg.ordersystem_orders (object_id);
