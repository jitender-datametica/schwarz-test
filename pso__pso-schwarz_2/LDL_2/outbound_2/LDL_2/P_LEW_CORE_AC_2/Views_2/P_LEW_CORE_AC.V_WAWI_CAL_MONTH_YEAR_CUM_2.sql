CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_cal_month_year_cum_2 (cy_month, cy_month_year_cum, cy_month_year_cum_py,
cy_month_year_cum_ppy) AS SELECT cy_month,
 cy_month_year_cum,
 cy_month_year_cum_py,
 cy_month_year_cum_ppy
FROM ldl_p_lew_core.t_wawi_cal_month_year_cum_2;