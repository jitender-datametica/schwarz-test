CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_ldi_order_summary_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
country_cd STRING(2) COLLATE 'und:ci' NOT NULL,
bus_year BIGNUMERIC(38,0) NOT NULL,
month_of_bus_year BIGNUMERIC(38,0) NOT NULL,
adj_order_cnt BIGNUMERIC(38,0),
adj_order_line_cnt BIGNUMERIC(38,0),
adj_turnover_net_val NUMERIC(18,5),
adj_turnover_curr_sid BIGNUMERIC(38,0),
adj_turnover_curr_cd STRING(3) COLLATE 'und:ci',
adj_turnover_eur_net_val NUMERIC(18,5),
plan_turnover_net_val NUMERIC(18,5),
plan_turnover_curr_sid BIGNUMERIC(38,0),
plan_turnover_curr_cd STRING(3) COLLATE 'und:ci',
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);