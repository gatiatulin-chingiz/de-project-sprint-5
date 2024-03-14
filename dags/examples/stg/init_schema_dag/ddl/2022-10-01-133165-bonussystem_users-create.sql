CREATE TABLE IF NOT EXISTS stg.bonussystem_users (
    id integer NOT NULL,
    order_user_id text NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (id)
);