CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_protection_1 (prot_fg, description, dwh_load_id, dwh_created,
dwh_updated) AS SELECT prot_fg,
 description,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_protection_1;