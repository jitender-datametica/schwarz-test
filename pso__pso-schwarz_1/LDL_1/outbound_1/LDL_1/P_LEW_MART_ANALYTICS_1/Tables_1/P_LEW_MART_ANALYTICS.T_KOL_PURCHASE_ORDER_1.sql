CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_kol_purchase_order_1 (
client_cd STRING(20) COLLATE 'und:ci',
item_ian INTEGER NOT NULL,
purchase_order_qty BIGNUMERIC(38,0),
dwh_created DATETIME
);