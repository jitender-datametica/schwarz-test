
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_WH_MTH_DEL_FIVE_WK_PY 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*
   #DescStart#
   #$Revision: 9087 $, $LastChangedBy: aarnold $
   #SubjectAreas#: Reichweite
   #DescEnd#
   */
   SELECT
       m0mp.client_id,
   wh.src_wh_id AS wh_id     /* Gesellschaft */,
   m0mp.item_sid       AS item_id,
   m0mp.itemgroup_int_id,
   (m0mp.cy_month+100) AS cy_month,
   m0mp.currency_iso_cd,
   m0mp.qty_five_prev_weeks_py
  FROM
  (
  SELECT
  /* current month py */
  item_del.client_id,
   item_del.wh_loc_sid,
   item_del.item_sid,
   sub.itemgroup_int_id,
   m_1.cy_month,
   cry.currency_iso_cd,
   SUM(item_del.qty_total_del_asis)  qty_five_prev_weeks_py
   FROM p_lew_core_ac.v_wawi_agg_wh_day_item_del_asis item_del
   INNER JOIN p_lew_mart_msi.v_itm_item itm
   ON item_del.client_id = itm.client_id
   AND item_del.item_sid  =  itm.item_id
   INNER JOIN p_lew_mart_msi.v_itm_subitemgroup_new sub
   ON itm.subitemgroup_id = sub.subitemgroup_id
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate cry
   ON item_del.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
   INNER JOIN
   (
   SELECT cal.dat_calendar,
   m_1.cy_month
   FROM p_lew_core_ac.v_wawi_cal_calendarday cal
   JOIN
   (
   SELECT dat_calendar,
   cy_month
   FROM p_lew_core_ac.v_wawi_cal_calendarday cal
   WHERE dat_calendar IN (
   SELECT prev_cy_dat_calendar
   FROM p_lew_core_ac.v_wawi_cal_calendarday cal
   WHERE cy_month_sequence IN (-1, 0)
   AND cy_day_sequence <= 0
   )
   AND day_of_week = 7
   AND dat_calendar <> ADD_MONTHS(dat_calendar, 1) - EXTRACT(DAY FROM ADD_MONTHS(dat_calendar, 1))
   QUALIFY dat_calendar = MAX(dat_calendar) OVER(PARTITION BY 1)
   ) m_1
   ON cal.dat_calendar BETWEEN m_1.dat_calendar - 34 AND m_1.dat_calendar
   ) m_1
   ON item_del.dat_formdate = m_1.dat_calendar
   WHERE item_del.dat_formdate BETWEEN CURRENT_DATE  - 410 AND CURRENT_DATE  -330
   GROUP BY
   item_del.client_id
   ,item_del.wh_loc_sid
   ,item_del.item_sid
   ,sub.itemgroup_int_id
   ,m_1.cy_month
   ,cry.currency_iso_cd
   ) AS m0mp
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh
   ON wh.client_id = m0mp.client_id
   AND wh.loc_sid_wh = m0mp.wh_loc_sid
   AND wh.dwh_actual_fg = 1
   UNION ALL
   SELECT
     m1mp.client_id,
   wh.src_wh_id AS wh_id     /* Gesellschaft */,
   m1mp.item_sid       AS item_id,
   m1mp.itemgroup_int_id,
   (m1mp.cy_month+100) AS cy_month,
   m1mp.currency_iso_cd,
   m1mp.qty_five_prev_weeks_py
  FROM (
    SELECT
    /* previous month 1 py */
    item_del.client_id,
   item_del.wh_loc_sid,
   item_del.item_sid,
   sub.itemgroup_int_id,
   m_1.cy_month,
   cry.currency_iso_cd,
   SUM(item_del.qty_total_del_asis)  qty_five_prev_weeks_py
    FROM p_lew_core_ac.v_wawi_agg_wh_day_item_del_asis item_del
   INNER JOIN p_lew_mart_msi.v_itm_item itm
   ON item_del.client_id = itm.client_id
   AND item_del.item_sid  =  itm.item_id
   INNER JOIN p_lew_mart_msi.v_itm_subitemgroup_new sub
   ON itm.subitemgroup_id = sub.subitemgroup_id
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate cry
   ON item_del.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
   INNER JOIN   (
   SELECT cal.dat_calendar,
   m_1.cy_month
       FROM p_lew_core_ac.v_wawi_cal_calendarday cal
   INNER JOIN   (
   SELECT dat_calendar,
   cy_month
         FROM p_lew_core_ac.v_wawi_cal_calendarday cal
   WHERE cy_month_sequence = -13
   AND day_of_week = 7
   AND dat_calendar <> ADD_MONTHS(dat_calendar, 1) - EXTRACT(DAY FROM ADD_MONTHS(dat_calendar, 1))
   QUALIFY dat_calendar = MAX(dat_calendar) OVER(PARTITION BY cy_month)
 ) m_1
   ON cal.dat_calendar BETWEEN m_1.dat_calendar - 34 AND m_1.dat_calendar
   ) m_1
   ON item_del.dat_formdate = m_1.dat_calendar
   WHERE item_del.dat_formdate BETWEEN CURRENT_DATE  - 442 AND CURRENT_DATE  -360
   GROUP BY
   item_del.client_id
   ,item_del.wh_loc_sid
   ,item_del.item_sid
   ,sub.itemgroup_int_id
   ,m_1.cy_month
   ,cry.currency_iso_cd
 ) AS m1mp
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh
   ON wh.client_id = m1mp.client_id
   AND wh.loc_sid_wh = m1mp.wh_loc_sid
   AND wh.dwh_actual_fg = 1
   UNION ALL
   SELECT
   m2mp.client_id,
   wh.src_wh_id AS wh_id     /* Gesellschaft */,
   m2mp.item_sid       AS item_id,
   m2mp.itemgroup_int_id,
   (m2mp.cy_month+100) AS cy_month,
   m2mp.currency_iso_cd,
   m2mp.qty_five_prev_weeks_py
  FROM (
     SELECT
     /* previous month 2 py */
     item_del.client_id,
   item_del.wh_loc_sid,
   item_del.item_sid,
   sub.itemgroup_int_id,
   m_2.cy_month,
   cry.currency_iso_cd,
   SUM(item_del.qty_total_del_asis)  qty_five_prev_weeks_py
      FROM p_lew_core_ac.v_wawi_agg_wh_day_item_del_asis item_del
   INNER JOIN p_lew_mart_msi.v_itm_item itm
   ON item_del.client_id = itm.client_id
   AND item_del.item_sid  =  itm.item_id
   INNER JOIN p_lew_mart_msi.v_itm_subitemgroup_new sub
   ON itm.subitemgroup_id = sub.subitemgroup_id
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate cry
   ON item_del.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
   INNER JOIN    (
   SELECT
     cal.dat_calendar,
   m_2.cy_month
       FROM p_lew_core_ac.v_wawi_cal_calendarday cal
   INNER JOIN    (
   SELECT
     dat_calendar,
   cy_month
         FROM p_lew_core_ac.v_wawi_cal_calendarday cal
   WHERE cy_month_sequence = -14
   AND day_of_week = 7
   AND dat_calendar <> ADD_MONTHS(dat_calendar, 1) - EXTRACT(DAY FROM ADD_MONTHS(dat_calendar, 1))
   QUALIFY dat_calendar = MAX(dat_calendar) OVER(PARTITION BY cy_month)
 ) m_2
   ON cal.dat_calendar BETWEEN m_2.dat_calendar - 34 AND m_2.dat_calendar
   ) m_2
   ON item_del.dat_formdate = m_2.dat_calendar
   WHERE item_del.dat_formdate BETWEEN CURRENT_DATE  - 472 AND CURRENT_DATE  -390
   GROUP BY
   item_del.client_id
   ,item_del.wh_loc_sid
   ,item_del.item_sid
   ,sub.itemgroup_int_id
   ,m_2.cy_month
   ,cry.currency_iso_cd
) AS m2mp
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh
   ON wh.client_id = m2mp.client_id
   AND wh.loc_sid_wh = m2mp.wh_loc_sid
   AND wh.dwh_actual_fg = 1
   UNION ALL
   SELECT
   m3mp.client_id,
   wh.src_wh_id AS wh_id     /* Gesellschaft */,
   m3mp.item_sid       AS item_id,
   m3mp.itemgroup_int_id,
   (m3mp.cy_month+100) AS cy_month,
   m3mp.currency_iso_cd,
   m3mp.qty_five_prev_weeks_py
  FROM (
     SELECT
     /* previous month 3 py */
       item_del.client_id,
   item_del.wh_loc_sid,
   item_del.item_sid,
   sub.itemgroup_int_id,
   m_3.cy_month,
   cry.currency_iso_cd,
   SUM(item_del.qty_total_del_asis)  qty_five_prev_weeks_py
     FROM p_lew_core_ac.v_wawi_agg_wh_day_item_del_asis item_del
   INNER JOIN p_lew_mart_msi.v_itm_item itm
   ON item_del.client_id = itm.client_id
   AND item_del.item_sid  =  itm.item_id
   INNER JOIN p_lew_mart_msi.v_itm_subitemgroup_new sub
   ON itm.subitemgroup_id = sub.subitemgroup_id
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate cry
   ON item_del.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
   INNER JOIN
   (
   SELECT cal.dat_calendar,
   m_3.cy_month
      FROM p_lew_core_ac.v_wawi_cal_calendarday cal
   JOIN
   (
   SELECT dat_calendar,
   cy_month
      FROM p_lew_core_ac.v_wawi_cal_calendarday cal
   WHERE cy_month_sequence = -15
   AND day_of_week = 7
   AND dat_calendar <> ADD_MONTHS(dat_calendar, 1) - EXTRACT(DAY FROM ADD_MONTHS(dat_calendar, 1))
   QUALIFY dat_calendar = MAX(dat_calendar) OVER(PARTITION BY cy_month)
   ) m_3
   ON cal.dat_calendar BETWEEN m_3.dat_calendar - 34 AND m_3.dat_calendar
   ) m_3
   ON item_del.dat_formdate = m_3.dat_calendar
   WHERE item_del.dat_formdate BETWEEN CURRENT_DATE  - 502 AND CURRENT_DATE  -420
   GROUP BY
   item_del.client_id
   ,item_del.wh_loc_sid
   ,item_del.item_sid
   ,sub.itemgroup_int_id
   ,m_3.cy_month
   ,cry.currency_iso_cd
) AS m3mp
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh
   ON wh.client_id = m3mp.client_id
   AND wh.loc_sid_wh = m3mp.wh_loc_sid
   AND wh.dwh_actual_fg = 1
;
