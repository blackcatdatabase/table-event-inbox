-- Auto-generated from schema-map-mysql.yaml (map@sha1:09DF9CA612D1573E058190CC207FA257C05AEC1F)
-- engine: mysql
-- table:  event_inbox

CREATE TABLE IF NOT EXISTS event_inbox (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `source` VARCHAR(100) NOT NULL,
  event_key CHAR(36) NOT NULL,
  payload JSON NOT NULL,
  status ENUM('pending','processed','failed') NOT NULL DEFAULT 'pending',
  attempts INT UNSIGNED NOT NULL DEFAULT 0,
  last_error TEXT NULL,
  received_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  processed_at DATETIME(6) NULL,
  UNIQUE KEY uq_event_inbox_key (`source`, event_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
