CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_dyn_dsbrd_act (dsbrd_id, dsbrd_act_fg, dsbrd_desc, app_id, resort_id
, deleted_fg, del_fg, dwh_valid_from, dwh_vld_from, dwh_valid_to, dwh_vld_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT dsbrd_id,
 dsbrd_act_fg,
 dsbrd_desc,
 app_id,
 resort_id,
 deleted_fg,
 deleted_fg AS del_fg,
 dwh_valid_from,
 dwh_valid_from AS dwh_vld_from,
 dwh_valid_to,
 dwh_valid_to AS dwh_vld_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_dyn_dsbrd
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND deleted_fg = 0;