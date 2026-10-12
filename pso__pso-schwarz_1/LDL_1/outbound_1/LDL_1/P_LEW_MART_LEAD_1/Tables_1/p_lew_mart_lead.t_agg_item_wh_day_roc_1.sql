CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_item_wh_day_roc_1 (
client_id INTEGER NOT NULL,
wh_loc_sid INTEGER NOT NULL,
wh_id INTEGER NOT NULL,
aspect_id INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
dat_formdate DATE NOT NULL,
cy_week INTEGER NOT NULL,
cy_month INTEGER NOT NULL,
busyear INTEGER NOT NULL,
stock_slot_fg INTEGER NOT NULL,
stock_case_size_fg INTEGER NOT NULL,
qty_piece_five_weeks_fg INTEGER NOT NULL,
qty_piece_vs_case_size_fg INTEGER NOT NULL,
flags_combined STRING COLLATE 'und:ci',
qty_piece_stc_wh NUMERIC(18,4) NOT NULL,
qty_total_goodsout_avg_35_days NUMERIC(18,4) NOT NULL,
dwh_updated DATETIME
);