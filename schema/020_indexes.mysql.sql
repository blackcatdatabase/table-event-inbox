-- Auto-generated from schema-map-mysql.yaml (map@sha1:5E62933580349BE7C623D119AC9D1301A62F03EF)
-- engine: mysql
-- table:  event_inbox

CREATE INDEX idx_event_inbox_status_received ON event_inbox (status, received_at);

CREATE INDEX idx_event_inbox_processed ON event_inbox (processed_at);
