CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_miss_itm_wh_day_asis_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
wh_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
cy_month BIGNUMERIC(38,0),
cy_partial_week_id BIGNUMERIC(38,0),
cy_week BIGNUMERIC(38,0),
busyear BIGNUMERIC(38,0),
miss_itm_wh_fg BIGNUMERIC(38,0),
miss_itm_store_15_fg BIGNUMERIC(38,0),
miss_item_fg BIGNUMERIC(38,0)
);