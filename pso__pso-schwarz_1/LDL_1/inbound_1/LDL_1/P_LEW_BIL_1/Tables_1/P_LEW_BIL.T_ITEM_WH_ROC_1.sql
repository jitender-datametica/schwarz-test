CREATE TABLE P_LEW_BIL.T_ITEM_WH_ROC_1
(
client_id INTEGER NOT NULL,
loc_sid INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
stock_slot_fg BYTEINT NOT NULL,
stock_case_size_fg BYTEINT NOT NULL,
qty_piece_five_weeks_fg BYTEINT NOT NULL,
qty_piece_vs_case_size_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL);