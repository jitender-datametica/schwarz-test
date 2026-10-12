CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_rev_topsell_item_hr_bgesvges (client_id, item_sid, dat_formdate,
loc_sid_store_move_to, wh_loc_sid, aspect_id, wh_id, cy_week, currency_iso_cd, time_hour_id, qty_piece_ejr,
qty_weight_ejr, qty_sold, val_retail_net_ejr, dwh_updated) AS SELECT R.client_id,
 R.item_sid,
 R.dwh_cal_dt AS dat_formdate,
 ORG.loc_sid_store_move_to,
 ORG.loc_sid_wh AS wh_loc_sid,
 ORG.aspect_id,
 WH.src_wh_id AS wh_id,
 CAL.cy_week,
 CRY.curr_cd_from AS currency_iso_cd,
 EXTRACT(HOUR FROM R.receipt_tmsp) AS time_hour_id,
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
        END, 1) / CRY.exchange_rate AS NUMERIC)) AS val_retail_net_ejr,
 CURRENT_TIMESTAMP() AS dwh_updated
FROM ldl_p_lew_core_ac.v_pos_receiptline AS R
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON R.dwh_cal_dt = CAL.cal_dt AND CAL.cy_month_seq BETWEEN -36 AND
   1
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist AS CRY ON R.client_id = CRY.client_id AND CURRENT_DATE BETWEEN
    CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE'
 INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge AS ORG ON R.client_id = ORG.client_id AND R.loc_sid = ORG.loc_sid_store
 INNER JOIN ldl_p_lew_core_ac.v_location AS WH ON ORG.loc_sid_wh = WH.loc_sid AND R.client_id = WH.client_id AND WH.wh_store_mark
    = 'B'
WHERE R.turnover_relevant_fg = 1
 AND R.dwh_cal_dt < CURRENT_DATE
GROUP BY R.client_id,
 ORG.loc_sid_store_move_to,
 R.item_sid,
 wh_loc_sid,
 ORG.aspect_id,
 wh_id,
 dat_formdate,
 CAL.cy_week,
 currency_iso_cd,
 time_hour_id;