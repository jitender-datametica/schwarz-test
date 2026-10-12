CREATE OR REPLACE TABLE process_mining_production_etl.t_cmn_location_l3_1 (
contact_1 STRING(16777216),
sys_id STRING(16777216) NOT NULL,
sys_updated_on DATETIME NOT NULL,
PRIMARY KEY (sys_id, sys_updated_on) NOT ENFORCED
);