
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_agg_wh_mth_del_five_wk_act_1
AS
SELECT t5.client_id,
 WH.src_wh_id AS wh_id,
 t5.item_sid AS item_id,
 t5.itemgroup_int_id,
 t5.cy_month,
 t5.currency_iso_cd,
 t5.qty_five_prev_weeks
FROM (SELECT ITEM_DEL.client_id,
   ITEM_DEL.wh_loc_sid,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   act.cy_month,
   CRY.currency_iso_cd,
   SUM(ITEM_DEL.qty_total_del_asis) AS qty_five_prev_weeks
  FROM ldl_p_lew_core_ac.v_wawi_agg_wh_day_item_del_asis_1 AS ITEM_DEL
   INNER JOIN ldl_p_lew_mart_msi.v_itm_item_1 AS ITM ON ITEM_DEL.client_id = ITM.client_id AND ITEM_DEL.item_sid = ITM.item_id
     
   INNER JOIN ldl_p_lew_mart_msi.v_itm_subitemgroup_new_1 AS SUB ON ITM.subitemgroup_id = SUB.subitemgroup_id
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON ITEM_DEL.client_id = CRY.client_id AND
     CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
   INNER JOIN (SELECT CAL.dat_calendar,
     act_month.cy_month
    FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_1 AS CAL
     INNER JOIN (SELECT cy_month
      FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_1 AS CAL
      WHERE cy_day_sequence = 0) AS act_month ON TRUE
    WHERE CAL.cy_week_sequence BETWEEN - 5 AND (- 1)) AS act ON ITEM_DEL.dat_formdate = act.dat_calendar
  WHERE ITEM_DEL.dat_formdate BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 44 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY
      ))
  GROUP BY ITEM_DEL.wh_loc_sid,
   ITEM_DEL.client_id,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   CRY.currency_iso_cd,
   act.cy_month) AS t5
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON t5.client_id = WH.client_id AND t5.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
UNION ALL
SELECT t13.client_id,
 WH.src_wh_id AS wh_id,
 t13.item_sid AS item_id,
 t13.itemgroup_int_id,
 t13.cy_month,
 t13.currency_iso_cd,
 t13.qty_five_prev_weeks
FROM (SELECT ITEM_DEL.client_id,
   ITEM_DEL.wh_loc_sid,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   m_1.cy_month,
   CRY.currency_iso_cd,
   SUM(ITEM_DEL.qty_total_del_asis) AS qty_five_prev_weeks
  FROM ldl_p_lew_core_ac.v_wawi_agg_wh_day_item_del_asis_1 AS ITEM_DEL
   INNER JOIN ldl_p_lew_mart_msi.v_itm_item_1 AS ITM ON ITEM_DEL.client_id = ITM.client_id AND ITEM_DEL.item_sid = ITM.item_id
     
   INNER JOIN ldl_p_lew_mart_msi.v_itm_subitemgroup_new_1 AS SUB ON ITM.subitemgroup_id = SUB.subitemgroup_id
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON ITEM_DEL.client_id = CRY.client_id AND
     CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
   INNER JOIN (SELECT CAL.dat_calendar,
     t9.cy_month
    FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_1 AS CAL
     INNER JOIN (SELECT dat_calendar,
       cy_month
      FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_1 AS CAL
      WHERE cy_month_sequence = - 1
       AND day_of_week = 7
       AND dat_calendar <> DATE_SUB(IF(dat_calendar = LAST_DAY(dat_calendar), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1
            MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(dat_calendar = LAST_DAY(dat_calendar
             ), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH))) DAY)
      QUALIFY dat_calendar = (MAX(dat_calendar) OVER (PARTITION BY CAST(cy_month AS STRING) RANGE BETWEEN
          UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t9 ON CAL.dat_calendar BETWEEN DATE_SUB(t9.dat_calendar,
       INTERVAL 34 DAY) AND t9.dat_calendar) AS m_1 ON ITEM_DEL.dat_formdate = m_1.dat_calendar
  WHERE ITEM_DEL.dat_formdate BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 72 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY
      ))
  GROUP BY ITEM_DEL.wh_loc_sid,
   ITEM_DEL.client_id,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   CRY.currency_iso_cd,
   m_1.cy_month) AS t13
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON t13.client_id = WH.client_id AND t13.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
UNION ALL
SELECT t21.client_id,
 WH.src_wh_id AS wh_id,
 t21.item_sid AS item_id,
 t21.itemgroup_int_id,
 t21.cy_month,
 t21.currency_iso_cd,
 t21.qty_five_prev_weeks
