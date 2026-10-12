CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_period_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
period_sid BIGNUMERIC(38,0) NOT NULL,
src_period_cd STRING(160) NOT NULL,
period_name STRING(800) NOT NULL,
period_type_id BIGNUMERIC(38,0) NOT NULL,
period_type_name STRING(800),
period_year BIGNUMERIC(38,0) NOT NULL,
period_sid_py BIGNUMERIC(38,0),
period_sid_pq BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY client_id;