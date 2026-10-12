CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_kol_adv_item (
client_id BIGNUMERIC(38,0) NOT NULL,
range_plan_cd STRING(20) COLLATE 'und:ci',
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
item_ian BIGNUMERIC(38,0) NOT NULL,
adv_dt DATE NOT NULL,
sales_qty NUMERIC(18,4)
);