CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_month_cum_2 (cy_month, month_byr_cum, month_prev_byr_cum,
month_pprev_byr_cum) AS SELECT cy_month,
 month_byr_cum,
 month_prev_byr_cum,
 month_pprev_byr_cum
FROM ldl_p_lew_mart_msi.t_cal_month_cum_2;