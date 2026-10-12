CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_roc_stc_retail_price_wh_day_item_1 (client_id, wh_id, item_sid,
dwh_cal_dt, currency_iso_cd, stock_fg, item_group_fg, qty_piece_stc_wh_roc, qty_piece_stc_wh, current_retail_net_price,
last_retail_net_price, roc_stc_in_retail_price, stc_in_retail_price) AS SELECT WDI.client_id,
 WH.src_wh_id AS wh_id,
 WDI.item_sid,
 WDI.dwh_cal_dt,
 CRY.curr_cd_from AS currency_iso_cd,
 WDI.stock_fg,
 WDI.item_group_fg,
 IWD.qty_piece_stc_wh AS qty_piece_stc_wh_roc,
 WDI.qty_piece_stc_wh,
 IF(WDI.current_wh_stc_retail_net_price / CAST(CRY.exchange_rate AS NUMERIC) = 0, NULL, WDI.current_wh_stc_retail_net_price
    / CAST(CRY.exchange_rate AS NUMERIC)) AS current_retail_net_price,
 IF(WDI.last_wh_stc_retail_net_price / CAST(CRY.exchange_rate AS NUMERIC) = 0, NULL, WDI.last_wh_stc_retail_net_price / CAST(CRY.exchange_rate AS NUMERIC)
   ) AS last_retail_net_price,
  IWD.qty_piece_stc_wh * IF(WDI.last_wh_stc_retail_net_price / CAST(CRY.exchange_rate AS NUMERIC) = 0, NULL, WDI.last_wh_stc_retail_net_price
     / CAST(CRY.exchange_rate AS NUMERIC)) AS roc_stc_in_retail_price,
  WDI.qty_piece_stc_wh * IF(WDI.last_wh_stc_retail_net_price / CAST(CRY.exchange_rate AS NUMERIC) = 0, NULL, WDI.last_wh_stc_retail_net_price
     / CAST(CRY.exchange_rate AS NUMERIC)) AS stc_in_retail_price
FROM ldl_p_lew_bil_ac.v_agg_roc_wh_day_item_1 AS WDI
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON WDI.client_id = WH.client_id AND WDI.loc_sid_wh = WH.loc_sid_wh AND WH
    .dwh_actual_fg = 1 AND WH.bges_active_fg = 1
 LEFT JOIN ldl_p_lew_mart_msi.v_itm_item_wh_day_roc_1 AS IWD ON WDI.client_id = IWD.client_id AND WH.src_wh_id = IWD.wh_id
       AND WDI.item_sid = IWD.item_id AND WDI.dwh_cal_dt = IWD.dat_formdate AND IWD.flags_combined = '0000'
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS CRY ON WDI.client_id = CRY.client_id
    /* # latest rate (point in history) */ AND CURRENT_DATE BETWEEN CRY.active_from_dt AND CRY.active_to_dt
    /* # latest history (version) */ AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS ERT ON CRY.client_id = ERT.client_id AND CRY.x_rate_type_sid = ERT
    .x_rate_type_sid /* # reporting rate (slow moving) */ AND ERT.src_kurst = '@BEWE' /* # selection of partitions */
WHERE WDI.dwh_cal_dt <= CURRENT_DATE
 AND WDI.client_id < 41
GROUP BY WDI.client_id,
 wh_id,
 WDI.item_sid,
 WDI.dwh_cal_dt,
 currency_iso_cd,
 WDI.stock_fg,
 WDI.item_group_fg,
 qty_piece_stc_wh_roc,
 WDI.qty_piece_stc_wh,
 current_retail_net_price,
 last_retail_net_price,
 roc_stc_in_retail_price,
 stc_in_retail_price;