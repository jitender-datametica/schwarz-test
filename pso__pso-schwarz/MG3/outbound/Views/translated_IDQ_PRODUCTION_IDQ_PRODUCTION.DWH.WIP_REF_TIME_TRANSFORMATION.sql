CREATE OR REPLACE VIEW idq_production_dwh.wip_ref_time_transformation (day_id, day_id_yesterday, ref_date, work_day,
year_id, year_id_de, year_id_en, semester_no, quarter_no, month_no, day_no, dayweek_no, month_name, month_name_de,
month_name_en, day_name, day_name_de, day_name_en, cw, month_id, quarter_id, semester_id, month1, day_seq, month_seq,
quarter_seq, year_seq, week_id, week_name, week_start) AS SELECT a.day_id,
 b.day_id AS day_id_yesterday,
 a.ref_date,
 a.work_day,
 a.year_id,
 a.year_id AS year_id_de,
 a.year_id AS year_id_en,
 a.semester_no,
 a.quarter_no,
 a.month_no,
 a.day_no,
 a.dayweek_no,
 a.month_name,
 a.month_name AS month_name_de,
 a.month_name_en,
 a.day_name,
 a.day_name AS day_name_de,
 a.day_name_en,
 a.cw,
 a.month_id,
 a.quarter_id,
 a.semester_id,
 a.month AS month1,
 a.day_seq,
 a.month_seq,
 a.quarter_seq,
 a.year_seq,
 ROUND(CAST(CASE
    WHEN LENGTH(CONCAT(EXTRACT(YEAR FROM DATE(DATETIME_ADD(a.ref_date, INTERVAL CAST(- (a.dayweek_no - 1) AS INTEGER) DAY))), EXTRACT(ISOWEEK FROM a.ref_date))) < 6
    THEN CONCAT(EXTRACT(YEAR FROM DATE(DATETIME_ADD(a.ref_date, INTERVAL CAST(- (a.dayweek_no - 1) AS INTEGER) DAY))), '0', EXTRACT(ISOWEEK FROM a.ref_date))
    ELSE CONCAT(EXTRACT(YEAR FROM DATE(DATETIME_ADD(a.ref_date, INTERVAL CAST(- (a.dayweek_no - 1) AS INTEGER) DAY))), EXTRACT(ISOWEEK FROM a.ref_date))
    END AS BIGNUMERIC), 0) AS week_id,
 CONCAT('W', EXTRACT(ISOWEEK FROM a.ref_date), ', ', EXTRACT(YEAR FROM DATE(DATETIME_ADD(a.ref_date, INTERVAL CAST(- (a.dayweek_no - 1) AS INTEGER)
     DAY)))) AS week_name,
 DATE(DATETIME_ADD(a.ref_date, INTERVAL CAST(- (a.dayweek_no - 1) AS INTEGER) DAY)) AS week_start
FROM idq_production_idq_results.ref_time AS a
 INNER JOIN idq_production_idq_results.ref_time AS b ON a.day_seq = b.day_seq + 1;