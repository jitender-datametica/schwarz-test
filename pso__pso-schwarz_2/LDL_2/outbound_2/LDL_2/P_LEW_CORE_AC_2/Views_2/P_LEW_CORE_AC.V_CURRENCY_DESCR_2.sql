CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_currency_descr_2 (client_id, curr_sid, lang_sid, curr_cd, lang_cd,
curr_descr_short, curr_descr_long, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 curr_sid,
 lang_sid,
 curr_cd,
 lang_cd,
 curr_descr_short,
 curr_descr_long,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_currency_descr_2;