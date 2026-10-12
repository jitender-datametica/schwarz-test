CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_familygroup_modularization (client_id, item_fam_grp_sid,
buying_list_type_id, active_from_dt, active_to_dt, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created,
dwh_updated) AS SELECT client_id,
 item_fam_grp_sid,
 buying_list_type_id,
 active_from_dt,
 active_to_dt,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_familygroup_modularization;