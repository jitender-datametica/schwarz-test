CREATE OR REPLACE TABLE process_mining_production_etl.t_sys_audit_l2_2 (
documentkey STRING(16777216),
fieldname STRING(16777216),
internal_checkpoint STRING(16777216),
newvalue STRING(16777216),
oldvalue STRING(16777216),
reason STRING(16777216),
record_checkpoint BIGNUMERIC(38,0),
sys_created_on DATETIME,
tablename STRING(16777216),
sys_id STRING(16777216) NOT NULL,
PRIMARY KEY (sys_id) NOT ENFORCED
);