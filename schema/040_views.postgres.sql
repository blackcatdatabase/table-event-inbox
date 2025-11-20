-- Auto-generated from schema-views-postgres.psd1 (map@9d3471b)
-- engine: postgres
-- table:  event_inbox_metrics
-- Aggregated metrics for [event_inbox]
CREATE OR REPLACE VIEW vw_event_inbox_metrics AS
SELECT
  source,
  COUNT(*)                                AS total,
  COUNT(*) FILTER (WHERE status=''pending'')   AS pending,
  COUNT(*) FILTER (WHERE status=''processed'') AS processed,
  COUNT(*) FILTER (WHERE status=''failed'')    AS failed,
  AVG(attempts)                           AS avg_attempts,
  PERCENTILE_DISC(0.95) WITHIN GROUP (ORDER BY attempts) AS p95_attempts
FROM event_inbox
GROUP BY source;

-- Auto-generated from schema-views-postgres.psd1 (map@9d3471b)
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
  (status = ''failed'') AS is_failed
FROM event_inbox;

