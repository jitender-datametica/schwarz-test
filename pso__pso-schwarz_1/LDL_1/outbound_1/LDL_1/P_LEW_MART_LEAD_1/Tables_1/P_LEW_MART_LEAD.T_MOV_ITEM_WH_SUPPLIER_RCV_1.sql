CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_mov_item_wh_supplier_rcv_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_wh BIGNUMERIC(38,0) NOT NULL,
src_wh_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
sup_sid BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
cy_week BIGNUMERIC(38,0) NOT NULL
) CLUSTER BY dat_formdate;