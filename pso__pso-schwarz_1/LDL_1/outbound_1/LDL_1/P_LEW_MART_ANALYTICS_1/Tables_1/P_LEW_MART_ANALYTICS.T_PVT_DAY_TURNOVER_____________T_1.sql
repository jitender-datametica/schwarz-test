CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_pvt_day_turnover_____________t_1 (
client_id BIGNUMERIC(38,0),
orig_item_nr BIGNUMERIC(38,0),
receipt_dt DATE,
week_id BIGNUMERIC(38,0),
pv_id BIGNUMERIC(38,0),
retail_asis_val NUMERIC(18,5),
piece_asis_qty NUMERIC(18,5),
price_retail_old_pv NUMERIC(18,5),
price_retail_new_pv NUMERIC(18,5),
price_retail_asis NUMERIC(18,5),
partkey STRING(300) COLLATE 'und:ci',
uap_filename STRING(300) COLLATE 'und:ci',
mod_tmsp DATETIME
);