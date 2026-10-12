CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_lil_period_descr_2 (client_id, period_sid, lang_cd, period_name, dwh_load_id,
dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core.t_lil_period_descr_2;