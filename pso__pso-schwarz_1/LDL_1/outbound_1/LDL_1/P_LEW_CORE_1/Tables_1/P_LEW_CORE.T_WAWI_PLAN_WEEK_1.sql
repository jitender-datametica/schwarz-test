CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_plan_week_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
plan_id BIGNUMERIC(38,0) NOT NULL,
indicator_id BIGNUMERIC(38,0) NOT NULL,
dat_dayend DATE,
dat_valid_from DATE,
dat_valid_until DATE,
currency_iso_cd STRING(3) COLLATE 'und:ci',
cy_week BIGNUMERIC(38,0),
wh_loc_sid BIGNUMERIC(38,0),
orig_store_nr BIGNUMERIC(38,0),
itemgroup_int_id BIGNUMERIC(38,0),
orig_item_nr INTEGER,
pct_plan_week NUMERIC(6,2),
val_plan_week NUMERIC(18,4),
load_id BIGNUMERIC(38,0) NOT NULL
);