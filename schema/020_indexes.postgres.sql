-- Auto-generated from schema-map-postgres.yaml (map@sha1:F0EE237771FBA8DD7C4E886FF276F91A862C3718)
-- engine: postgres
-- table:  event_inbox

CREATE INDEX IF NOT EXISTS idx_event_inbox_status_received ON event_inbox (status, received_at);

CREATE INDEX IF NOT EXISTS idx_event_inbox_processed ON event_inbox (processed_at);

CREATE INDEX IF NOT EXISTS gin_event_inbox_payload ON event_inbox USING GIN (payload jsonb_path_ops);
