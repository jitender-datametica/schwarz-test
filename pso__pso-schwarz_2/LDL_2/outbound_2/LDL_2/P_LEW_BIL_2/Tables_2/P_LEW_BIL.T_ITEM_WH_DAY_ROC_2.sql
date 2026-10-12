/*** MSC-WARNING - MSCEWI2015 - SET TABLE FUNCTIONALITY NOT SUPPORTED ***/


CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_item_wh_day_roc_2 (
client_id INTEGER NOT NULL,
loc_sid INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
stock_slot_fg INTEGER NOT NULL,
stock_case_size_fg INTEGER NOT NULL,
qty_piece_five_weeks_fg INTEGER NOT NULL,
qty_piece_vs_case_size_fg INTEGER NOT NULL,
qty_piece_stc_wh NUMERIC(18,5) NOT NULL,
qty_total_goodsout_avg_35_days NUMERIC(18,5) NOT NULL,
dwh_cal_dt DATE NOT NULL,
dwh_created DATETIME NOT NULL,
price_net NUMERIC(18,5)
);