CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_analytics.v_pit_adv_week_period_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT ADV.client_id,
 ADV.adv_week_id,
 CAST(ADV.adv_week_id * 100 + ADV.client_id AS BIGNUMERIC) AS adv_week_sid,
 ADV.adv_week_id AS adv_week_rltd_id,
 CAST(ADV.adv_week_id * 100 + ADV.client_id AS BIGNUMERIC) AS adv_week_rltd_sid,
 ADV.adv_period_id,
 ADVP.adv_period_descr,
 CAST(ADV.adv_week_period_start_dt /* Warning, Format 'DD.MM_2-YYYY' removed, semantic information not found. */ AS STRING)
 AS adv_week_period_start_dt_descr,
 CAST(ADV.adv_week_period_end_dt /* Warning, Format 'DD.MM_2-YYYY' removed, semantic information not found. */ AS STRING)
 AS adv_week_period_end_dt_descr,
 ADV.adv_week_period_sort_val,
 ADV.adv_week_period_start_dt,
  CASE
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 1
  THEN 'Montag'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 2
  THEN 'Dienstag'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 3
  THEN 'Mittwoch'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 4
  THEN 'Donnerstag'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 5
  THEN 'Freitag'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 6
  THEN 'Samstag'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 7
  THEN 'Sonntag'
  ELSE NULL
  END AS adv_week_period_start_day_desc,
  CASE
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 1
  THEN 'Mo.'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 2
  THEN 'Di.'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 3
  THEN 'Mi.'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 4
  THEN 'Do.'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 5
  THEN 'Fr.'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 6
  THEN 'Sa.'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 7
  THEN 'So.'
  ELSE NULL
  END AS adv_week_period_start_day_ab,
 ADV.adv_week_period_end_dt,
  CASE
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 1
  THEN 'Montag'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 2
  THEN 'Dienstag'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 3
  THEN 'Mittwoch'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 4
  THEN 'Donnerstag'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 5
  THEN 'Freitag'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 6
  THEN 'Samstag'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 7
  THEN 'Sonntag'
  ELSE NULL
  END AS adv_week_period_end_day_desc,
  CASE
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 1
  THEN 'Mo.'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 2
  THEN 'Di.'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 3
  THEN 'Mi.'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 4
  THEN 'Do.'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 5
  THEN 'Fr.'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 6
  THEN 'Sa.'
  WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 7
  THEN 'So.'
  ELSE NULL
  END AS adv_week_period_end_day_ab,
 advw.m_adv_week_start_dt,
 advw.m_adv_week_end_dt,
 advw.m_adv_week_end_ext_dt,
        CASE
        WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 1
        THEN 'Mo.'
        WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 2
        THEN 'Di.'
        WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 3
        THEN 'Mi.'
        WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 4
        THEN 'Do.'
        WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 5
        THEN 'Fr.'
        WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 6
        THEN 'Sa.'
        WHEN MOD(DATE_DIFF(ADV.adv_week_period_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 7
        THEN 'So.'
        ELSE NULL
        END || ' ' || CAST(ADV.adv_week_period_start_dt AS STRING) || ' bis ' || CASE
     WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 1
     THEN 'Mo.'
     WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 2
     THEN 'Di.'
     WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 3
     THEN 'Mi.'
     WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 4
     THEN 'Do.'
     WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 5
     THEN 'Fr.'
     WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 6
     THEN 'Sa.'
     WHEN MOD(DATE_DIFF(ADV.adv_week_period_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 7
     THEN 'So.'
     ELSE NULL
     END || ' ' || CAST(ADV.adv_week_period_end_dt AS STRING) AS adv_week_period_long_descr,
             CASE
             WHEN MOD(DATE_DIFF(advw.m_adv_week_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 1
             THEN 'Mo.'
             WHEN MOD(DATE_DIFF(advw.m_adv_week_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 2
             THEN 'Di.'
             WHEN MOD(DATE_DIFF(advw.m_adv_week_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 3
             THEN 'Mi.'
             WHEN MOD(DATE_DIFF(advw.m_adv_week_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 4
             THEN 'Do.'
             WHEN MOD(DATE_DIFF(advw.m_adv_week_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 5
             THEN 'Fr.'
             WHEN MOD(DATE_DIFF(advw.m_adv_week_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 6
             THEN 'Sa.'
             WHEN MOD(DATE_DIFF(advw.m_adv_week_start_dt, DATE '1900-01-01', DAY), 7) + 1 = 7
             THEN 'So.'
             ELSE NULL
             END || ' ' || CAST(advw.m_adv_week_start_dt /* Warning, Format 'DD.MM_2-YYYY' removed, semantic information not found. */ AS STRING)
            || ' bis ' || CASE
          WHEN MOD(DATE_DIFF(advw.m_adv_week_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 1
          THEN 'Mo.'
          WHEN MOD(DATE_DIFF(advw.m_adv_week_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 2
          THEN 'Di.'
          WHEN MOD(DATE_DIFF(advw.m_adv_week_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 3
          THEN 'Mi.'
          WHEN MOD(DATE_DIFF(advw.m_adv_week_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 4
          THEN 'Do.'
          WHEN MOD(DATE_DIFF(advw.m_adv_week_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 5
          THEN 'Fr.'
          WHEN MOD(DATE_DIFF(advw.m_adv_week_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 6
          THEN 'Sa.'
          WHEN MOD(DATE_DIFF(advw.m_adv_week_end_dt, DATE '1900-01-01', DAY), 7) + 1 = 7
          THEN 'So.'
          ELSE NULL
          END || ' ' || CAST(advw.m_adv_week_end_dt /* Warning, Format 'DD.MM_2-YYYY' removed, semantic information not found. */ AS STRING)
        || ' (Anmerkung: Maximale Laufzeit bis: ' || CASE
      WHEN MOD(DATE_DIFF(advw.m_adv_week_end_ext_dt, DATE '1900-01-01', DAY), 7) + 1 = 1
      THEN 'Mo.'
      WHEN MOD(DATE_DIFF(advw.m_adv_week_end_ext_dt, DATE '1900-01-01', DAY), 7) + 1 = 2
      THEN 'Di.'
      WHEN MOD(DATE_DIFF(advw.m_adv_week_end_ext_dt, DATE '1900-01-01', DAY), 7) + 1 = 3
      THEN 'Mi.'
      WHEN MOD(DATE_DIFF(advw.m_adv_week_end_ext_dt, DATE '1900-01-01', DAY), 7) + 1 = 4
      THEN 'Do.'
      WHEN MOD(DATE_DIFF(advw.m_adv_week_end_ext_dt, DATE '1900-01-01', DAY), 7) + 1 = 5
      THEN 'Fr.'
      WHEN MOD(DATE_DIFF(advw.m_adv_week_end_ext_dt, DATE '1900-01-01', DAY), 7) + 1 = 6
      THEN 'Sa.'
      WHEN MOD(DATE_DIFF(advw.m_adv_week_end_ext_dt, DATE '1900-01-01', DAY), 7) + 1 = 7
      THEN 'So.'
      ELSE NULL
      END || ' ' || CAST(advw.m_adv_week_end_ext_dt /* Warning, Format 'DD.MM_2-YYYY' removed, semantic information not found. */ AS STRING)
    || ') ' AS adv_week_range_long_descr
FROM ldl_p_lew_mart_analytics.t_advert_week_period_2 AS ADV
 INNER JOIN ldl_p_lew_mart_analytics.t_advert_period_2 AS ADVP ON ADV.adv_period_id = ADVP.adv_period_id AND ADVP.mstr_related_fg
    = 0
 INNER JOIN (SELECT client_id,
   adv_week_id,
   MIN(adv_week_period_start_dt) AS m_adv_week_start_dt,
   MAX(adv_week_period_end_dt) AS m_adv_week_end_ext_dt,
   MIN(DATE_ADD(adv_week_period_start_dt, INTERVAL 6 DAY)) AS m_adv_week_end_dt
  FROM ldl_p_lew_mart_analytics.t_advert_week_period_2
  GROUP BY client_id,
   adv_week_id) AS advw ON ADV.client_id = advw.client_id AND ADV.adv_week_id = advw.adv_week_id;