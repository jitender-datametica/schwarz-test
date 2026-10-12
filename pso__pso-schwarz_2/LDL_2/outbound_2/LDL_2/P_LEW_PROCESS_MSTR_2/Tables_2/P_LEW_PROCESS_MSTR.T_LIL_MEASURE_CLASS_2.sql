CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_measure_class_2 (
meas_id BIGNUMERIC(38,0) NOT NULL,
class_cd STRING(800) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);