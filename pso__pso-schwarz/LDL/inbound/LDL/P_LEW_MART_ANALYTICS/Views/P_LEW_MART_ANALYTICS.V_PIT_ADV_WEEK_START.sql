CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_PIT_ADV_WEEK_START
AS
   SELECT
     client_id,
   dwh_valid_from,
   CAST(dwh_valid_from /*Warning, Format 'DD.MMM-YYYY' removed, semantic information not found.*/ AS VARCHAR(50)) AS dwh_valid_from_descr,
   dwh_valid_to,
   adv_week_start_day,
   CASE adv_week_start_day
        WHEN 1 THEN 'Montag'
        WHEN 2 THEN 'Dienstag'
        WHEN 3 THEN 'Mittwoch'
        WHEN 4 THEN 'Donnerstag'
        WHEN 5 THEN 'Freitag'
        WHEN 6 THEN 'Samstag'
        WHEN 7 THEN 'Sonntag'
        ELSE NULL
    END AS adv_week_start_day_descr,
   CASE adv_week_start_day
        WHEN 1 THEN 'Mo.'
        WHEN 2 THEN 'Di.'
        WHEN 3 THEN 'Mi.'
        WHEN 4 THEN 'Do.'
        WHEN 5 THEN 'Fr.'
        WHEN 6 THEN 'Sa.'
        WHEN 7 THEN 'So.'
        ELSE NULL
    END AS adv_week_start_day_abbrv,
   following_cal_week_fg,
   dwh_created,
   dwh_updated
  FROM p_lew_mart_analytics.t_country_advert_week_start
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to;