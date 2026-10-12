CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_cal_week (cy_week, week_of_year, cy_week_begin_week_part,
cy_week_end_week_part, cy_week_begin_dt, cy_week_end_dt, cy_week_week_part_cnt, cy_week_prev_1w, cy_week_prev_1y,
cy_week_prev_2y, cy_week_prev_3y, cy_week_prev_4y, cy_week_prev_5y, cy_week_offset, cy_week_offset_artikelabverkauf,
cy_week_offset_artikel_live, cy_week_offset_dlz, cy_week_short_name, cy_week_name) AS SELECT cy_week,
 week_of_year,
 cy_week_begin_week_part,
 cy_week_end_week_part,
 cy_week_begin_dt,
 cy_week_end_dt,
 cy_week_week_part_cnt,
 cy_week_prev_1w,
 cy_week_prev_1y,
 cy_week_prev_2y,
 cy_week_prev_3y,
 cy_week_prev_4y,
 cy_week_prev_5y,
 cy_week_offset,
  CASE
  WHEN cy_week_offset > 8
  THEN NULL
  WHEN cy_week_offset >= 0 AND cy_week_offset <= 8
  THEN cy_week_offset - 3
  WHEN cy_week_offset >= - 3 AND cy_week_offset <= - 1
  THEN cy_week_offset + 9
  ELSE cy_week_offset
  END AS cy_week_offset_artikelabverkauf,
  CASE
  WHEN cy_week_offset >= - 1 AND cy_week_offset <= 2
  THEN cy_week_offset + 200
  WHEN cy_week_offset > 2
  THEN - 1 * cy_week_offset + 200
  ELSE cy_week_offset
  END AS cy_week_offset_artikel_live,
  CASE
  WHEN cy_week_offset > 0
  THEN - 1 * cy_week_offset - 100
  ELSE cy_week_offset
  END AS cy_week_offset_dlz,
 cy_week_short_name,
 cy_week_name
FROM ldl_dig_lec_share.v_dim_cal_week
WHERE cy_week <> -1
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('0' AS BIGNUMERIC), 0),
 ROUND(CAST('0' AS BIGNUMERIC), 0),
 DATE('1900-01-01'),
 DATE('1900-01-01'),
 ROUND(CAST('0' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('999' AS BIGNUMERIC), 0),
 ROUND(CAST('999' AS BIGNUMERIC), 0),
 ROUND(CAST('999' AS BIGNUMERIC), 0),
 ROUND(CAST('999' AS BIGNUMERIC), 0),
 '',
 '';