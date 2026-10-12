CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_stat_order_wk_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
cy_week BIGNUMERIC(38,0) NOT NULL,
py_week BIGNUMERIC(38,0),
currency_iso_cd STRING(3) NOT NULL,
curr_tot_id BIGNUMERIC(38,0),
order_cnt_stationary_wk NUMERIC(18,5),
order_lin_cnt_stationary_wk NUMERIC(18,5),
turnover_net_val_stationary_wk NUMERIC(18,5),
plan_turnover_net_val_stationary_wk NUMERIC(18,5),
order_cnt_stationary_pyw NUMERIC(18,5),
order_lin_cnt_stationary_pyw NUMERIC(18,5),
turnover_net_val_stationary_pyw NUMERIC(18,5)
);