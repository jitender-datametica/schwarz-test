/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_AGG_ROC_WH_DAY_ITM_ITEM
#----------------------------------------------------------------------------
# History:
#  1.0  05.02.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_ROC_WH_DAY_ITM_ITEM
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
, dwh_cal_dt
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
)AS
SELECT
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
, dwh_cal_dt
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
FROM P_LEW_MART_LEAD.V_AGG_ROC_WH_DAY_ITM_ITEM
;


