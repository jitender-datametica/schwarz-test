CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_pos_store_receipt_day_hour_live_mth_2 (client_id, store_id,
move_to_store_id, aspect_id, dat_formdate, dat_calendar, receipt_tmsp_hour, receipt_tmsp_half_hour, is_closed_hour,
lidl_plus_fg, turnover_relevant_fg, is_year_seq, cnt_receipt_sales_asis, total_net_val_asis, currency_iso_cd,
last_refresh) AS SELECT AGG.client_id,
 AGG.loc_sid_store AS store_id,
 OSM.loc_sid_store_move_to AS move_to_store_id,
 OSM.aspect_id,
 AGG.dwh_cal_dt AS dat_formdate,
  CASE
  WHEN AGG.is_year_seq = 1
  THEN CAL.cal_dt
  ELSE AGG.dwh_cal_dt
  END AS dat_calendar,
 AGG.receipt_tmsp_hour,
 AGG.receipt_tmsp_half_hour,
  CASE
  WHEN IFNULL(cl_hr.open_hr, EXTRACT(HOUR FROM CURRENT_TIME)) > AGG.receipt_tmsp_hour OR CASE
     WHEN AGG.is_year_seq = 1
     THEN CAL.cal_dt
     ELSE AGG.dwh_cal_dt
     END < CURRENT_DATE
  THEN 1
  ELSE 0
  END AS is_closed_hour,
 AGG.lidl_plus_fg,
 AGG.turnover_relevant_fg,
 AGG.is_year_seq,
 AGG.cnt_receipt_sales AS cnt_receipt_sales_asis,
  AGG.total_net_val / CRY.exchange_rate AS total_net_val_asis,
 CRY.curr_cd_from AS currency_iso_cd,
 COALESCE(agc.last_refresh, AGG.dwh_created) AS last_refresh
FROM ldl_p_lew_bil_ac.v_agg_pos_store_receipt_day_hour_live_mth_2 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
    BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE'
 LEFT JOIN ldl_p_lew_bil_ac.v_org_store_merge_2 AS OSM ON AGG.client_id = OSM.client_id AND AGG.loc_sid_store = OSM.loc_sid_store
   
 LEFT JOIN (SELECT CTU.client_id,
   MAX(CTU.create_timestamp) AS last_refresh
  FROM ldl_p_lew_process_ac.v_agc_core_table_update_2 AS CTU
   INNER JOIN (SELECT client_id,
     MAX(start_processing) AS start_processing
    FROM ldl_p_lew_process_ac.v_agc_run_log_2
    WHERE aggregate_name LIKE 't_agg_pos_store_receipt_day_hour_live_mth_2'
     AND DATE(dwh_cal_dt) >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
     AND end_processing IS NOT NULL
    GROUP BY client_id) AS rlog ON CTU.create_timestamp <= rlog.start_processing AND CTU.client_id = rlog.client_id
  WHERE CTU.core_table_name = 't_pos_receiptline_live_2'
   AND DATE(CTU.dwh_cal_dt) = CURRENT_DATE
  GROUP BY CTU.client_id) AS agc ON AGG.client_id = agc.client_id
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON AGG.dwh_cal_dt = CAL.cal_dt_swday_prev_1y
 LEFT JOIN (SELECT DISTINCT AGG0.client_id,
   AGG0.loc_sid_store,
   AGG0.dwh_cal_dt,
   MAX(AGG0.receipt_tmsp_hour) OVER (PARTITION BY AGG0.client_id, CAL0.cal_dt RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS open_hr
  FROM ldl_p_lew_bil_ac.v_agg_pos_store_receipt_day_hour_live_2 AS AGG0
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL0 ON AGG0.dwh_cal_dt = CAL0.cal_dt_swday_prev_1y) AS cl_hr ON
    AGG.client_id = cl_hr.client_id AND AGG.loc_sid_store = cl_hr.loc_sid_store AND CASE
    WHEN AGG.is_year_seq = 1
    THEN CAL.cal_dt
    ELSE AGG.dwh_cal_dt
    END = cl_hr.dwh_cal_dt;