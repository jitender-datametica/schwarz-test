CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_busyear_1 AS SELECT busyear AS byr,
 cy_by_seq AS cy_by_sequence
FROM ldl_p_lew_core_ac.v_cal_busyear_1;