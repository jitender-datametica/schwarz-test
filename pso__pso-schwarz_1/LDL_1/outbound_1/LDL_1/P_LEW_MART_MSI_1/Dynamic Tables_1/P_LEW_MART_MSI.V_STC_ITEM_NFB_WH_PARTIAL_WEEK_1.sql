CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_stc_item_nfb_wh_partial_week_1 AS
SELECT COALESCE(a.client_id, b.client_id) AS client_id,
 COALESCE(a.wh_id, b.wh_id) AS wh_id,
 COALESCE(a.item_sid, b.item_sid) AS item_id,
 COALESCE(a.cy_week, b.cy_week) AS cy_week,
 COALESCE(a.cy_partial_week, b.cy_partial_week) AS cy_partial_week,
 COALESCE(a.qty_case_nfb, 0) AS qty_case_nfb_diff,
 SUM(COALESCE(a.qty_case_nfb, 0)) OVER (PARTITION BY COALESCE(a.client_id, b.client_id), COALESCE(a.wh_id, b.wh_id),
    COALESCE(a.item_sid, b.item_sid) ORDER BY COALESCE(a.cy_week, b.cy_week) IS NULL, COALESCE(a.cy_week, b.cy_week),
    COALESCE(a.cy_partial_week, b.cy_partial_week) IS NULL, COALESCE(a.cy_partial_week, b.cy_partial_week) ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS qty_case_nfb_continuous
FROM (SELECT STC.client_id,
   WH.src_wh_id AS wh_id,
   STC.item_sid,
   CAL.cy_week,
   CAL.cy_week_part AS cy_partial_week,
   SUM(STC.delta_case_qty) AS qty_case_nfb
  FROM ldl_p_lew_core_ac.v_item_wh_stock_nfb_1 AS STC
   INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON STC.client_id = WH.client_id AND STC.loc_sid = WH.loc_sid_wh AND WH
      .dwh_actual_fg = 1 AND STC.deleted_fg = 0
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON STC.delta_day_dt = CAL.cal_dt
  GROUP BY STC.client_id,
   wh_id,
   STC.item_sid,
   CAL.cy_week,
   cy_partial_week) AS a
 FULL JOIN (SELECT stc.client_id,
   stc.wh_id,
   stc.item_sid,
   WKP.cy_week,
   WKP.cy_week_part AS cy_partial_week
  FROM ldl_p_lew_core_ac.v_cal_week_partial_1 AS WKP
   INNER JOIN (SELECT STC0.client_id,
     WH0.src_wh_id AS wh_id,
     STC0.item_sid
    FROM ldl_p_lew_core_ac.v_item_wh_stock_nfb_1 AS STC0
     INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH0 ON STC0.client_id = WH0.client_id AND STC0.loc_sid = WH0.loc_sid_wh
      AND WH0.dwh_actual_fg = 1
    GROUP BY STC0.client_id,
     wh_id,
     STC0.item_sid) AS stc ON TRUE) AS b ON a.client_id = b.client_id AND a.wh_id = b.wh_id AND a.item_sid = b.item_sid
   AND a.cy_week = b.cy_week AND a.cy_partial_week = b.cy_partial_week;