CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_kpges_turnover_plan_day_country_region_1 (client_id, dat_formdate,
currency_iso_cd, dat_dayend, val_indicator, gl_region_id, aspect_id, wh_id, val_indicator_gl) AS SELECT client_id,
 dat_formdate,
 currency_iso_cd,
 dat_dayend,
 val_indicator,
 gl_region_id,
 aspect_id,
 wh_id,
 val_indicator_gl
FROM ldl_p_lew_mart_msi.v_kpges_turnover_plan_day_country_region_1;