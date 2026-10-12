CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_tickets_it4you_1 AS SELECT DISTINCT v_tickets_daily.upload_date AS
 upload_date_ts,
 DATE(v_tickets_daily.upload_date) AS upload_date,
 v_tickets_daily.id AS ticket_id,
 v_tickets_daily.priority,
 t_tickets_status.id AS status_id,
 t_tickets_status.status_desc,
 t_tickets_it4you_groups.id AS assigned_to_group_id,
 v_tickets_daily.assigned_to_group,
 t_tickets_it4you_groups.team,
 v_tickets_daily.subject,
 t_tickets_type.id AS type_id,
 t_tickets_type.type_desc,
 COUNTRY.client_id,
 COUNTRY.country_name,
 COUNTRY.country_cluster_id,
 COUNTRY.country_cluster_name,
 COUNTRY.country_flag_img,
 COUNTRY.country_flag_img_name,
 TOPICS.topic,
 TOPICS.category,
 v_tickets_daily.assignment_group_history,
 v_tickets_daily.solution,
 v_tickets_daily.ci,
 v_tickets_daily.created_on AS created_on_ts,
 DATE(v_tickets_daily.created_on) AS created_on_date,
 v_tickets_daily.changed_on,
  CASE
  WHEN TIME(v_tickets_daily.upload_date) < '13:30:00.000'
  THEN 'Morgen'
  ELSE 'Mittag'
  END AS export_fg,
 t_dim_cal_day.cy AS year,
 t_dim_cal_day.bus_year,
 t_dim_cal_day.cy_month AS year_month_id,
 t_dim_cal_day.month_of_year AS month_nr,
 t_dim_cal_day.month_of_year_name AS month_name,
 t_dim_cal_day.week_of_year AS week_nr,
 t_dim_cal_week.cy_week_short_name AS kw_week_nr,
 t_dim_cal_day.cy_week AS year_week_id,
 t_dim_cal_week.cy_week_name AS year_kw_nr,
 DATETIME_DIFF(v_tickets_daily.upload_date, CAST(DATE(v_tickets_daily.created_on) AS DATETIME), DAY) AS delta_created,
 DATETIME_DIFF(v_tickets_daily.upload_date, v_tickets_daily.changed_on, DAY) AS delta_changed,
  ARRAY_LENGTH(REGEXP_EXTRACT_ALL(SUBSTR(v_tickets_daily.assignment_group_history, IF(1 <= 0, 1, 1)), ',')) + 1 AS
 amount_groups_in,
 v_tickets_daily.opened_by_group,
 ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) AS
 days_since_creation,
 CAST(FLOOR(ABS(DATE_DIFF(DATE(v_tickets_daily.created_on), v_tickets_daily.upload_date, DAY)) / 7) AS INTEGER) AS
 weeks_since_creation,
 CAST(FLOOR(ABS(DATE_DIFF(DATE(v_tickets_daily.created_on), v_tickets_daily.upload_date, DAY)) / 30) AS INTEGER) AS
 months_since_creation,
  CASE
  WHEN ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) >= 84
  THEN 85
  WHEN ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) >= 56
   AND ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) < 84
  THEN 84
  WHEN ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) >= 28
   AND ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) < 56
  THEN 56
  WHEN ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) >= 14
   AND ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) < 28
  THEN 28
  WHEN ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) >= 7 AND
    ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) < 14
  THEN 14
  WHEN ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) < 7
  THEN 7
  ELSE NULL
  END AS age_tickets_id,
  CASE
  WHEN ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) >= 84
  THEN ' >=12 Wochen'
  WHEN ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) >= 56
   AND ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) < 84
  THEN '8-12 Wochen'
  WHEN ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) >= 28
   AND ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) < 56
  THEN '4-8 Wochen'
  WHEN ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) >= 14
   AND ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) < 28
  THEN '2-4 Wochen'
  WHEN ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) >= 7 AND
    ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) < 14
  THEN '1-2 Wochen'
  WHEN ABS(DATETIME_DIFF(CAST(DATE(v_tickets_daily.created_on) AS DATETIME), v_tickets_daily.upload_date, DAY)) < 7
  THEN '1-7 Tage'
  ELSE NULL
  END AS age_tickets_week
FROM ldl_bcbi_fe_mstr_bcbi.v_tickets_daily_1
 INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_dim_cal_day_1 ON DATE(v_tickets_daily.upload_date) = t_dim_cal_day.cal_dt
 INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_dim_cal_week_1 ON t_dim_cal_day.cy_week = t_dim_cal_week.cy_week
 INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_tickets_status_1 ON v_tickets_daily.status_ = t_tickets_status.status_desc
 INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_tickets_type_1 ON v_tickets_daily.type = t_tickets_type.type_desc
 INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_tickets_it4you_groups_1 ON v_tickets_daily.assigned_to_group = t_tickets_it4you_groups_1
  .gruppe_1
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.v_tickets_country_all_1 AS COUNTRY_1 ON v_tickets_daily.country_ticket_id = COUNTRY.country_ticket_id
    AND v_tickets_daily.opened_by_group = COUNTRY.opened_by_group
 INNER JOIN ldl_bcbi_fe_mstr_bcbi.v_tickets_topics_1 AS TOPICS ON v_tickets_daily.id = TOPICS.id AND v_tickets_daily.upload_date
    = TOPICS.upload_date;