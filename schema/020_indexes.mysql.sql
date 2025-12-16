-- Auto-generated from schema-map-mysql.yaml (map@sha1:B9D3BE28A74392B9B389FDAFB493BD80FA1F6FA4)
-- engine: mysql
-- table:  event_inbox

CREATE INDEX idx_event_inbox_status_received ON event_inbox (status, received_at);

CREATE INDEX idx_event_inbox_processed ON event_inbox (processed_at);
