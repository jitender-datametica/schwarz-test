CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_plt_plan_wa_wh_wk_1 (client_id, wh_id, aspect_id, currency_iso_cd, byr,
cy_month, cy_week_partial_week_id, cy_month_sequence, record_type, plt_plan_rcv_cum_mth, plt_plan_time_wa_cum_mth,
plt_plan_rcv_cum_yr, plt_plan_time_wa_cum_yr) AS SELECT *
FROM ldl_p_lew_mart_msi.v_plt_plan_wa_wh_wk_1;