-- Auto-generated from schema-views-mysql.yaml (map@sha1:A4E10261DACB7519F6FEA44ED77A92163429CA5E)
-- engine: mysql
-- table:  event_inbox

-- Contract view for [event_inbox]
-- Adds helper: is_failed.
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_event_inbox AS
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
