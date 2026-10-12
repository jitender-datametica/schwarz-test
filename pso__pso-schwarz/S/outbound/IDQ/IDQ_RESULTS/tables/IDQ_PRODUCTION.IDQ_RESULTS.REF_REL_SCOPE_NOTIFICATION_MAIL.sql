CREATE OR REPLACE TABLE idq_production_idq_results.ref_rel_scope_notification_mail (
id BIGNUMERIC(38,0) NOT NULL,
scope_id BIGNUMERIC(38,0),
notification_id BIGNUMERIC(38,0),
email STRING(255),
frequency BIGNUMERIC(38,0),
inserted_at DATETIME,
PRIMARY KEY (id) NOT ENFORCED
);