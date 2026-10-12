CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_rev_topsell_store_hr (
client_id BIGNUMERIC(38,0),
dat_formdate DATE,
loc_sid_store_move_to BIGNUMERIC(38,0),
wh_loc_sid BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
cy_week BIGNUMERIC(38,0),
time_hour_id BIGNUMERIC(38,0),
receipt_for_count_id BIGNUMERIC(38,0),
qty_piece_ejr NUMERIC(18,5),
qty_weight_ejr NUMERIC(18,5),
qty_sold NUMERIC(18,5),
val_retail_net_ejr NUMERIC(19,5),
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dat_formdate;