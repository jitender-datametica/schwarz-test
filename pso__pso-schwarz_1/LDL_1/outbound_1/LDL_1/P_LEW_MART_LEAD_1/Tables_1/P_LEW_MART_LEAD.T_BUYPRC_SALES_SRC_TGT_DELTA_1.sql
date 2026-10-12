CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_buyprc_sales_src_tgt_delta_1 (
client_id BIGNUMERIC(38,0),
dwh_cal_dt DATE,
buy_prc_delta BIGNUMERIC(38,11),
sales_val_delta BIGNUMERIC(38,5),
sales_qty_delta BIGNUMERIC(38,11)
);