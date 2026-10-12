CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_cal_month_cum (cy_month, month_byr_cum, month_prev_byr_cum,
month_pprev_byr_cum) AS SELECT *
FROM ldl_p_lew_mart_msi.v_cal_month_cum;