
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_agg_wh_mth_del_five_wk_py
AS
SELECT t7.client_id,
 WH.src_wh_id AS wh_id,
 t7.item_sid AS item_id,
 t7.itemgroup_int_id,
  t7.cy_month + 100 AS cy_month,
 t7.currency_iso_cd,
 t7.qty_five_prev_weeks_py
FROM (SELECT ITEM_DEL.client_id,
   ITEM_DEL.wh_loc_sid,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   m_1.cy_month,
   CRY.currency_iso_cd,
   SUM(ITEM_DEL.qty_total_del_asis) AS qty_five_prev_weeks_py
  FROM ldl_p_lew_core_ac.v_wawi_agg_wh_day_item_del_asis AS ITEM_DEL
   INNER JOIN ldl_p_lew_mart_msi.v_itm_item AS ITM ON ITEM_DEL.client_id = ITM.client_id AND ITEM_DEL.item_sid = ITM.item_id
     
   INNER JOIN ldl_p_lew_mart_msi.v_itm_subitemgroup_new AS SUB ON ITM.subitemgroup_id = SUB.subitemgroup_id
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON ITEM_DEL.client_id = CRY.client_id AND
     CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
   INNER JOIN (SELECT CAL.dat_calendar,
     t3.cy_month
    FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday AS CAL
     INNER JOIN (SELECT dat_calendar,
       cy_month
      FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday AS CAL
      WHERE dat_calendar IN (SELECT prev_cy_dat_calendar
         FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday AS CAL
         WHERE cy_month_sequence IN (- 1, 0)
          AND cy_day_sequence <= 0)
       AND day_of_week = 7
       AND dat_calendar <> DATE_SUB(IF(dat_calendar = LAST_DAY(dat_calendar), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1
            MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(dat_calendar = LAST_DAY(dat_calendar
             ), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH))) DAY)
      QUALIFY dat_calendar = (MAX(dat_calendar) OVER (PARTITION BY 1 RANGE BETWEEN UNBOUNDED PRECEDING AND
          UNBOUNDED FOLLOWING))) AS t3 ON CAL.dat_calendar BETWEEN DATE_SUB(t3.dat_calendar, INTERVAL 34 DAY) AND t3.dat_calendar
      ) AS m_1 ON ITEM_DEL.dat_formdate = m_1.dat_calendar
  WHERE ITEM_DEL.dat_formdate BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 410 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 330
      DAY))
  GROUP BY ITEM_DEL.wh_loc_sid,
   ITEM_DEL.client_id,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   CRY.currency_iso_cd,
   m_1.cy_month) AS t7
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON t7.client_id = WH.client_id AND t7.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
UNION ALL
SELECT t15.client_id,
 WH.src_wh_id AS wh_id,
 t15.item_sid AS item_id,
 t15.itemgroup_int_id,
  t15.cy_month + 100 AS cy_month,
 t15.currency_iso_cd,
 t15.qty_five_prev_weeks_py
FROM (SELECT ITEM_DEL.client_id,
   ITEM_DEL.wh_loc_sid,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   m_1.cy_month,
   CRY.currency_iso_cd,
   SUM(ITEM_DEL.qty_total_del_asis) AS qty_five_prev_weeks_py
  FROM ldl_p_lew_core_ac.v_wawi_agg_wh_day_item_del_asis AS ITEM_DEL
   INNER JOIN ldl_p_lew_mart_msi.v_itm_item AS ITM ON ITEM_DEL.client_id = ITM.client_id AND ITEM_DEL.item_sid = ITM.item_id
     
   INNER JOIN ldl_p_lew_mart_msi.v_itm_subitemgroup_new AS SUB ON ITM.subitemgroup_id = SUB.subitemgroup_id
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON ITEM_DEL.client_id = CRY.client_id AND
     CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
   INNER JOIN (SELECT CAL.dat_calendar,
     t11.cy_month
    FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday AS CAL
     INNER JOIN (SELECT dat_calendar,
       cy_month
      FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday AS CAL
      WHERE cy_month_sequence = - 13
       AND day_of_week = 7
       AND dat_calendar <> DATE_SUB(IF(dat_calendar = LAST_DAY(dat_calendar), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1
            MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(dat_calendar = LAST_DAY(dat_calendar
             ), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH))) DAY)
      QUALIFY dat_calendar = (MAX(dat_calendar) OVER (PARTITION BY CAST(cy_month AS STRING) RANGE BETWEEN
          UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t11 ON CAL.dat_calendar BETWEEN DATE_SUB(t11.dat_calendar,
       INTERVAL 34 DAY) AND t11.dat_calendar) AS m_1 ON ITEM_DEL.dat_formdate = m_1.dat_calendar
  WHERE ITEM_DEL.dat_formdate BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 442 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 360
      DAY))
  GROUP BY ITEM_DEL.wh_loc_sid,
   ITEM_DEL.client_id,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   CRY.currency_iso_cd,
   m_1.cy_month) AS t15
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON t15.client_id = WH.client_id AND t15.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
UNION ALL
SELECT t23.client_id,
 WH.src_wh_id AS wh_id,
 t23.item_sid AS item_id,
 t23.itemgroup_int_id,
  t23.cy_month + 100 AS cy_month,
 t23.currency_iso_cd,
 t23.qty_five_prev_weeks_py
