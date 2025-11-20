-- Auto-generated from schema-map-mysql.psd1 (map@734a489)
-- engine: mysql
-- table:  event_inbox
CREATE INDEX idx_event_inbox_status_received ON event_inbox (status, received_at);

CREATE INDEX idx_event_inbox_processed ON event_inbox (processed_at);
