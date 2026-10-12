CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_item_familygroup_descr_1 (client_id, item_fam_grp_sid,
lang_sid, lang_cd, item_fam_grp_descr, item_fam_grp_descr_long, item_fam_grp_descr_caps, dwh_load_id, dwh_created,
dwh_updated) AS SELECT client_id,
 item_fam_grp_sid,
 lang_sid,
 lang_cd,
 item_fam_grp_descr,
 item_fam_grp_descr_long,
 item_fam_grp_descr_caps,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_familygroup_descr_1;