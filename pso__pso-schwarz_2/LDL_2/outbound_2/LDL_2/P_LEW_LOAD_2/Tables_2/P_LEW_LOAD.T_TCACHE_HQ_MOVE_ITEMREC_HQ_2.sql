CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_hq_move_itemrec_hq_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_id STRING(100) NOT NULL,
receipt_id_rcv BIGNUMERIC(38,0),
ewm_refnr STRING(100),
orig_item_nr BIGNUMERIC(38,0),
case_size BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);