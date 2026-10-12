CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_period_type (
period_type_id BIGNUMERIC(38,0) NOT NULL,
period_type_desc STRING(800) NOT NULL,
ltst_pseudo_period_id BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);