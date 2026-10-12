CREATE OR REPLACE VIEW idq_production_dwh.ref_time (day_id, ref_date, work_day, year_id, year_id_de, year_id_en,
semester_no, quarter_no, month_no, day_no, dayweek_no, month_name, month_name_de, month_name_en, day_name, day_name_de,
day_name_en, cw, month_id, quarter_id, semester_id, month, day_seq, month_seq, quarter_seq, year_seq, week_id, week_name
, week_start) AS SELECT day_id,
 ref_date,
 work_day,
 year_id,
 year_id AS year_id_de,
 year_id AS year_id_en,
 semester_no,
 quarter_no,
 month_no,
 day_no,
 dayweek_no,
 month_name,
 month_name AS month_name_de,
 month_name_en,
 day_name,
 day_name AS day_name_de,
 day_name_en,
 cw,
 month_id,
 quarter_id,
 semester_id,
 month,
 day_seq,
 month_seq,
 quarter_seq,
 year_seq,
  CASE
  WHEN LENGTH(CONCAT(year_id, cw)) < 6
  THEN CONCAT(year_id, '0', cw)
  ELSE CONCAT(year_id, cw)
  END AS week_id,
 CONCAT('W', cw, ', ', year_id) AS week_name,
 DATE(DATETIME_ADD(ref_date, INTERVAL - (dayweek_no - 1) DAY)) AS week_start
FROM idq_production_idq_results.ref_time;