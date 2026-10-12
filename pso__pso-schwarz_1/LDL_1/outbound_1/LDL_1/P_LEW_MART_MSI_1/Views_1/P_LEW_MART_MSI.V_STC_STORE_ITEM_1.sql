CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_stc_store_item_1 (client_id, store_id, wh_id, item_id, dat_formdate,
qty_stc_calc, qty_stc_inv, qty_stc_real, diff_stc_inv_calc, store_storage_qty, price_retail, price_retail_net,
currency_iso_cd, loc_sid_wh) AS SELECT SLI.client_id,
 SLI.loc_sid AS store_id,
 STW_H.src_wh_id AS wh_id,
 SLI.item_sid AS item_id,
 SLI.dwh_cal_dt AS dat_formdate,
 SLI.stock_calc_qty AS qty_stc_calc,
 SLI.stock_inv_qty AS qty_stc_inv,
 SLI.stock_real_qty AS qty_stc_real,
 SLI.stock_inv_diff_calc AS diff_stc_inv_calc,
 SLI.store_storage_qty,
  SLI.price / ROUND(CAST(CRY.exchange_rate AS NUMERIC), 4) AS price_retail,
  SLI.price_net / CAST(CRY.exchange_rate AS NUMERIC) AS price_retail_net,
 CRY.curr_cd_from AS currency_iso_cd,
 STW_H.loc_sid_wh
FROM ldl_p_lew_bil_ac.v_stock_location_item_1 AS SLI
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS STW_H ON SLI.client_id = STW_H.client_id AND SLI.loc_sid
    = STW_H.loc_sid_store /* # exclude the dummy_1 stores for warehouse */ AND SLI.loc_sid <> STW_H.loc_sid_wh
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS CRY ON SLI.client_id = CRY.client_id
    /* # latest rate (point in history) */ AND CURRENT_DATE BETWEEN CRY.active_from_dt AND CRY.active_to_dt
    /* # latest history (version) */ AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS ERT ON CRY.client_id = ERT.client_id AND CRY.x_rate_type_sid = ERT
    .x_rate_type_sid /* # reporting rate (slow moving) */ AND ERT.src_kurst = '@BEWE' /* # selection of partitions */
WHERE SLI.dwh_cal_dt <= CURRENT_DATE
 AND SLI.client_id < 41;