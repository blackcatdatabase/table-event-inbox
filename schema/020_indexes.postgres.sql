-- Auto-generated from schema-map-postgres.psd1 (map@9d3471b)
-- engine: postgres
-- table:  event_inbox
CREATE INDEX IF NOT EXISTS idx_event_inbox_status_received ON event_inbox (status, received_at);

CREATE INDEX IF NOT EXISTS idx_event_inbox_processed ON event_inbox (processed_at);

CREATE INDEX IF NOT EXISTS gin_event_inbox_payload ON event_inbox USING GIN (payload jsonb_path_ops);
