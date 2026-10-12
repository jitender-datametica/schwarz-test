CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_cust_cnt_wh_str_day_spot (
client_id BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
aspect_id BIGNUMERIC(38,0),
store_id BIGNUMERIC(38,0),
currency_iso_cd STRING(3) COLLATE 'und:ci',
business_yr BIGNUMERIC(38,0),
month_id BIGNUMERIC(38,0),
week_id BIGNUMERIC(38,0),
dat_calendar DATE,
last_cwd_fg BIGNUMERIC(38,0),
last_cmd_fg BIGNUMERIC(38,0),
ber_st_fg BIGNUMERIC(38,0),
dup_fg BIGNUMERIC(38,0),
cust_cnt BIGNUMERIC(38,8),
p1y_cwd_cust_cnt BIGNUMERIC(38,8),
p1y_cmd_cust_cnt BIGNUMERIC(38,8),
p1y_ber_cust_cnt BIGNUMERIC(38,8)
);