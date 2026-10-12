CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_week_t11_2 AS SELECT A.cy_week,
 B.cy_week AS cy_week_t
FROM ldl_p_lew_mart_msi.v_cal_week_2 AS A
 LEFT JOIN ldl_p_lew_mart_msi.v_cal_week_2 AS B ON B.cy_week_sequence > A.cy_week_sequence - 12 AND A.cy_week_sequence >=
   B.cy_week_sequence
WHERE A.cy_week_sequence BETWEEN - 30 AND 0;