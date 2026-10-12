CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_cal_holiday_desc_1 (country_id, dat_holiday, language_id, holiday_desc,
load_id) AS SELECT country_id,
 dat_holiday,
 language_id,
 holiday_desc,
 load_id
FROM ldl_p_lew_core.t_wawi_cal_holiday_desc_1;