/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - PITonPrem TD2SF Migration Project Fall 2021
#-------------------------------------------------------------------------------
# Interface : DDL for Create PIT_ONPREM Transformation View V_PIT_ADV_WEEK_PERIOD_2
#-------------------------------------------------------------------------------
# Description: DDL for Create PIT_ONPREM Transformation View V_PIT_ADV_WEEK_PERIOD_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-10-15 Andreas Kurz     Initial version
#  1.1  2022-05-09 Dirk Hering      Fix for adv week start date, end date
#-------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_adv_week_period_2 AS SELECT ADV.client_id,
 ADV.adv_week_id,
 CAST(ADV.adv_week_id * 100 + ADV.client_id AS BIGNUMERIC) AS adv_week_sid,
 ADV.adv_week_id AS adv_week_rltd_id,
 CAST(ADV.adv_week_id * 100 + ADV.client_id AS BIGNUMERIC) AS adv_week_rltd_sid,
 ADV.adv_period_id,
 ADVP.adv_period_descr,
 FORMAT_DATE('%d.%m.%Y', ADV.adv_week_period_start_dt) AS adv_week_period_start_dt_descr,
 FORMAT_DATE('%d.%m.%Y', ADV.adv_week_period_end_dt) AS adv_week_period_end_dt_descr,
 ADV.adv_week_period_sort_val,
 ADV.adv_week_period_start_dt,
  CASE
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 1
  THEN 'Montag'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 2
  THEN 'Dienstag'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 3
  THEN 'Mittwoch'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 4
  THEN 'Donnerstag'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 5
  THEN 'Freitag'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 6
  THEN 'Samstag'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 7
  THEN 'Sonntag'
  ELSE 'N/A'
  END AS adv_week_period_start_day_desc,
  CASE
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 1
  THEN 'Mo.'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 2
  THEN 'Di.'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 3
  THEN 'Mi.'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 4
  THEN 'Do.'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 5
  THEN 'Fr.'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 6
  THEN 'Sa.'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 7
  THEN 'So.'
  ELSE 'N/A'
  END AS adv_week_period_start_day_ab,
 ADV.adv_week_period_end_dt,
  CASE
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 1
  THEN 'Montag'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 2
  THEN 'Dienstag'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 3
  THEN 'Mittwoch'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 4
  THEN 'Donnerstag'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 5
  THEN 'Freitag'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 6
  THEN 'Samstag'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 7
  THEN 'Sonntag'
  ELSE 'N/A'
  END AS adv_week_period_end_day_desc,
  CASE
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 1
  THEN 'Mo.'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 2
  THEN 'Di.'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 3
  THEN 'Mi.'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 4
  THEN 'Do.'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 5
  THEN 'Fr.'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 6
  THEN 'Sa.'
  WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 7
  THEN 'So.'
  ELSE 'N/A'
  END AS adv_week_period_end_day_ab,
 advw.m_adv_week_start_dt,
 advw.m_adv_week_end_dt,
 advw.m_adv_week_end_ext_dt,
        CASE
        WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 1
        THEN 'Mo.'
        WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 2
        THEN 'Di.'
        WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 3
        THEN 'Mi.'
        WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 4
        THEN 'Do.'
        WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 5
        THEN 'Fr.'
        WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 6
        THEN 'Sa.'
        WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_start_dt)) AS INTEGER) = 7
        THEN 'So.'
        ELSE 'N/A'
        END || ' ' || FORMAT_DATE('%d.%m.%Y', ADV.adv_week_period_start_dt) || ' bis ' || CASE
     WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 1
     THEN 'Mo.'
     WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 2
     THEN 'Di.'
     WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 3
     THEN 'Mi.'
     WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 4
     THEN 'Do.'
     WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 5
     THEN 'Fr.'
     WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 6
     THEN 'Sa.'
     WHEN CAST(FORMAT_DATE('%u', DATE(ADV.adv_week_period_end_dt)) AS INTEGER) = 7
     THEN 'So.'
     ELSE 'N/A'
     END || ' ' || FORMAT_DATE('%d.%m.%Y', ADV.adv_week_period_end_dt) AS adv_week_period_long_descr,
             CASE
             WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_start_dt)) AS INTEGER) = 1
             THEN 'Mo.'
             WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_start_dt)) AS INTEGER) = 2
             THEN 'Di.'
             WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_start_dt)) AS INTEGER) = 3
             THEN 'Mi.'
             WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_start_dt)) AS INTEGER) = 4
             THEN 'Do.'
             WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_start_dt)) AS INTEGER) = 5
             THEN 'Fr.'
             WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_start_dt)) AS INTEGER) = 6
             THEN 'Sa.'
             WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_start_dt)) AS INTEGER) = 7
             THEN 'So.'
             ELSE 'N/A'
             END || ' ' || FORMAT_DATE('%d.%m.%Y', advw.m_adv_week_start_dt) || ' bis ' || CASE
          WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_dt)) AS INTEGER) = 1
          THEN 'Mo.'
          WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_dt)) AS INTEGER) = 2
          THEN 'Di.'
          WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_dt)) AS INTEGER) = 3
          THEN 'Mi.'
          WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_dt)) AS INTEGER) = 4
          THEN 'Do.'
          WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_dt)) AS INTEGER) = 5
          THEN 'Fr.'
          WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_dt)) AS INTEGER) = 6
          THEN 'Sa.'
          WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_dt)) AS INTEGER) = 7
          THEN 'So.'
          ELSE 'N/A'
          END || ' ' || FORMAT_DATE('%d.%m.%Y', advw.m_adv_week_end_dt) || ' (Anmerkung: Maximale Laufzeit bis: ' ||
      CASE
      WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_ext_dt)) AS INTEGER) = 1
      THEN 'Mo.'
      WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_ext_dt)) AS INTEGER) = 2
      THEN 'Di.'
      WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_ext_dt)) AS INTEGER) = 3
      THEN 'Mi.'
      WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_ext_dt)) AS INTEGER) = 4
      THEN 'Do.'
      WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_ext_dt)) AS INTEGER) = 5
      THEN 'Fr.'
      WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_ext_dt)) AS INTEGER) = 6
      THEN 'Sa.'
      WHEN CAST(FORMAT_DATE('%u', DATE(advw.m_adv_week_end_ext_dt)) AS INTEGER) = 7
      THEN 'So.'
      ELSE 'N/A'
      END || ' ' || FORMAT_DATE('%d.%m.%Y', advw.m_adv_week_end_ext_dt) || ') ' AS adv_week_range_long_descr
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_period_2 AS ADV
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_period_2 AS ADVP ON ADV.adv_period_id = ADVP.adv_period_id AND ADVP.mstr_related_fg
    = 0
 INNER JOIN (SELECT P.client_id,
   P.adv_week_id,
   A.adv_week_start_dt AS m_adv_week_start_dt,
   A.adv_week_end_dt AS m_adv_week_end_dt,
   MAX(P.adv_week_period_end_dt) AS m_adv_week_end_ext_dt
  FROM ldl_p_lew_mart_pit_onprem.t_advert_week_period_2 AS P
   INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_2 AS A ON P.client_id = A.client_id AND P.adv_week_id = A.adv_week_id
     
  GROUP BY P.client_id,
   P.adv_week_id,
   m_adv_week_start_dt,
   m_adv_week_end_dt) AS advw ON ADV.client_id = advw.client_id AND ADV.adv_week_id = advw.adv_week_id;