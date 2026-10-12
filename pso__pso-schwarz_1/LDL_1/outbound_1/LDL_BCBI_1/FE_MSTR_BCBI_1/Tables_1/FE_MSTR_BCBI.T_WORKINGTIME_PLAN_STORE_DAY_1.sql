CREATE TABLE IF NOT EXISTS ldl_bcbi_fe_mstr_bcbi.t_workingtime_plan_store_day_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
cal_dt DATE NOT NULL,
turnover_net_val BIGNUMERIC(38,5),
sales_piece_qty BIGNUMERIC(38,5),
turnover_per_hour_net_val BIGNUMERIC(38,5),
hours_total_cnt BIGNUMERIC(38,5),
hours_working_cnt BIGNUMERIC(38,5),
hours_inventory_cnt BIGNUMERIC(38,5),
hours_training_cnt BIGNUMERIC(38,5) NOT NULL,
hours_misc_cnt BIGNUMERIC(38,5) NOT NULL,
plan_update_tmsp DATETIME,
source_system STRING(20) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
timestamp_load_bcbi TIMESTAMP
);