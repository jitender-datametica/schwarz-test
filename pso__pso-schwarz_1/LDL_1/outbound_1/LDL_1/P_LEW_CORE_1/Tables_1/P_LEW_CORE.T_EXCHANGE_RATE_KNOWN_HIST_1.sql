CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_exchange_rate_known_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
curr_sid_from BIGNUMERIC(38,0) NOT NULL,
curr_sid_to BIGNUMERIC(38,0) NOT NULL,
x_rate_type_sid BIGNUMERIC(38,0) NOT NULL,
active_from_dt DATE NOT NULL,
active_to_dt DATE NOT NULL,
curr_cd_from STRING(160),
curr_cd_to STRING(160),
exchange_rate NUMERIC(18,5),
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);