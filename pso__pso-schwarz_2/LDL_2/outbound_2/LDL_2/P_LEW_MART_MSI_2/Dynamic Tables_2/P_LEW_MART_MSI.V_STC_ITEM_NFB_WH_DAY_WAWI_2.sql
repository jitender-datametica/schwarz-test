CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_stc_item_nfb_wh_day_wawi_2 AS
SELECT SINW.client_id,
 CRY.currency_iso_cd,
 CAL.cal_dt AS dat_calendar,
 ITMP.item_sid_map AS item_id,
 CAST(SINW.retail_price / CRY.rate_currency_exchange AS BIGNUMERIC) AS price_retail,
 CAST(SINW.retail_net_price / CRY.rate_currency_exchange AS BIGNUMERIC) AS price_retail_net,
 SINW.calc_stock_case_qty AS qty_case_nfb_continuous,
  CASE
  WHEN SINW.active_from_dt = CAL.cal_dt
  THEN SINW.delta_case_qty
  ELSE 0
  END AS qty_case_nfb_diff,
 WH.src_wh_id AS wh_id
FROM ldl_p_lew_core_ac.v_item_wh_stock_nfb_2 AS SINW
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON CAL.cal_dt BETWEEN SINW.active_from_dt AND SINW.active_to_dt
   AND SINW.calc_stock_case_qty <> 0 AND SINW.deleted_fg = 0
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON SINW.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON SINW.client_id = WH.client_id AND SINW.loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON SINW.client_id = ITMP.client_id AND SINW.item_sid = ITMP.item_sid
   
WHERE WH.bges_active_fg = 1;