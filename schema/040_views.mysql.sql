-- Auto-generated from schema-views-mysql.psd1 (map@db2f8b8)
-- engine: mysql
-- table:  event_inbox_metrics
-- Aggregated metrics for [event_inbox]
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_event_inbox_metrics AS
WITH base AS (
  SELECT
    source,
    COUNT(*) AS total,
    SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END)   AS pending,
    SUM(CASE WHEN status = 'processed' THEN 1 ELSE 0 END) AS processed,
    SUM(CASE WHEN status = 'failed' THEN 1 ELSE 0 END)    AS failed,
    AVG(attempts) AS avg_attempts
  FROM event_inbox
  GROUP BY source
),
ranked AS (
  SELECT
    source,
    attempts,
    ROW_NUMBER() OVER (PARTITION BY source ORDER BY attempts) AS rn,
    COUNT(*) OVER (PARTITION BY source) AS cnt
  FROM event_inbox
),
pcts AS (
  SELECT
    source,
    MAX(CASE WHEN rn = CEIL(0.95 * cnt) THEN attempts END) AS p95_attempts
  FROM ranked
  GROUP BY source
)
SELECT
  b.source,
  b.total,
  b.pending,
  b.processed,
  b.failed,
  b.avg_attempts,
  p.p95_attempts
FROM base b
LEFT JOIN pcts p ON p.source = b.source;

-- Auto-generated from schema-views-mysql.psd1 (map@db2f8b8)
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

