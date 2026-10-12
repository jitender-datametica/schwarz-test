CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_item_wh_roc_1 (
client_id INTEGER NOT NULL,
loc_sid INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
stock_slot_fg INTEGER NOT NULL,
stock_case_size_fg INTEGER NOT NULL,
qty_piece_five_weeks_fg INTEGER NOT NULL,
qty_piece_vs_case_size_fg INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_created DATETIME NOT NULL
);