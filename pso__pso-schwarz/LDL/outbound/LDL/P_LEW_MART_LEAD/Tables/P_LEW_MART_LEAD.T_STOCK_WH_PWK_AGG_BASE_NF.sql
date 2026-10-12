CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_stock_wh_pwk_agg_base_nf (
client_id BIGNUMERIC(38,0),
src_wh_id BIGNUMERIC(38,0),
loc_sid_wh BIGNUMERIC(38,0),
curr_cd STRING(3) COLLATE 'und:ci',
dwh_cal_dt DATE,
cy_week_id BIGNUMERIC(38,0),
cy_week_partial_week_id BIGNUMERIC(38,0),
cy_week_partial_week_id2 BIGNUMERIC(38,0),
cy_month_id BIGNUMERIC(38,0),
byr BIGNUMERIC(38,0),
last_day_of_wk_fg BIGNUMERIC(38,0),
last_day_month_fg BIGNUMERIC(38,0),
stock_wh_asis NUMERIC(28,8),
stock_wh_scdp1y NUMERIC(28,8),
stock_wh_wk_pyd NUMERIC(28,8)
) CLUSTER BY dwh_cal_dt, client_id;