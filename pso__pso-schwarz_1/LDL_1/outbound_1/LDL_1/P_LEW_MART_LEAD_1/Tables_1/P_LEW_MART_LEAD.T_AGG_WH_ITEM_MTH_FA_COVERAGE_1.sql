CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_wh_item_mth_fa_coverage_1 (
client_id BIGNUMERIC(38,0),
wh_loc_sid BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
src_itemgrp_int_cd BIGNUMERIC(38,0),
cy_week_partial_week_id BIGNUMERIC(38,0),
month_id BIGNUMERIC(38,0),
byr BIGNUMERIC(38,0),
currency_iso_cd STRING(3) COLLATE 'und:ci',
stock_mth_asis NUMERIC(28,8),
stock_mth_py NUMERIC(28,8),
revenue_mth_asis NUMERIC(28,8),
revenue_mth_py NUMERIC(28,8),
coverage_mth_item_asis NUMERIC(28,8),
coverage_mth_item_py NUMERIC(28,8)
);