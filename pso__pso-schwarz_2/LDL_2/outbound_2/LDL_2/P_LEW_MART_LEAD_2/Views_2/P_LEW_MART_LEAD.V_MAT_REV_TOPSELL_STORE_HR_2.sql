CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_mat_rev_topsell_store_hr_2 AS SELECT R.client_id,
 R.dwh_cal_dt AS dat_formdate,
 ORG.loc_sid_store_move_to,
 ORG.loc_sid_wh AS wh_loc_sid,
 WH.src_wh_id AS wh_id,
 CAL.cy_week,
 EXTRACT(HOUR FROM R.receipt_tmsp) AS time_hour_id,
 1 AS receipt_for_count_id,
 SUM(CASE
   WHEN R.weight_item_fg = 0
   THEN R.sales_piece_qty
   ELSE 0
   END) AS qty_piece_ejr,
 SUM(CASE
   WHEN R.weight_item_fg = 1
   THEN R.sales_weight_qty
   ELSE 0
   END) AS qty_weight_ejr,
  SUM(CASE
    WHEN R.weight_item_fg = 0
    THEN R.sales_piece_qty
    ELSE 0
    END) + SUM(CASE
    WHEN R.weight_item_fg = 1
    THEN R.sales_weight_qty
    ELSE 0
    END) AS qty_sold,
 SUM(CAST(R.sales_val * COALESCE(100 / CASE
        WHEN CAST(R.vat_pct_val AS NUMERIC) + 100 = 0
        THEN NULL
        ELSE CAST(R.vat_pct_val AS NUMERIC) + 100
        END, 1) / CRY.rate_currency_exchange AS NUMERIC)) AS val_retail_net_ejr,
 CURRENT_TIMESTAMP() AS dwh_updated
FROM ldl_p_lew_core_ac.v_pos_receiptline_2 AS R
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON R.dwh_cal_dt = CAL.cal_dt AND CAL.cy_month_seq BETWEEN - 36
   AND 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON R.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITM ON R.client_id = ITM.client_id AND R.item_sid = ITM.item_sid
 INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge_2 AS ORG ON R.client_id = ORG.client_id AND R.loc_sid = ORG.loc_sid_store
  AND ORG.aspect_id = 1
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS WH ON ORG.loc_sid_wh = WH.loc_sid AND R.client_id = WH.client_id AND WH.wh_store_mark
    = 'B'
WHERE R.turnover_relevant_fg = 1
GROUP BY R.client_id,
 ORG.loc_sid_store_move_to,
 wh_loc_sid,
 wh_id,
 dat_formdate,
 CAL.cy_week,
 time_hour_id,
 receipt_for_count_id;