FROM (SELECT ITEM_DEL.client_id,
   ITEM_DEL.wh_loc_sid,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   m_2.cy_month,
   CRY.currency_iso_cd,
   SUM(ITEM_DEL.qty_total_del_asis) AS qty_five_prev_weeks
  FROM ldl_p_lew_core_ac.v_wawi_agg_wh_day_item_del_asis_1 AS ITEM_DEL
   INNER JOIN ldl_p_lew_mart_msi.v_itm_item_1 AS ITM ON ITEM_DEL.client_id = ITM.client_id AND ITEM_DEL.item_sid = ITM.item_id
     
   INNER JOIN ldl_p_lew_mart_msi.v_itm_subitemgroup_new_1 AS SUB ON ITM.subitemgroup_id = SUB.subitemgroup_id
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON ITEM_DEL.client_id = CRY.client_id AND
     CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
   INNER JOIN (SELECT CAL.dat_calendar,
     t17.cy_month
    FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_1 AS CAL
     INNER JOIN (SELECT dat_calendar,
       cy_month
      FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_1 AS CAL
      WHERE cy_month_sequence = - 2
       AND day_of_week = 7
       AND dat_calendar <> DATE_SUB(IF(dat_calendar = LAST_DAY(dat_calendar), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1
            MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(dat_calendar = LAST_DAY(dat_calendar
             ), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH))) DAY)
      QUALIFY dat_calendar = (MAX(dat_calendar) OVER (PARTITION BY CAST(cy_month AS STRING) RANGE BETWEEN
          UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t17 ON CAL.dat_calendar BETWEEN DATE_SUB(t17.dat_calendar,
       INTERVAL 34 DAY) AND t17.dat_calendar) AS m_2 ON ITEM_DEL.dat_formdate = m_2.dat_calendar
  WHERE ITEM_DEL.dat_formdate BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 112 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 30
      DAY))
  GROUP BY ITEM_DEL.wh_loc_sid,
   ITEM_DEL.client_id,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   CRY.currency_iso_cd,
   m_2.cy_month) AS t21
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON t21.client_id = WH.client_id AND t21.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
UNION ALL
SELECT t29.client_id,
 WH.src_wh_id AS wh_id,
 t29.item_sid AS item_id,
 t29.itemgroup_int_id,
 t29.cy_month,
 t29.currency_iso_cd,
 t29.qty_five_prev_weeks
FROM (SELECT ITEM_DEL.client_id,
   ITEM_DEL.wh_loc_sid,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   m_3.cy_month,
   CRY.currency_iso_cd,
   SUM(ITEM_DEL.qty_total_del_asis) AS qty_five_prev_weeks
  FROM ldl_p_lew_core_ac.v_wawi_agg_wh_day_item_del_asis_1 AS ITEM_DEL
   INNER JOIN ldl_p_lew_mart_msi.v_itm_item_1 AS ITM ON ITEM_DEL.client_id = ITM.client_id AND ITEM_DEL.item_sid = ITM.item_id
     
   INNER JOIN ldl_p_lew_mart_msi.v_itm_subitemgroup_new_1 AS SUB ON ITM.subitemgroup_id = SUB.subitemgroup_id
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON ITEM_DEL.client_id = CRY.client_id AND
     CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
   INNER JOIN (SELECT CAL.dat_calendar,
     t25.cy_month
    FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_1 AS CAL
     INNER JOIN (SELECT dat_calendar,
       cy_month
      FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_1 AS CAL
      WHERE cy_month_sequence = - 3
       AND day_of_week = 7
       AND dat_calendar <> DATE_SUB(IF(dat_calendar = LAST_DAY(dat_calendar), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1
            MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(dat_calendar = LAST_DAY(dat_calendar
             ), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH))) DAY)
      QUALIFY dat_calendar = (MAX(dat_calendar) OVER (PARTITION BY CAST(cy_month AS STRING) RANGE BETWEEN
          UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t25 ON CAL.dat_calendar BETWEEN DATE_SUB(t25.dat_calendar,
       INTERVAL 34 DAY) AND t25.dat_calendar) AS m_3 ON ITEM_DEL.dat_formdate = m_3.dat_calendar
  WHERE ITEM_DEL.dat_formdate BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 142 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 60
      DAY))
  GROUP BY ITEM_DEL.wh_loc_sid,
   ITEM_DEL.client_id,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   CRY.currency_iso_cd,
   m_3.cy_month) AS t29
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON t29.client_id = WH.client_id AND t29.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1;
