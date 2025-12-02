-- Auto-generated from joins-postgres.yaml (map@94ebe6c)
-- engine: postgres
-- view:   event_inbox_metrics

-- Aggregated metrics for [event_inbox]
CREATE OR REPLACE VIEW vw_event_inbox_metrics AS
SELECT
  source,
  COUNT(*)                                AS total,
  COUNT(*) FILTER (WHERE status='pending')   AS pending,
  COUNT(*) FILTER (WHERE status='processed') AS processed,
  COUNT(*) FILTER (WHERE status='failed')    AS failed,
  AVG(attempts)                           AS avg_attempts,
  PERCENTILE_DISC(0.95) WITHIN GROUP (ORDER BY attempts) AS p95_attempts
FROM event_inbox
GROUP BY source;
