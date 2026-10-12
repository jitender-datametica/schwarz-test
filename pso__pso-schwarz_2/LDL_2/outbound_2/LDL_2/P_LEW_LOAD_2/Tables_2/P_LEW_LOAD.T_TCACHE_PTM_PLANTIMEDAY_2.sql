CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_ptm_plantimeday_2 (
client_id BIGNUMERIC(38) NOT NULL,
bic_zmlila STRING(40) NOT NULL,
loc_sid_store BIGNUMERIC(38) NOT NULL,
cal_dt DATE NOT NULL,
turnover_net_val NUMERIC(18,5),
turnover_per_hour_net_val NUMERIC(18,5),
hours_total_cnt NUMERIC(18,5),
hours_working_cnt NUMERIC(18,5),
hours_inventory_cnt NUMERIC(18,5),
hours_training_cnt NUMERIC(18,5),
hours_misc_cnt NUMERIC(18,5),
plan_update_tmsp DATETIME,
source_system STRING(20) COLLATE 'und:ci',
file_record_id BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);