
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_ADV_WEEK_PERIOD_1
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     adv.client_id,
   adv.adv_week_id,
   CAST( (adv.adv_week_id * 100) + adv.client_id AS INTEGER) AS adv_week_sid,
   adv.adv_week_id AS adv_week_rltd_id,
   CAST( (adv.adv_week_id * 100) + adv.client_id AS INTEGER) AS adv_week_rltd_sid,
   adv.adv_period_id,
   advp.adv_period_descr,
   CAST(adv.adv_week_period_start_dt /*Warning, Format 'DD.MM_1-YYYY' removed, semantic information not found.*/ AS VARCHAR(50)) AS adv_week_period_start_dt_descr,
   CAST(adv.adv_week_period_end_dt /*Warning, Format 'DD.MM_1-YYYY' removed, semantic information not found.*/ AS VARCHAR(50)) AS adv_week_period_end_dt_descr,
   adv.adv_week_period_sort_val,
   adv.adv_week_period_start_dt,
   CASE (MOD((adv.adv_week_period_start_dt - DATE '1900-01-01'), 7)) + 1
   WHEN 1 THEN 'Montag'
   WHEN 2 THEN 'Dienstag'
   WHEN 3 THEN 'Mittwoch'
   WHEN 4 THEN 'Donnerstag'
   WHEN 5 THEN 'Freitag'
   WHEN 6 THEN 'Samstag'
   WHEN 7 THEN 'Sonntag'
END AS adv_week_period_start_day_desc,
   CASE (MOD((adv.adv_week_period_start_dt - DATE '1900-01-01'), 7)) + 1
   WHEN 1 THEN 'Mo.'
   WHEN 2 THEN 'Di.'
   WHEN 3 THEN 'Mi.'
   WHEN 4 THEN 'Do.'
   WHEN 5 THEN 'Fr.'
   WHEN 6 THEN 'Sa.'
   WHEN 7 THEN 'So.'
END AS adv_week_period_start_day_ab,
   adv.adv_week_period_end_dt,
   CASE (MOD((adv.adv_week_period_end_dt - DATE '1900-01-01'), 7)) + 1
   WHEN 1 THEN 'Montag'
   WHEN 2 THEN 'Dienstag'
   WHEN 3 THEN 'Mittwoch'
   WHEN 4 THEN 'Donnerstag'
   WHEN 5 THEN 'Freitag'
   WHEN 6 THEN 'Samstag'
   WHEN 7 THEN 'Sonntag'
END AS adv_week_period_end_day_desc,
   CASE (MOD((adv.adv_week_period_end_dt - DATE '1900-01-01'), 7)) + 1
   WHEN 1 THEN 'Mo.'
   WHEN 2 THEN 'Di.'
   WHEN 3 THEN 'Mi.'
   WHEN 4 THEN 'Do.'
   WHEN 5 THEN 'Fr.'
   WHEN 6 THEN 'Sa.'
   WHEN 7 THEN 'So.'
END AS adv_week_period_end_day_ab,
   advw.m_adv_week_start_dt,
   advw.m_adv_week_end_dt,
   advw.m_adv_week_end_ext_dt,
   adv_week_period_start_day_ab || ' ' || adv_week_period_start_dt_descr
    || ' bis '
    || adv_week_period_end_day_ab || ' ' || adv_week_period_end_dt_descr
    AS adv_week_period_long_descr,
   CASE (MOD((advw.m_adv_week_start_dt - DATE '1900-01-01'), 7)) + 1
   WHEN 1 THEN 'Mo.'
   WHEN 2 THEN 'Di.'
   WHEN 3 THEN 'Mi.'
   WHEN 4 THEN 'Do.'
   WHEN 5 THEN 'Fr.'
   WHEN 6 THEN 'Sa.'
   WHEN 7 THEN 'So.'
END
|| ' '
|| CAST(advw.m_adv_week_start_dt /*Warning, Format 'DD.MM_1-YYYY' removed, semantic information not found.*/ AS VARCHAR(50))
|| ' bis '
|| CASE (MOD((advw.m_adv_week_end_dt - DATE '1900-01-01'), 7)) + 1
   WHEN 1 THEN 'Mo.'
   WHEN 2 THEN 'Di.'
   WHEN 3 THEN 'Mi.'
   WHEN 4 THEN 'Do.'
   WHEN 5 THEN 'Fr.'
   WHEN 6 THEN 'Sa.'
   WHEN 7 THEN 'So.'
END
|| ' '
|| CAST(advw.m_adv_week_end_dt /*Warning, Format 'DD.MM_1-YYYY' removed, semantic information not found.*/ AS VARCHAR(50))
|| ' (Anmerkung: Maximale Laufzeit bis: '
|| CASE (MOD((advw.m_adv_week_end_ext_dt - DATE '1900-01-01'), 7)) + 1
   WHEN 1 THEN 'Mo.'
   WHEN 2 THEN 'Di.'
   WHEN 3 THEN 'Mi.'
   WHEN 4 THEN 'Do.'
   WHEN 5 THEN 'Fr.'
   WHEN 6 THEN 'Sa.'
   WHEN 7 THEN 'So.'
END
|| ' '
|| CAST(advw.m_adv_week_end_ext_dt /*Warning, Format 'DD.MM_1-YYYY' removed, semantic information not found.*/ AS VARCHAR(50))
|| ') '
AS adv_week_range_long_descr
FROM p_lew_mart_analytics.t_advert_week_period_1 AS adv
   INNER JOIN p_lew_mart_analytics.t_advert_period_1 AS advp
   ON  adv.adv_period_id = advp.adv_period_id
   AND advp.mstr_related_fg = 0
   INNER JOIN
   (
       SELECT
         client_id,
   adv_week_id,
   MIN(adv_week_period_start_dt)      AS m_adv_week_start_dt,
   MAX(adv_week_period_end_dt)        AS m_adv_week_end_ext_dt,
   MIN(adv_week_period_start_dt+6)    AS m_adv_week_end_dt
      FROM p_lew_mart_analytics.t_advert_week_period_1
      GROUP BY 1,2
  ) AS advw
   ON  adv.client_id   = advw.client_id
   AND adv.adv_week_id = advw.adv_week_id;
