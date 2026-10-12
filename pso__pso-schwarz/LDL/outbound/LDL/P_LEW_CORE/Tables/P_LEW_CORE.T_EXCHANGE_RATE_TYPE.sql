CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_exchange_rate_type (
client_id BIGNUMERIC(38,0) NOT NULL,
x_rate_type_sid BIGNUMERIC(38,0) NOT NULL,
src_kurst STRING(160),
curr_sid BIGNUMERIC(38,0),
x_rate_type_name STRING(800),
curr_cd STRING(160),
fixed_rate_fg BIGNUMERIC(38,0),
special_rate_fg BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);