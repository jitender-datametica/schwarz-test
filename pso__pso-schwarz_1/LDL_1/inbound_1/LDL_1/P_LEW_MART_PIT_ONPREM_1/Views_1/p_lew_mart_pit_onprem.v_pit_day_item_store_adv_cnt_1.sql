CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_DAY_ITEM_STORE_ADV_CNT_1

AS
   SELECT
   agg.client_id
,   agg.dwh_cal_dt
,   cws.adv_week_id
,   cws.adv_week_mstr_sid
,   cws.adv_week_start_dt
,   cws.adv_week_end_dt
,   agg.F_Client_Store_Cnt_Adv
,   agg.F_Client_Store_Cnt_Adv_Week
   FROM p_lew_mart_pit_onprem.t_pit_day_item_store_adv_cnt_1 agg
   INNER JOIN
   (
    SELECT
   cws.client_id
,   cal.cal_dt AS adv_week_start_dt
,   DATEadd('day', + 6, cal.cal_dt)                      AS adv_week_end_dt
,   CASE WHEN cal.day_of_week >= cws.adv_week_start_day THEN cal.cy_week            /* CalWeek of the DATE */
             WHEN cal.day_of_week  < cws.adv_week_start_day THEN cwk.cy_week_prev_1w    /* Previous CalWeek of the DATE */
        END AS adv_week_id
,   CAST (   ( adv_week_id * 100::INTEGER )  + cws.client_id AS INTEGER )  AS adv_week_mstr_sid
,   CASE WHEN cal.day_of_week  = cws.adv_week_start_day THEN 1::SMALLINT ELSE 0::SMALLINT END AS first_day_fg
   FROM p_lew_core_ac.v_cal_calendarday_1 AS cal
   INNER JOIN  (SELECT
   *
   FROM p_lew_mart_pit_onprem.t_country_advert_week_start_1 ) AS cws
   ON cal.cal_dt BETWEEN cws.dwh_valid_from AND cws.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_cal_week_1 AS cwk
   ON  cal.cy_week = cwk.cy_week
   INNER JOIN p_lew_core_ac.v_cal_week_1 AS nwk
   ON  cal.cy_week = nwk.cy_week_prev_1w

   GROUP BY 1,2,3,4,5,6
    )
    CWS
   ON  agg.client_id = cws.client_id AND agg.adv_week_id = cws.adv_week_id;