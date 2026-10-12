CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_cal_holiday_2 (country_id, dat_holiday, holidaytype_id, load_id) AS SELECT
 country_id,
 dat_holiday,
 holidaytype_id,
 load_id
FROM ldl_p_lew_core.t_wawi_cal_holiday_2;