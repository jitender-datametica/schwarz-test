CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_ITEM_WH_DAY_ROC_1
AS
SELECT
client_id,
loc_sid,
item_sid,
stock_slot_fg,
stock_case_size_fg,
qty_piece_five_weeks_fg,
qty_piece_vs_case_size_fg,
qty_piece_stc_wh,
qty_total_goodsout_avg_35_days,
dwh_cal_dt,
dwh_created,
price_net
FROM p_lew_bil.t_item_wh_day_roc_1
;


