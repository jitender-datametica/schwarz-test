/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_AGG_ROC_WH_DAY_ITM_ITEM_2
#----------------------------------------------------------------------------
# History:
#  1.0  05.02.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_roc_wh_day_itm_item_2 (client_id, loc_sid_wh, wh_id, itemgroup_int_id,
subitemgroup_id, item_familygroup_id, orig_item_nr, item_sid, listing_type_id_hist, currency_iso_cd, dwh_cal_dt,
qty_piece_ejr_asis, qty_weight_ejr_asis, qty_return_ejr_asis, qty_piece_stc_wh, qty_piece_stc_wh_wk, qty_piece_stc_wh_sc
, qty_piece_stc_wh_sc_wk, qty_total_adj_sales_avg_35_days, qty_total_adj_sales_avg_35_days_wk,
qty_total_adj_sales_avg_35_days_sc, qty_total_adj_sales_avg_35_days_sc_wk) AS SELECT ROC.client_id,
 ROC.loc_sid_wh,
 WH.src_wh_id AS wh_id,
 SGH.itemgroup_int_id,
 ITM.subitemgroup_id,
 ITM.item_familygroup_id,
 ITM.orig_item_nr,
 ROC.item_sid,
 ROC.listing_type_id_hist,
 'EUR' AS currency_iso_cd,
 ROC.dwh_cal_dt,
 SUM(ROC.qty_piece_ejr_asis) AS qty_piece_ejr_asis,
 SUM(ROC.qty_weight_ejr_asis) AS qty_weight_ejr_asis,
 SUM(ROC.qty_return_ejr_asis) AS qty_return_ejr_asis,
 SUM(ROC.qty_piece_stc_wh) AS qty_piece_stc_wh,
 NULL AS qty_piece_stc_wh_wk,
 SUM(CASE
   WHEN ROC.stock_fg = 1
   THEN ROC.qty_piece_stc_wh
   ELSE NULL
   END) AS qty_piece_stc_wh_sc,
 NULL AS qty_piece_stc_wh_sc_wk,
 SUM(ROC.qty_total_adj_sales_avg_35_days) AS qty_total_adj_sales_avg_35_days,
 NULL AS qty_total_adj_sales_avg_35_days_wk,
 SUM(ROC.qty_total_adj_sales_avg_35_days) AS qty_total_adj_sales_avg_35_days_sc,
 NULL AS qty_total_adj_sales_avg_35_days_sc_wk
FROM ldl_p_lew_bil.t_agg_roc_wh_day_item_2 AS ROC
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON ROC.loc_sid_wh = WH.loc_sid_wh AND ROC.client_id = WH.client_id AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_mart_lead.v_itm_item_2 AS ITM ON ROC.client_id = ITM.client_id AND ROC.item_sid = ITM.item_id
 INNER JOIN ldl_p_lew_mart_msi.v_itm_subitemgroup_2 AS SGH ON ITM.subitemgroup_id = SGH.subitemgroup_id
WHERE ROC.item_group_fg = 1
  /* (sgh.itemgroup_int_id IN ('4', '40', '5', '50', '6', '60')  OR  sgh.subitemgroup_id IN ('74', '78')) */
GROUP BY ROC.client_id,
 ROC.loc_sid_wh,
 wh_id,
 SGH.itemgroup_int_id,
 ITM.subitemgroup_id,
 ITM.item_familygroup_id,
 ITM.orig_item_nr,
 ROC.item_sid,
 ROC.listing_type_id_hist,
 currency_iso_cd,
 ROC.dwh_cal_dt;