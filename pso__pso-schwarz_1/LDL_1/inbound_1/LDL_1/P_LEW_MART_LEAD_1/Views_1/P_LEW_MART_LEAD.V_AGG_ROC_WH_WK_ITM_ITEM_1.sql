/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_AGG_ROC_WH_WK_ITM_ITEM_1
#----------------------------------------------------------------------------
# History:
#  1.0  05.02.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_ROC_WH_WK_ITM_ITEM_1
(
  client_id
, loc_sid_wh
, wh_id 
, itemgroup_int_id
, subitemgroup_id
, item_familygroup_id
, orig_item_nr
, item_sid
, listing_type_id_hist
, currency_iso_cd
, cy_week
, cy_month
, qty_piece_ejr_asis  
, qty_weight_ejr_asis 
, qty_return_ejr_asis
, qty_piece_stc_wh 
, qty_piece_stc_wh_wk
, qty_piece_stc_wh_sc
, qty_piece_stc_wh_sc_wk
, qty_total_adj_sales_avg_35_days
, qty_total_adj_sales_avg_35_days_wk
, qty_total_adj_sales_avg_35_days_sc
, qty_total_adj_sales_avg_35_days_sc_wk
) AS
SELECT
  roc.client_id
, roc.loc_sid_wh
, wh.src_wh_id                                      AS wh_id 
, sgh.itemgroup_int_id
, itm.subitemgroup_id
, itm.item_familygroup_id
, itm.orig_item_nr
, roc.item_sid
, roc.listing_type_id_hist
, 'EUR'                                                          AS currency_iso_cd
, roc.cy_week
, roc.cy_month
, SUM(roc.qty_piece_ejr_asis                    )                     AS qty_piece_ejr_asis   
, SUM(roc.qty_weight_ejr_asis                   )                     AS qty_weight_ejr_asis  
, SUM(roc.qty_return_ejr_asis                   )                     AS qty_return_ejr_asis  
, SUM(roc.qty_piece_stc_wh                      )                     AS qty_piece_stc_wh     
, SUM(roc.qty_piece_stc_wh                      )/7                   AS qty_piece_stc_wh_wk      
, SUM(roc.qty_piece_stc_wh_sc                   )                     AS qty_piece_stc_wh_sc 
, SUM(roc.qty_piece_stc_wh_sc                   )/7                   AS qty_piece_stc_wh_sc_wk  
, SUM(roc.qty_total_adj_sales_avg_35_days       )                     AS qty_total_adj_sales_avg_35_days
, SUM(roc.qty_total_adj_sales_avg_35_days       )/7                   AS qty_total_adj_sales_avg_35_days_wk
, SUM(roc.qty_total_adj_sales_avg_35_days       )                     AS qty_total_adj_sales_avg_35_days_sc
, SUM(roc.qty_total_adj_sales_avg_35_days       )/7                   AS qty_total_adj_sales_avg_35_days_sc_wk

FROM

(SELECT 
  roc.client_id
, roc.loc_sid_wh
, roc.item_sid
, roc.listing_type_id_hist
, roc.item_group_fg
, cal.cy_week
, cal.cy_month
, SUM(roc.qty_piece_ejr_asis   )              AS    qty_piece_ejr_asis  
, SUM(roc.qty_weight_ejr_asis  )              AS    qty_weight_ejr_asis 
, SUM(roc.qty_return_ejr_asis  )              AS    qty_return_ejr_asis
, SUM(roc.qty_piece_stc_wh)                   AS    qty_piece_stc_wh 
, SUM(CASE WHEN roc.stock_fg=1 THEN roc.qty_piece_stc_wh  ELSE  NULL END )                               AS    qty_piece_stc_wh_sc 
, SUM(roc.qty_total_adj_sales_avg_35_days )                                                          AS    qty_total_adj_sales_avg_35_days

FROM P_LEW_BIL.T_AGG_ROC_WH_DAY_ITEM_1 roc
INNER JOIN P_LEW_CORE_AC.V_CAL_CALENDARDAY_1 cal
ON roc.dwh_cal_dt = cal.cal_dt
GROUP BY 1,2,3,4,5,6,7
)roc
INNER JOIN P_LEW_BIL_AC.V_WAREHOUSE_1 AS wh
        ON roc.loc_sid_wh = wh.loc_sid_wh
      AND roc.client_id = wh.client_id
      AND wh.dwh_actual_fg = 1
INNER JOIN P_LEW_MART_LEAD.V_ITM_ITEM_1 itm
     ON roc.client_id = itm.client_id
    AND roc.item_sid  = itm.item_id
INNER JOIN P_LEW_MART_MSI.V_ITM_SUBITEMGROUP_1 AS sgh
ON   itm.subitemgroup_id = sgh.subitemgroup_id
WHERE roc.item_group_fg=1 /* (sgh.itemgroup_int_id IN ('4', '40', '5', '50', '6', '60')  OR  sgh.subitemgroup_id IN ('74', '78')) */
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
;