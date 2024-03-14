DROP TABLE IF EXISTS stg.ordersystem_users;
CREATE TABLE stg.ordersystem_users (
    id serial4 NOT NULL,
    object_id varchar NOT NULL,
    object_value text NOT NULL,
    update_ts timestamp NOT NULL,
    CONSTRAINT ordersystem_users_pkey PRIMARY KEY (id)
);
CREATE UNIQUE INDEX ordersystem_users_object_id_idx on stg.ordersystem_users (object_id);