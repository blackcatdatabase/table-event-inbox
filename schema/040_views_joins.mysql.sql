-- Auto-generated from joins-mysql.yaml (map@sha1:DA70105A5B799F72A56FEAB71A5171F946A770D2)
-- engine: mysql
-- view:   event_inbox_metrics

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
