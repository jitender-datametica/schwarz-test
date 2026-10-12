CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_lift_trend_comparison_1 (client_id, rtl_id, rtl_lvl, per_id, prom_id,
meas_id, lift_cat_id, currency_iso_cd, rtl_tp_id, dsc_nr, revenuechange, revenuechange_to_ejr, trend_ratio, cover,
cover_ljp, cover_delta) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_lift_trend_comparison_1;