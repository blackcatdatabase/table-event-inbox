# event_inbox

Inbox table for inbound events awaiting processing.

## Columns
| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| attempts | INTEGER | NO | 0 | Number of processing attempts. |
| event_key | CHAR(36) | NO |  | Event key used for idempotency. |
| id | BIGINT | NO |  | Surrogate primary key. |
| last_error | TEXT | YES |  | Last error message written for the event. |
| payload | JSONB | NO |  | JSON payload to be processed. |
| processed_at | TIMESTAMPTZ(6) | YES |  | When processing finished (UTC). |
| received_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | When the event was received (UTC). |
| source | VARCHAR(100) | NO |  | Producer system identifier. |
| status | TEXT | NO | pending | Processing status flag. (enum: pending, processed, failed) |

## Engine Details

### mysql

Unique keys:
| Name | Columns |
| --- | --- |
| uq_event_inbox_key | source, event_key |

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| idx_event_inbox_processed | processed_at | CREATE INDEX idx_event_inbox_processed ON event_inbox (processed_at) |
| idx_event_inbox_status_received | status,received_at | CREATE INDEX idx_event_inbox_status_received ON event_inbox (status, received_at) |
| uq_event_inbox_key | source,event_key | UNIQUE KEY uq_event_inbox_key (`source`, event_key) |

### postgres

Unique keys:
| Name | Columns |
| --- | --- |
| uq_event_inbox_key | source, event_key |

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| gin_event_inbox_payload | payloadjsonb_path_ops | CREATE INDEX IF NOT EXISTS gin_event_inbox_payload ON event_inbox USING GIN (payload jsonb_path_ops) |
| idx_event_inbox_processed | processed_at | CREATE INDEX IF NOT EXISTS idx_event_inbox_processed ON event_inbox (processed_at) |
| idx_event_inbox_status_received | status,received_at | CREATE INDEX IF NOT EXISTS idx_event_inbox_status_received ON event_inbox (status, received_at) |
| uq_event_inbox_key | source,event_key | CONSTRAINT uq_event_inbox_key UNIQUE (source, event_key) |

## Engine differences

## Views
| View | Engine | Flags | File |
| --- | --- | --- | --- |
| vw_event_inbox | mysql | algorithm=MERGE, security=INVOKER | [packages\event-inbox\schema\040_views.mysql.sql](https://github.com/blackcatacademy/blackcat-database/packages/event-inbox/schema/040_views.mysql.sql) |
| vw_event_inbox_metrics | mysql | algorithm=MERGE, security=INVOKER | [packages\event-inbox\schema\040_views_joins.mysql.sql](https://github.com/blackcatacademy/blackcat-database/packages/event-inbox/schema/040_views_joins.mysql.sql) |
| vw_event_inbox | postgres |  | [packages\event-inbox\schema\040_views.postgres.sql](https://github.com/blackcatacademy/blackcat-database/packages/event-inbox/schema/040_views.postgres.sql) |
| vw_event_inbox_metrics | postgres |  | [packages\event-inbox\schema\040_views_joins.postgres.sql](https://github.com/blackcatacademy/blackcat-database/packages/event-inbox/schema/040_views_joins.postgres.sql) |
