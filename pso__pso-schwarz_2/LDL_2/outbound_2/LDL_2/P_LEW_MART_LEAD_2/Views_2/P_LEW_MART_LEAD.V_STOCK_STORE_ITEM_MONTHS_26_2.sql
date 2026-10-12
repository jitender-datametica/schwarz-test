CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_stock_store_item_months_26_2 AS -- store_id
 -- wh_id
 -- item_id

-- qty_stc_calc
 -- qty_stc_inv
 -- diff_stc_inv_calc
 -- price_retail
 -- price_retail_net
 -- currency_iso_cd
 SELECT
 SLI.client_id,
 SLI.loc_sid,
 STW_L.src_wh_id,
 STW_L.loc_sid_wh,
 SLI.item_sid,
 SLI.calc_qty AS stock_calc_qty,
 SLI.inv_qty AS stock_inv_qty,
  CASE
  WHEN IFNULL(SLI.diff_qty_inv_calc, 0) = 0
  THEN SLI.calc_qty
  ELSE SLI.inv_qty
  END AS stock_real_qty,
 SLI.diff_qty_inv_calc AS stock_inv_diff_calc,
  SLI.price / ROUND(CAST(CRY.exchange_rate AS NUMERIC), 4) AS cond_val_eff_calc,
  SLI.price_net / CAST(CRY.exchange_rate AS NUMERIC) AS net_val_eff_calc,
 CRY.curr_cd_from AS curr_cd,
 CRY.curr_sid_from AS curr_sid,
 SLI.dwh_valid_from,
 SLI.dwh_valid_to
FROM ldl_p_lew_core_ac.v_item_location_stock_hist_2 AS SLI
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS STW_L ON SLI.client_id = STW_L.client_id AND SLI.loc_sid
    = STW_L.loc_sid_store /* # exclude the dummy_2 stores for warehouse */ AND SLI.loc_sid <> STW_L.loc_sid_wh
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON SLI.client_id = CRY.client_id
    /* # latest rate (point in history) */ AND CURRENT_DATE BETWEEN CRY.active_from_dt AND CRY.active_to_dt
    /* # latest history (version) */ AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS ERT ON CRY.client_id = ERT.client_id AND CRY.x_rate_type_sid = ERT
    .x_rate_type_sid /* # reporting rate (slow moving) */ AND ERT.src_kurst = '@BEWE'
   /* # selection of dates for past 26 month // Datuemer der letzen 26 Monate */
WHERE SLI.dwh_valid_from <= DATE '9999-12-30'
 AND DATE_ADD(DATE_SUB(IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 26 MONTH)),
     DATE_ADD(CURRENT_DATE, INTERVAL - 26 MONTH)), INTERVAL EXTRACT(DAY FROM IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE),
      LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 26 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 26 MONTH))) DAY),
   INTERVAL 1 DAY) <= SLI.dwh_valid_to;