-- Auto-generated from schema-map-mysql.psd1 (map@mtime:2025-11-27T15:13:14Z)
-- engine: mysql
-- table:  event_inbox

CREATE INDEX idx_event_inbox_status_received ON event_inbox (status, received_at);

CREATE INDEX idx_event_inbox_processed ON event_inbox (processed_at);
