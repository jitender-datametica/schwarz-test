CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.v_stock_wh_item_months_26_2 AS
SELECT SLI.client_id AS client_id,
 CRY.curr_cd_from AS curr_cd,
 WH.src_wh_id AS src_wh_id,
 SLI.loc_sid AS loc_sid_wh,
 SLI.item_sid AS item_sid,
  SLI.price / ROUND(CAST(CRY.exchange_rate AS NUMERIC), 4) AS cond_val_eff_calc,
  SLI.price_net / CAST(CRY.exchange_rate AS NUMERIC) AS net_val_eff_calc,
 SLI.calc_qty AS stock_calc_qty,
 CRY.curr_sid_from AS curr_sid,
 SLI.dwh_valid_from AS dwh_valid_from,
 SLI.dwh_valid_to AS dwh_valid_to
FROM ldl_p_lew_core_ac.v_item_location_stock_hist_2 AS SLI
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON SLI.client_id = WH.client_id AND SLI.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
     = 1 AND WH.bges_active_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS LAND_CURR ON SLI.client_id = LAND_CURR.client_id
 INNER JOIN ldl_p_lew_bil_ac.v_exchange_rate_report_asis_2 AS CRY ON SLI.client_id = CRY.client_id AND LAND_CURR.curr_sid
   = CRY.curr_sid_to
WHERE SLI.dwh_valid_from <= DATE '9999-12-30'
 AND DATE_ADD(DATE_SUB(IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 26 MONTH)),
     DATE_ADD(CURRENT_DATE, INTERVAL - 26 MONTH)), INTERVAL EXTRACT(DAY FROM IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE),
      LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 26 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 26 MONTH))) DAY),
   INTERVAL 1 DAY) <= SLI.dwh_valid_to;