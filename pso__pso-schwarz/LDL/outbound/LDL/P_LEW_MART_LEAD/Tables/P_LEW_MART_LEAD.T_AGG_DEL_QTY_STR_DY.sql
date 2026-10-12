CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_del_qty_str_dy (
client_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
loc_sid_store_move_to BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
wh_id BIGNUMERIC(38,0) NOT NULL,
aspect_id BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
cy_month BIGNUMERIC(38,0) NOT NULL,
busyear BIGNUMERIC(38,0) NOT NULL,
del_qty_nfv_val NUMERIC(18,5),
del_qty_fv_val NUMERIC(18,5),
del_qty_brk_alc_val NUMERIC(18,5),
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dat_formdate;