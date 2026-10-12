CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_ITEM_WH_ROC
AS
SELECT
client_id,
loc_sid,
item_sid,
stock_slot_fg,
stock_case_size_fg,
qty_piece_five_weeks_fg,
qty_piece_vs_case_size_fg,
dwh_valid_from,
dwh_valid_to,
dwh_created
FROM p_lew_bil.t_item_wh_roc
;

/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_cal_calendarday", "p_lew_bil_ac.v_org_store_merge", "p_lew_core_ac.v_location", "p_lew_core_ac.v_item_delivery", "p_lew_core_ac.v_wawi_itm_item_skey", "p_lew_core_ac.v_item_fruits_vegetables_delivery" ****/

