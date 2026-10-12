CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_itm_item_wh_day_roc_2 AS
/* # Aufloesung WH */ SELECT A.client_id,
 WH.src_wh_id AS wh_id,
 A.item_sid AS item_id,
 A.dwh_cal_dt AS dat_formdate,
 A.stock_slot_fg,
 A.stock_case_size_fg,
 A.qty_piece_five_weeks_fg,
 A.qty_piece_vs_case_size_fg,
    SUBSTR(CAST(A.stock_slot_fg AS STRING), 1, 1) || SUBSTR(CAST(A.stock_case_size_fg AS STRING), 1, 1) || SUBSTR(CAST(A.qty_piece_five_weeks_fg AS STRING)
    , 1, 1) || SUBSTR(CAST(A.qty_piece_vs_case_size_fg AS STRING), 1, 1) AS flags_combined,
   A.qty_piece_stc_wh / COALESCE(ITM.case_size, 1) / CASE
   WHEN ITM_WH.case_factor_euro IS NULL OR ITM_WH.case_factor_euro = 0
   THEN 1
   ELSE ITM_WH.case_factor_euro
   END AS qty_piece_ep_wh,
   A.qty_total_goodsout_avg_35_days / COALESCE(ITM.case_size, 1) / CASE
   WHEN ITM_WH.case_factor_euro IS NULL OR ITM_WH.case_factor_euro = 0
   THEN 1
   ELSE ITM_WH.case_factor_euro
   END AS qty_total_goodsout_avg_35_days_ep,
     A.qty_piece_stc_wh / COALESCE(ITM.case_size, 1) / CASE
     WHEN ITM_WH.case_factor_euro IS NULL OR ITM_WH.case_factor_euro = 0
     THEN 1
     ELSE ITM_WH.case_factor_euro
     END * (A.qty_piece_stc_wh / COALESCE(ITM.case_size, 1) / CASE
      WHEN ITM_WH.case_factor_euro IS NULL OR ITM_WH.case_factor_euro = 0
      THEN 1
      ELSE ITM_WH.case_factor_euro
      END) / IF(A.qty_total_goodsout_avg_35_days / COALESCE(ITM.case_size, 1) / CASE
      WHEN ITM_WH.case_factor_euro IS NULL OR ITM_WH.case_factor_euro = 0
      THEN 1
      ELSE ITM_WH.case_factor_euro
      END = 0, NULL, A.qty_total_goodsout_avg_35_days / COALESCE(ITM.case_size, 1) / CASE
     WHEN ITM_WH.case_factor_euro IS NULL OR ITM_WH.case_factor_euro = 0
     THEN 1
     ELSE ITM_WH.case_factor_euro
     END) AS rwl_nominator,
 A.qty_piece_stc_wh,
  A.price_net / CAST(CRY.exchange_rate AS NUMERIC) AS price_retail_net_stc_wh,
 CRY.curr_cd_from AS currency_iso_cd
FROM ldl_p_lew_bil_ac.v_item_wh_day_roc_2 AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON A.client_id = WH.client_id AND A.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1 /* # selection of currency_iso_cd and exchange_rate for the price calculation */
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON A.client_id = CRY.client_id
    /* # latest rate (point in history) */ AND CURRENT_DATE BETWEEN CRY.active_from_dt AND CRY.active_to_dt
    /* # latest history (version) */ AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS ERT ON CRY.client_id = ERT.client_id AND CRY.x_rate_type_sid = ERT
    .x_rate_type_sid /* # reporting rate (slow moving) */ AND ERT.src_kurst = '@BEWE' /* # Kolliinhalt */
 INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item_2 AS ITM ON A.client_id = ITM.client_id AND A.item_sid = ITM.item_id
   /* # Palettenfaktor */
 INNER JOIN ldl_p_lew_mart_msi.v_itm_item_wh_2 AS ITM_WH ON A.client_id = ITM_WH.client_id AND A.item_sid = ITM_WH.item_id
     AND WH.src_wh_id = ITM_WH.wh_id;