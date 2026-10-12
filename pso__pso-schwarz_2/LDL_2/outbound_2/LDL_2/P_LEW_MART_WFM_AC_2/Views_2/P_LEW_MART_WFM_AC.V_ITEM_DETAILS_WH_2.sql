/* #----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM_AC.V_ITEM_DETAILS_WH_2
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-23    Jyoti Agarwal          Add dimension columns
#                                         https://dev.azure.com/schwarzit/schwarzit.biaid/_workitems/edit/492641
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_item_details_wh_2 (client_id, country_iso_cd, wh_id, orig_item_nr,
order_area_cd, item_status, case_size, case_factor_dd, case_factor_euro, case_factor_layer, min_orderunit,
min_case_dd_wh, min_case_euro_wh, min_case_layer_wh, min_case_wh, item_actiongroup_id, item_sub_actiongroup_id,
dur_shelflife_day_wh, dur_shelflife_day_store, dur_shelflife_day_cust, smallest_unit, item_plu_nr, dispo_group_nr,
unit_size, case_height, case_depth, case_width, case_volume, piece_height, piece_depth, piece_width, piece_volume) AS
SELECT *
FROM ldl_p_lew_mart_wfm.v_item_details_wh_2;