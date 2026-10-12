CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_agg_unq_cust_ldpl_wk_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
cy_week BIGNUMERIC(38,0) NOT NULL,
move_to_store_id BIGNUMERIC(38,0) NOT NULL,
customer_sid BIGNUMERIC(38,0) NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
log_operation STRING(1) COLLATE 'und:ci',
log_ts DATETIME
);