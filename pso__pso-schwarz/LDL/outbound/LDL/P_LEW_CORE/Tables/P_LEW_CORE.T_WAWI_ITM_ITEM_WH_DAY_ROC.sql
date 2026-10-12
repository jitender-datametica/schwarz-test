CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_item_wh_day_roc (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
stock_slot_fg BIGNUMERIC(38,0) NOT NULL,
stock_case_size_fg BIGNUMERIC(38,0) NOT NULL,
qty_piece_five_weeks_fg BIGNUMERIC(38,0) NOT NULL,
qty_piece_vs_case_size_fg BIGNUMERIC(38,0) NOT NULL,
qty_piece_stc_wh NUMERIC(18,4) NOT NULL,
qty_total_goodsout_avg_35_days NUMERIC(18,4) NOT NULL
) CLUSTER BY dat_formdate;