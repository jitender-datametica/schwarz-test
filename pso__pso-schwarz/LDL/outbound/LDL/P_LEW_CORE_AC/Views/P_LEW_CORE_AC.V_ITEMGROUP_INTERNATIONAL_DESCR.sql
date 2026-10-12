CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_itemgroup_international_descr (client_id, item_grp_int_sid, lang_sid, lang_cd
, item_grp_int_descr, item_grp_int_descr_long, item_grp_int_descr_caps, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 item_grp_int_sid,
 lang_sid,
 lang_cd,
 item_grp_int_descr,
 item_grp_int_descr_long,
 item_grp_int_descr_caps,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_itemgroup_international_descr;