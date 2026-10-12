CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_ref_dsbrd_d3_parm (
dsbrd_id BIGNUMERIC(38,0) NOT NULL,
int_id BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
aspect_id BIGNUMERIC(38,0) NOT NULL,
wh_id BIGNUMERIC(38,0) NOT NULL,
move_to_store_id BIGNUMERIC(38,0) NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
cy_month BIGNUMERIC(38,0) NOT NULL,
cy_week BIGNUMERIC(38,0) NOT NULL,
byr BIGNUMERIC(38,0) NOT NULL,
log_operation STRING(1) COLLATE 'und:ci',
log_ts DATETIME
);