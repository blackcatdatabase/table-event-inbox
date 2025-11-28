-- Auto-generated from schema-views-postgres.psd1 (map@mtime:2025-11-27T15:36:13Z)
-- engine: postgres
-- table:  event_inbox

-- Contract view for [event_inbox]
-- Adds helper: is_failed.
CREATE OR REPLACE VIEW vw_event_inbox AS
SELECT
  id,
  source,
  event_key,
  payload,
  status,
  attempts,
  last_error,
  received_at,
  processed_at,
  (status = 'failed') AS is_failed
FROM event_inbox;
