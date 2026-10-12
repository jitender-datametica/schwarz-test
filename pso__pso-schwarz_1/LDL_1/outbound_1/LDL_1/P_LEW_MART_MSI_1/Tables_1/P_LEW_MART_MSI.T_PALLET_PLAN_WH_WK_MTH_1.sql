CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_pallet_plan_wh_wk_mth_1 (
client_id BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
aspect_id BIGNUMERIC(38,0),
currency_iso_cd STRING(3) COLLATE 'und:ci',
byr BIGNUMERIC(38,0),
cy_month BIGNUMERIC(38,0),
cy_week_partial_week_id BIGNUMERIC(38,0),
cy_month_sequence BIGNUMERIC(38,0),
record_type STRING(10) COLLATE 'und:ci',
pallet_plan_rcv_cum_mth BIGNUMERIC(38,8),
pallet_plan_time_cum_mth BIGNUMERIC(38,8),
pallet_plan_rcv_cum_yr BIGNUMERIC(38,8),
pallet_plan_time_cum_yr BIGNUMERIC(38,8)
);