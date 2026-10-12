CREATE OR REPLACE TABLE process_mining_production_etl.t_cmdb_ci_l3_1 (
assigned_to STRING(16777216),
attested_by STRING(16777216),
u_division_contact STRING(16777216),
u_last_audit_by STRING(16777216),
managed_by STRING(16777216),
u_created_by STRING(16777216),
owned_by STRING(16777216),
u_owned_by_deputy STRING(16777216),
supported_by STRING(16777216),
u_updated_by STRING(16777216),
sys_id STRING(16777216) NOT NULL,
sys_updated_on DATETIME NOT NULL,
PRIMARY KEY (sys_id, sys_updated_on) NOT ENFORCED
);