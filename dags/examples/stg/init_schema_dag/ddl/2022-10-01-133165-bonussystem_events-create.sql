CREATE TABLE IF NOT EXISTS stg.bonussystem_events (
    id integer NOT NULL,
    event_ts timestamp NOT NULL,
    event_type varchar NOT NULL,
    event_value text NOT NULL,
    CONSTRAINT outbox_pkey PRIMARY KEY (id)
);
CREATE INDEX idx_bonussystem_events__event_ts ON stg.bonussystem_events USING btree (event_ts);