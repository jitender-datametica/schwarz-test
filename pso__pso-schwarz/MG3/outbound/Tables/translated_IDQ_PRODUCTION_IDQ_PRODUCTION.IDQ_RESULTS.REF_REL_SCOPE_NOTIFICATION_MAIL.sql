CREATE OR REPLACE TABLE idq_production_idq_results.ref_rel_scope_notification_mail (
id INTEGER NOT NULL,
scope_id INTEGER,
notification_id INTEGER,
email STRING(255),
frequency INTEGER,
inserted_at DATETIME,
PRIMARY KEY (id) NOT ENFORCED
);