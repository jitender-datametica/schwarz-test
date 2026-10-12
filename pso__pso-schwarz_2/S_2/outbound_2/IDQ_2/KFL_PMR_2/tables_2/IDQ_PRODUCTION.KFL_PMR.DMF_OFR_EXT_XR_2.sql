CREATE OR REPLACE TABLE idq_production_kfl_pmr.dmf_ofr_ext_xr_2 (
mandt STRING(3) NOT NULL,
db_key STRING(255) NOT NULL,
parent_key STRING(255),
node_cat_key STRING(255),
log_sys NUMERIC(5,0),
ext_ofr_id STRING(36),
ofr_id STRING(255),
ext_evt_id STRING(10),
md_system_ref NUMERIC(5,0),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (db_key, mandt) NOT ENFORCED
);