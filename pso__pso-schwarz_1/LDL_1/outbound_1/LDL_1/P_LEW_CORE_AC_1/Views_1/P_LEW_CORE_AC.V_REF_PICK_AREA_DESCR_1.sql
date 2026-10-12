CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_pick_area_descr_1 (client_id, loc_sid, lang_sid, lang_cd, pick_area_id,
pick_area_descr, pick_main_area_id, pick_main_area_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 loc_sid,
 lang_sid,
 lang_cd,
 pick_area_id,
 pick_area_descr,
 pick_main_area_id,
 pick_main_area_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_pick_area_descr_1;