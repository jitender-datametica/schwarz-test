CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_sup_deliv_loyalty_1 (
sup_sid BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0),
target_deliv_date DATE NOT NULL,
dispo_type STRING(20) COLLATE 'und:ci',
sum_qty_total_rcv_day INTEGER,
sum_qty_order INTEGER
);