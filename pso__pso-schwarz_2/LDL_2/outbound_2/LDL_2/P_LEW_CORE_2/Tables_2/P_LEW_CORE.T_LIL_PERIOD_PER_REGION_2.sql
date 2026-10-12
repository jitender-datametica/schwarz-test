CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_period_per_region_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
period_sid BIGNUMERIC(38,0) NOT NULL,
region_sid BIGNUMERIC(38,0) NOT NULL,
start_dt DATE,
end_dt DATE,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY client_id;