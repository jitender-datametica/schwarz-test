CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_period_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
period_sid BIGNUMERIC(38,0) NOT NULL,
period_id BIGNUMERIC(38,0) NOT NULL,
period_lvl BIGNUMERIC(38,0) NOT NULL,
liam_avbl_fg BIGNUMERIC(38,0),
lift_avbl_fg BIGNUMERIC(38,0),
active_fg BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);