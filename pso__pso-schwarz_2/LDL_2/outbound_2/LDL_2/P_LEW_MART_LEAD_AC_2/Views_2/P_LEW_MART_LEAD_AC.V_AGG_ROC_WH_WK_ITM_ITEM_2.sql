/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_AGG_ROC_WH_WK_ITM_ITEM_2
#----------------------------------------------------------------------------
# History:
#  1.0  05.02.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_roc_wh_wk_itm_item_2 (client_id, loc_sid_wh, wh_id, itemgroup_int_id,
subitemgroup_id, item_familygroup_id, orig_item_nr, item_sid, listing_type_id_hist, currency_iso_cd, cy_week, cy_month,
qty_piece_ejr_asis, qty_weight_ejr_asis, qty_return_ejr_asis, qty_piece_stc_wh, qty_piece_stc_wh_wk, qty_piece_stc_wh_sc
, qty_piece_stc_wh_sc_wk, qty_total_adj_sales_avg_35_days, qty_total_adj_sales_avg_35_days_wk,
qty_total_adj_sales_avg_35_days_sc, qty_total_adj_sales_avg_35_days_sc_wk) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_roc_wh_wk_itm_item_2;