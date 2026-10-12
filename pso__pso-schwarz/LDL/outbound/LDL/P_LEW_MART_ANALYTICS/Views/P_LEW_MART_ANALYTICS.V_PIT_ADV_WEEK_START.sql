CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_pit_adv_week_start AS SELECT client_id,
 dwh_valid_from,
 CAST(dwh_valid_from AS STRING) AS dwh_valid_from_descr,
 dwh_valid_to,
 adv_week_start_day,
  CASE
  WHEN adv_week_start_day = 1
  THEN 'Montag'
  WHEN adv_week_start_day = 2
  THEN 'Dienstag'
  WHEN adv_week_start_day = 3
  THEN 'Mittwoch'
  WHEN adv_week_start_day = 4
  THEN 'Donnerstag'
  WHEN adv_week_start_day = 5
  THEN 'Freitag'
  WHEN adv_week_start_day = 6
  THEN 'Samstag'
  WHEN adv_week_start_day = 7
  THEN 'Sonntag'
  ELSE NULL
  END AS adv_week_start_day_descr,
  CASE
  WHEN adv_week_start_day = 1
  THEN 'Mo.'
  WHEN adv_week_start_day = 2
  THEN 'Di.'
  WHEN adv_week_start_day = 3
  THEN 'Mi.'
  WHEN adv_week_start_day = 4
  THEN 'Do.'
  WHEN adv_week_start_day = 5
  THEN 'Fr.'
  WHEN adv_week_start_day = 6
  THEN 'Sa.'
  WHEN adv_week_start_day = 7
  THEN 'So.'
  ELSE NULL
  END AS adv_week_start_day_abbrv,
 following_cal_week_fg,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_analytics.t_country_advert_week_start
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to;