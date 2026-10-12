CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_subitemgroup_descr_1 (client_id, sub_item_grp_sid,
lang_sid, lang_cd, sub_item_grp_descr, sub_item_grp_descr_long, sub_item_grp_descr_caps, dwh_load_id, dwh_created,
dwh_updated) AS SELECT client_id,
 sub_item_grp_sid,
 lang_sid,
 lang_cd,
 sub_item_grp_descr,
 sub_item_grp_descr_long,
 sub_item_grp_descr_caps,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_subitemgroup_descr_1;