CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_calendaryear (cy, prev_cy, cy_year_sequence) AS SELECT cy,
 prev_cy,
 cy_year_sequence
FROM ldl_p_lew_mart_msi.t_cal_calendaryear;