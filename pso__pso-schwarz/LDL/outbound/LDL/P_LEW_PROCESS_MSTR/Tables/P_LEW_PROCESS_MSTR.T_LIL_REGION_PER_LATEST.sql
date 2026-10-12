CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_region_per_latest (
client_id BIGNUMERIC(38,0) NOT NULL,
region_sid BIGNUMERIC(38,0) NOT NULL,
per_tp_id BIGNUMERIC(38,0) NOT NULL,
class_cd STRING(800) NOT NULL,
ltst_per_id BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);