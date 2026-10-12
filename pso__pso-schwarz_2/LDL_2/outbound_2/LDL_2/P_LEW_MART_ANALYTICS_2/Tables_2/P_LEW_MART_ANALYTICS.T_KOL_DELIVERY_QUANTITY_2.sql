CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_kol_delivery_quantity_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_ian INTEGER NOT NULL,
orig_store_nr BIGNUMERIC(38,0) NOT NULL,
adv_store_dt DATE NOT NULL,
adv_ian_dt DATE NOT NULL,
range_plan_cd STRING(20) COLLATE 'und:ci',
delivery_qty NUMERIC(18,4)
);