CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_day_item_store_adv_cnt_2 AS SELECT AGG.client_id,
 AGG.dwh_cal_dt,
 CWS.adv_week_id,
 CWS.adv_week_mstr_sid,
 CWS.adv_week_start_dt,
 CWS.adv_week_end_dt,
 AGG.f_client_store_cnt_adv,
 AGG.f_client_store_cnt_adv_week
FROM ldl_p_lew_mart_pit_onprem.t_pit_day_item_store_adv_cnt_2 AS AGG
 INNER JOIN (SELECT cws.client_id,
   CAL.cal_dt AS adv_week_start_dt,
   DATE_ADD(CAL.cal_dt, INTERVAL 6 DAY) AS adv_week_end_dt,
    CASE
    WHEN CAL.day_of_week >= cws.adv_week_start_day
    THEN CAL.cy_week /* CalWeek of the DATE */
    WHEN CAL.day_of_week < cws.adv_week_start_day
    THEN CWK.cy_week_prev_1w /* Previous CalWeek of the DATE */
    ELSE NULL
    END AS adv_week_id,
   CAST(CASE
       WHEN CAL.day_of_week >= cws.adv_week_start_day
       THEN CAL.cy_week
       WHEN CAL.day_of_week < cws.adv_week_start_day
       THEN CWK.cy_week_prev_1w
       ELSE NULL
       END * 100 + cws.client_id AS BIGNUMERIC) AS adv_week_mstr_sid,
    CASE
    WHEN CAL.day_of_week = cws.adv_week_start_day
    THEN 1
    ELSE 0
    END AS first_day_fg
  FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL
   INNER JOIN ldl_p_lew_mart_pit_onprem.t_country_advert_week_start_2 AS cws ON CAL.cal_dt BETWEEN cws.dwh_valid_from AND
    cws.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_cal_week_2 AS CWK ON CAL.cy_week = CWK.cy_week
   INNER JOIN ldl_p_lew_core_ac.v_cal_week_2 AS NWK ON CAL.cy_week = NWK.cy_week_prev_1w
  GROUP BY cws.client_id,
   adv_week_start_dt,
   adv_week_end_dt,
   adv_week_id,
   adv_week_mstr_sid,
   first_day_fg) AS CWS ON AGG.client_id = CWS.client_id AND AGG.adv_week_id = CWS.adv_week_id;