<!-- Auto-generated from schema-map-postgres.psd1 @ 62c9c93 (2025-11-20T21:38:11+01:00) -->
# Definition – event_inbox

Inbox table for inbound events awaiting processing.

## Columns
| Column | Type | Null | Default | Description | Notes |
|-------:|:-----|:----:|:--------|:------------|:------|
| id | BIGINT | — | AS | Surrogate primary key. |  |
| source | VARCHAR(100) | NO | — | Producer system identifier. |  |
| event_key | CHAR(36) | NO | — | Event key used for idempotency. |  |
| payload | JSONB | NO | — | JSON payload to be processed. |  |
| status | TEXT | NO | 'pending' | Processing status flag. | enum: pending, processed, failed |
| attempts | INTEGER | NO | 0 | Number of processing attempts. |  |
| last_error | TEXT | YES | — | Last error message written for the event. |  |
| received_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | When the event was received (UTC). |  |
| processed_at | TIMESTAMPTZ(6) | YES | — | When processing finished (UTC). |  |