CREATE OR REPLACE TABLE ldl_production_p_lew_process_mstr.t_lil_measure_type_1 (
meas_tp_id INTEGER NOT NULL,
meas_tp_desc STRING(800) NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);