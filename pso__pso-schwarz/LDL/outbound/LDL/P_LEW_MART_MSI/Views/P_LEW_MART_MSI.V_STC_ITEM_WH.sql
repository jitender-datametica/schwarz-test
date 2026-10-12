/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_STC_ITEM_WH.
#----------------------------------------------------------------------------
# History:
#  1.0?  12.04.2023    Bialek, Aleksander           Adjusting the price_retail_stc_wh column for US. AD Work Item: 464213, NSR3539080
#
#
#----------------------------------------------------------------------------
*/


/* #DescStart#	
   #$Revision: 9193 $, $LastChangedBy: jthole $	
   #SubjectAreas#: COEX stock for warehouse	
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_stc_item_wh AS SELECT SLI.client_id,
 CRY.curr_cd_from AS currency_iso_cd,
 SLI.dwh_cal_dt AS dat_formdate,
 SLI.item_sid AS item_id,
   CASE
   WHEN SLI.client_id = 33
   THEN SLI.price_net
   ELSE SLI.price
   END / ROUND(CAST(CRY.exchange_rate AS NUMERIC), 4) AS price_retail_stc_wh,
  SLI.price_net / CAST(CRY.exchange_rate AS NUMERIC) AS price_retail_net_stc_wh,
 SLI.stock_calc_qty AS qty_piece_stc_wh,
 WH.src_wh_id AS wh_id,
 WH.loc_sid_wh
FROM ldl_p_lew_bil_ac.v_stock_location_item AS SLI
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON SLI.client_id = WH.client_id AND SLI.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
     = 1 AND WH.bges_active_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist AS CRY ON SLI.client_id = CRY.client_id
    /* # latest rate (point in history) */ AND CURRENT_DATE BETWEEN CRY.active_from_dt AND CRY.active_to_dt
    /* # latest history (version) */ AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS ERT ON CRY.client_id = ERT.client_id AND CRY.x_rate_type_sid = ERT
    .x_rate_type_sid /* # reporting rate (slow moving) */ AND ERT.src_kurst = '@BEWE' /* # selection of partitions */
WHERE SLI.dwh_cal_dt <= CURRENT_DATE
 AND SLI.client_id < 41;