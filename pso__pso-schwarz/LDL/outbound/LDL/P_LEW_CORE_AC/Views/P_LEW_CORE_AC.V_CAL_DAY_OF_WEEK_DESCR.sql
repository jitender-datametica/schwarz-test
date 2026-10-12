CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_cal_day_of_week_descr (day_of_week, lang_sid, lang_cd, day_of_week_descr,
dwh_load_id, dwh_created, dwh_updated) AS SELECT day_of_week,
 lang_sid,
 lang_cd,
 day_of_week_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_cal_day_of_week_descr;