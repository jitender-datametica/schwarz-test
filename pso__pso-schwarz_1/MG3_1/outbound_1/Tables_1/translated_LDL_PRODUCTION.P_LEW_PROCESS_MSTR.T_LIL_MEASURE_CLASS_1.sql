CREATE OR REPLACE TABLE ldl_production_p_lew_process_mstr.t_lil_measure_class_1 (
meas_id INTEGER NOT NULL,
class_cd STRING(800) NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);