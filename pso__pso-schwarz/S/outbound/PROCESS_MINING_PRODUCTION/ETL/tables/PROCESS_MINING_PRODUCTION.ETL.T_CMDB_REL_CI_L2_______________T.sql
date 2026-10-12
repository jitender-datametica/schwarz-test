CREATE OR REPLACE TABLE process_mining_production_etl.t_cmdb_rel_ci_l2_______________t (
child STRING(16777216),
connection_strength STRING(16777216),
parent STRING(16777216),
percent_outage BIGNUMERIC(38,0),
port BIGNUMERIC(38,0),
sys_created_on DATETIME,
sys_mod_count BIGNUMERIC(38,0),
type STRING(16777216),
u_global_id STRING(16777216),
u_source STRING(16777216),
sys_id STRING(16777216) NOT NULL,
sys_updated_on DATETIME NOT NULL,
PRIMARY KEY (sys_id, sys_updated_on) NOT ENFORCED
);