FROM (SELECT ITEM_DEL.client_id,
   ITEM_DEL.wh_loc_sid,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   m_2.cy_month,
   CRY.currency_iso_cd,
   SUM(ITEM_DEL.qty_total_del_asis) AS qty_five_prev_weeks_py
  FROM ldl_p_lew_core_ac.v_wawi_agg_wh_day_item_del_asis AS ITEM_DEL
   INNER JOIN ldl_p_lew_mart_msi.v_itm_item AS ITM ON ITEM_DEL.client_id = ITM.client_id AND ITEM_DEL.item_sid = ITM.item_id
     
   INNER JOIN ldl_p_lew_mart_msi.v_itm_subitemgroup_new AS SUB ON ITM.subitemgroup_id = SUB.subitemgroup_id
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON ITEM_DEL.client_id = CRY.client_id AND
     CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
   INNER JOIN (SELECT CAL.dat_calendar,
     t19.cy_month
    FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday AS CAL
     INNER JOIN (SELECT dat_calendar,
       cy_month
      FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday AS CAL
      WHERE cy_month_sequence = - 14
       AND day_of_week = 7
       AND dat_calendar <> DATE_SUB(IF(dat_calendar = LAST_DAY(dat_calendar), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1
            MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(dat_calendar = LAST_DAY(dat_calendar
             ), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH))) DAY)
      QUALIFY dat_calendar = (MAX(dat_calendar) OVER (PARTITION BY CAST(cy_month AS STRING) RANGE BETWEEN
          UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t19 ON CAL.dat_calendar BETWEEN DATE_SUB(t19.dat_calendar,
       INTERVAL 34 DAY) AND t19.dat_calendar) AS m_2 ON ITEM_DEL.dat_formdate = m_2.dat_calendar
  WHERE ITEM_DEL.dat_formdate BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 472 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 390
      DAY))
  GROUP BY ITEM_DEL.wh_loc_sid,
   ITEM_DEL.client_id,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   CRY.currency_iso_cd,
   m_2.cy_month) AS t23
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON t23.client_id = WH.client_id AND t23.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
UNION ALL
SELECT t31.client_id,
 WH.src_wh_id AS wh_id,
 t31.item_sid AS item_id,
 t31.itemgroup_int_id,
  t31.cy_month + 100 AS cy_month,
 t31.currency_iso_cd,
 t31.qty_five_prev_weeks_py
FROM (SELECT ITEM_DEL.client_id,
   ITEM_DEL.wh_loc_sid,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   m_3.cy_month,
   CRY.currency_iso_cd,
   SUM(ITEM_DEL.qty_total_del_asis) AS qty_five_prev_weeks_py
  FROM ldl_p_lew_core_ac.v_wawi_agg_wh_day_item_del_asis AS ITEM_DEL
   INNER JOIN ldl_p_lew_mart_msi.v_itm_item AS ITM ON ITEM_DEL.client_id = ITM.client_id AND ITEM_DEL.item_sid = ITM.item_id
     
   INNER JOIN ldl_p_lew_mart_msi.v_itm_subitemgroup_new AS SUB ON ITM.subitemgroup_id = SUB.subitemgroup_id
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON ITEM_DEL.client_id = CRY.client_id AND
     CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
   INNER JOIN (SELECT CAL.dat_calendar,
     t27.cy_month
    FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday AS CAL
     INNER JOIN (SELECT dat_calendar,
       cy_month
      FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday AS CAL
      WHERE cy_month_sequence = - 15
       AND day_of_week = 7
       AND dat_calendar <> DATE_SUB(IF(dat_calendar = LAST_DAY(dat_calendar), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1
            MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(dat_calendar = LAST_DAY(dat_calendar
             ), LAST_DAY(DATE_ADD(dat_calendar, INTERVAL 1 MONTH)), DATE_ADD(dat_calendar, INTERVAL 1 MONTH))) DAY)
      QUALIFY dat_calendar = (MAX(dat_calendar) OVER (PARTITION BY CAST(cy_month AS STRING) RANGE BETWEEN
          UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t27 ON CAL.dat_calendar BETWEEN DATE_SUB(t27.dat_calendar,
       INTERVAL 34 DAY) AND t27.dat_calendar) AS m_3 ON ITEM_DEL.dat_formdate = m_3.dat_calendar
  WHERE ITEM_DEL.dat_formdate BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 502 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 420
      DAY))
  GROUP BY ITEM_DEL.wh_loc_sid,
   ITEM_DEL.client_id,
   ITEM_DEL.item_sid,
   SUB.itemgroup_int_id,
   CRY.currency_iso_cd,
   m_3.cy_month) AS t31
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON t31.client_id = WH.client_id AND t31.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1;
