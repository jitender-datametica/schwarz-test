CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_agg_wh_wk_nf_alter (
cy_week_partial_week_id BIGNUMERIC(38,0),
cy_week_partial_week_id2 BIGNUMERIC(38,0),
client_id BIGNUMERIC(38,0),
wh_loc_sid BIGNUMERIC(38,0),
currency_iso_cd STRING(3) COLLATE 'und:ci',
byr BIGNUMERIC(38,0),
month_id BIGNUMERIC(38,0),
week_id BIGNUMERIC(38,0),
cur_stock_wh BIGNUMERIC(38,8),
pwd_stock_wh BIGNUMERIC(38,8),
nf_alter_wh_wk_asis BIGNUMERIC(38,8),
nf_alter_wh_wk_pyd BIGNUMERIC(38,8),
nf_alter_wh_mth_asis BIGNUMERIC(38,8),
nf_alter_wh_mth_pyd BIGNUMERIC(38,8),
nf_alter_wh_py_asis BIGNUMERIC(38,8),
nf_alter_wh_py_pyd BIGNUMERIC(38,8)
);