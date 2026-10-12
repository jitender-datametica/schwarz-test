CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_ITEM_WH_ROC_1
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
FROM p_lew_bil.t_item_wh_roc_1
;

/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_cal_calendarday_1", "p_lew_bil_ac.v_org_store_merge_1", "p_lew_core_ac.v_location_1", "p_lew_core_ac.v_item_delivery_1", "p_lew_core_ac.v_wawi_itm_item_skey_1", "p_lew_core_ac.v_item_fruits_vegetables_delivery_1" ****/

