CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_cal_day_of_week_desc (day_of_week, language_id, day_of_week_desc) AS
SELECT day_of_week,
 language_id,
 day_of_week_desc
FROM ldl_p_lew_core.t_wawi_cal_day_of_week_desc;