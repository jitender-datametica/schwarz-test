
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_WH_MTH_DEL_FIVE_WK_ACT 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*
   #DescStart#
   #$Revision: 9086 $, $LastChangedBy: aarnold $
   #SubjectAreas#: Reichweite
   #DescEnd#
   */
   SELECT
       m0ma.client_id,
   wh.src_wh_id AS wh_id     /* Gesellschaft */,
   m0ma.item_sid       AS item_id,
   m0ma.itemgroup_int_id,
   m0ma.cy_month,
   m0ma.currency_iso_cd,
   m0ma.qty_five_prev_weeks
  FROM
      (
      SELECT
          /* current month */
          item_del.client_id,
   item_del.wh_loc_sid,
   item_del.item_sid,
   sub.itemgroup_int_id,
   act.cy_month,
   cry.currency_iso_cd,
   SUM(item_del.qty_total_del_asis)  qty_five_prev_weeks
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
   SELECT dat_calendar,
   act_month.cy_month
       FROM p_lew_core_ac.v_wawi_cal_calendarday cal
   CROSS JOIN
   (
   SELECT cy_month
   FROM p_lew_core_ac.v_wawi_cal_calendarday cal
   WHERE  cal.cy_day_sequence = 0
   ) act_month
   WHERE cy_week_sequence BETWEEN -5 AND -1
   ) act
   ON item_del.dat_formdate = act.dat_calendar
   WHERE item_del.dat_formdate BETWEEN CURRENT_DATE  - 44 AND CURRENT_DATE  -2
   GROUP BY
   item_del.client_id
   ,item_del.wh_loc_sid
   ,item_del.item_sid
   ,sub.itemgroup_int_id
   ,act.cy_month
   ,cry.currency_iso_cd
   ) m0ma
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh
   ON wh.client_id = m0ma.client_id
   AND wh.loc_sid_wh = m0ma.wh_loc_sid
   AND wh.dwh_actual_fg = 1
   UNION ALL
   SELECT
       m1ma.client_id,
   wh.src_wh_id AS wh_id     /* Gesellschaft */,
   m1ma.item_sid       AS item_id,
   m1ma.itemgroup_int_id,
   m1ma.cy_month,
   m1ma.currency_iso_cd,
   m1ma.qty_five_prev_weeks
  FROM
      (
      SELECT
          /* previous month 1 */
          item_del.client_id,
   item_del.wh_loc_sid,
   item_del.item_sid,
   sub.itemgroup_int_id,
   m_1.cy_month,
   cry.currency_iso_cd,
   SUM(item_del.qty_total_del_asis)  qty_five_prev_weeks
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
   WHERE cy_month_sequence = -1
   AND day_of_week = 7
   AND dat_calendar <> ADD_MONTHS(dat_calendar, 1) - EXTRACT(DAY FROM ADD_MONTHS(dat_calendar, 1))
   QUALIFY dat_calendar = MAX(dat_calendar) OVER(PARTITION BY cy_month)
   ) m_1
   ON cal.dat_calendar BETWEEN m_1.dat_calendar - 34 AND m_1.dat_calendar
   ) m_1
   ON item_del.dat_formdate = m_1.dat_calendar
   WHERE item_del.dat_formdate BETWEEN CURRENT_DATE  - 72 AND CURRENT_DATE  -2
   GROUP BY
   item_del.client_id
   ,item_del.wh_loc_sid
   ,item_del.item_sid
   ,sub.itemgroup_int_id
   ,m_1.cy_month
   ,cry.currency_iso_cd
   ) m1ma
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh
   ON wh.client_id = m1ma.client_id
   AND wh.loc_sid_wh = m1ma.wh_loc_sid
   AND wh.dwh_actual_fg = 1
   UNION ALL
   SELECT
       m2ma.client_id,
   wh.src_wh_id AS wh_id     /* Gesellschaft */,
   m2ma.item_sid       AS item_id,
   m2ma.itemgroup_int_id,
   m2ma.cy_month,
   m2ma.currency_iso_cd,
   m2ma.qty_five_prev_weeks
  FROM
      (
      SELECT
          /* previous month 2 */
          item_del.client_id,
   item_del.wh_loc_sid,
   item_del.item_sid,
   sub.itemgroup_int_id,
   m_2.cy_month,
   cry.currency_iso_cd,
   SUM(item_del.qty_total_del_asis)  qty_five_prev_weeks
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
   m_2.cy_month
       FROM p_lew_core_ac.v_wawi_cal_calendarday cal
   JOIN
   (
   SELECT dat_calendar,
   cy_month
       FROM p_lew_core_ac.v_wawi_cal_calendarday cal
   WHERE cy_month_sequence = -2
   AND day_of_week = 7
   AND dat_calendar <> ADD_MONTHS(dat_calendar, 1) - EXTRACT(DAY FROM ADD_MONTHS(dat_calendar, 1))
   QUALIFY dat_calendar = MAX(dat_calendar) OVER(PARTITION BY cy_month)
   ) m_2
   ON cal.dat_calendar BETWEEN m_2.dat_calendar - 34 AND m_2.dat_calendar
   ) m_2
   ON item_del.dat_formdate = m_2.dat_calendar
   WHERE item_del.dat_formdate BETWEEN CURRENT_DATE  - 112 AND CURRENT_DATE  -30
   GROUP BY
   item_del.client_id
   ,item_del.wh_loc_sid
   ,item_del.item_sid
   ,sub.itemgroup_int_id
   ,m_2.cy_month
   ,cry.currency_iso_cd
   ) m2ma
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh
   ON wh.client_id = m2ma.client_id
   AND wh.loc_sid_wh = m2ma.wh_loc_sid
   AND wh.dwh_actual_fg = 1
   UNION ALL
   SELECT
       m3ma.client_id,
   wh.src_wh_id AS wh_id     /* Gesellschaft */,
   m3ma.item_sid       AS item_id,
   m3ma.itemgroup_int_id,
   m3ma.cy_month,
   m3ma.currency_iso_cd,
   m3ma.qty_five_prev_weeks
  FROM
      (
      SELECT
          /* previous month 3 */
          item_del.client_id,
   item_del.wh_loc_sid,
   item_del.item_sid,
   sub.itemgroup_int_id,
   m_3.cy_month,
   cry.currency_iso_cd,
   SUM(item_del.qty_total_del_asis)  qty_five_prev_weeks
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
   WHERE cy_month_sequence = -3
   AND day_of_week = 7
   AND dat_calendar <> ADD_MONTHS(dat_calendar, 1) - EXTRACT(DAY FROM ADD_MONTHS(dat_calendar, 1))
   QUALIFY dat_calendar = MAX(dat_calendar) OVER(PARTITION BY cy_month)
   ) m_3
   ON cal.dat_calendar BETWEEN m_3.dat_calendar - 34 AND m_3.dat_calendar
   ) m_3
   ON item_del.dat_formdate = m_3.dat_calendar
   WHERE item_del.dat_formdate BETWEEN CURRENT_DATE  - 142 AND CURRENT_DATE  -60
   GROUP BY
   item_del.client_id
   ,item_del.wh_loc_sid
   ,item_del.item_sid
   ,sub.itemgroup_int_id
   ,m_3.cy_month
   ,cry.currency_iso_cd
   ) m3ma
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh
   ON wh.client_id = m3ma.client_id
   AND wh.loc_sid_wh = m3ma.wh_loc_sid
   AND wh.dwh_actual_fg = 1
;
