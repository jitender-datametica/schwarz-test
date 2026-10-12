CREATE OR REPLACE VIEW idq_production_dwh.wip_ref_time_transformation_2 (day_id, day_id_yesterday, ref_date, work_day,
year_id, year_id_de, year_id_en, semester_no, quarter_no, month_no, day_no, dayweek_no, month_name, month_name_de,
month_name_en, day_name, day_name_de, day_name_en, cw, month_id, quarter_id, semester_id, month1, day_seq, month_seq,
quarter_seq, year_seq, week_id, week_name, week_start) AS SELECT A.day_id,
 B.day_id AS day_id_yesterday,
 A.ref_date,
 A.work_day,
 A.year_id,
 A.year_id AS year_id_de,
 A.year_id AS year_id_en,
 A.semester_no,
 A.quarter_no,
 A.month_no,
 A.day_no,
 A.dayweek_no,
 A.month_name,
 A.month_name AS month_name_de,
 A.month_name_en,
 A.day_name,
 A.day_name AS day_name_de,
 A.day_name_en,
 A.cw,
 A.month_id,
 A.quarter_id,
 A.semester_id,
 A.month AS month1,
 A.day_seq,
 A.month_seq,
 A.quarter_seq,
 A.year_seq,
 ROUND(CAST(CASE
    WHEN LENGTH(CONCAT(EXTRACT(YEAR FROM DATE(DATETIME_ADD(A.ref_date, INTERVAL - (A.dayweek_no - 1) DAY))), EXTRACT(ISOWEEK FROM A.ref_date))) < 6
    THEN CONCAT(EXTRACT(YEAR FROM DATE(DATETIME_ADD(A.ref_date, INTERVAL - (A.dayweek_no - 1) DAY))), '0', EXTRACT(ISOWEEK FROM A.ref_date))
    ELSE CONCAT(EXTRACT(YEAR FROM DATE(DATETIME_ADD(A.ref_date, INTERVAL - (A.dayweek_no - 1) DAY))), EXTRACT(ISOWEEK FROM A.ref_date))
    END AS BIGNUMERIC), 0) AS week_id,
 CONCAT('W', EXTRACT(ISOWEEK FROM A.ref_date), ', ', EXTRACT(YEAR FROM DATE(DATETIME_ADD(A.ref_date, INTERVAL - (A.dayweek_no
        - 1) DAY)))) AS week_name,
 DATE(DATETIME_ADD(A.ref_date, INTERVAL - (A.dayweek_no - 1) DAY)) AS week_start
FROM idq_production_idq_results.ref_time_2 AS A
 INNER JOIN idq_production_idq_results.ref_time_2 AS B ON A.day_seq = B.day_seq + 1;