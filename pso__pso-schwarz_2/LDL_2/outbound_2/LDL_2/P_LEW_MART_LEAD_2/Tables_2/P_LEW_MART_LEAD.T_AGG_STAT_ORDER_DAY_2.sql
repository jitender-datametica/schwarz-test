CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_stat_order_day_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
dat_calendar DATE NOT NULL,
py_day DATE,
currency_iso_cd STRING(3) NOT NULL,
curr_tot_id BIGNUMERIC(38,0),
order_cnt_stationary_day NUMERIC(18,5),
order_lin_cnt_stationary_day NUMERIC(18,5),
turnover_net_val_stationary_day NUMERIC(18,5),
plan_turnover_net_val_stationary_day NUMERIC(18,5),
order_cnt_stationary_pyd NUMERIC(18,5),
order_lin_cnt_stationary_pyd NUMERIC(18,5),
turnover_net_val_stationary_pyd NUMERIC(18,5)
);