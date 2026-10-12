CREATE OR REPLACE TABLE idq_production_dwh.t_idq_comment_transaction_1 (
idq_test_object_id BIGNUMERIC(38,0) NOT NULL,
ref_rule_id BIGNUMERIC(38,0) NOT NULL,
functional_id STRING(255),
status_comment STRING(512),
status_id STRING(255),
comment_user STRING(255),
comment_update_tmsp TIMESTAMP
);