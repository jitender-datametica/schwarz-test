CREATE OR REPLACE TABLE ldl_production_p_lew_process_mstr.t_lil_region_per_latest_1 (
client_id INTEGER NOT NULL,
region_sid INTEGER NOT NULL,
per_tp_id INTEGER NOT NULL,
class_cd STRING(800) NOT NULL,
ltst_per_id INTEGER NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);