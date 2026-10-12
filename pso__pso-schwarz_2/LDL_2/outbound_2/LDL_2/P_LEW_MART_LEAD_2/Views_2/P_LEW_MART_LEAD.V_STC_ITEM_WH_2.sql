/* #DescStart#
   #$Revision: 11490 $, $LastChangedBy: ckumbhale $
   #SubjectAreas#: COEX stock for warehouse
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_stc_item_wh_2 AS SELECT SLI.client_id,
 CRY.curr_cd_from AS currency_iso_cd,
 SLI.dwh_cal_dt AS dat_formdate,
 SLI.item_sid AS item_id,
  SLI.price / ROUND(CAST(CRY.exchange_rate AS NUMERIC), 4) AS price_retail_stc_wh,
  SLI.price_net / CAST(CRY.exchange_rate AS NUMERIC) AS price_retail_net_stc_wh,
 SLI.stock_calc_qty AS qty_piece_stc_wh,
 WH.src_wh_id AS wh_id,
 WH.loc_sid_wh
FROM ldl_p_lew_bil_ac.v_stock_location_item_2 AS SLI
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON SLI.client_id = WH.client_id AND SLI.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
     = 1 AND WH.bges_active_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON SLI.client_id = CRY.client_id
    /* # latest rate (point in history) */ AND CURRENT_DATE BETWEEN CRY.active_from_dt AND CRY.active_to_dt
    /* # latest history (version) */ AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS ERT ON CRY.client_id = ERT.client_id AND CRY.x_rate_type_sid = ERT
    .x_rate_type_sid /* # reporting rate (slow moving) */ AND ERT.src_kurst = '@BEWE' /* # selection of partitions */
WHERE SLI.dwh_cal_dt <= CURRENT_DATE
 AND SLI.client_id < 41;