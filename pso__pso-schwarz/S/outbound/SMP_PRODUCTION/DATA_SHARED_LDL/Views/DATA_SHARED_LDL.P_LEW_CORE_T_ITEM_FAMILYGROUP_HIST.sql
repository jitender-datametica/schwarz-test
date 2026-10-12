CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_item_familygroup_hist (client_id, item_fam_grp_sid,
sub_item_grp_sid, sub_item_grp_cd, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 item_fam_grp_sid,
 sub_item_grp_sid,
 sub_item_grp_cd,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_familygroup_hist;