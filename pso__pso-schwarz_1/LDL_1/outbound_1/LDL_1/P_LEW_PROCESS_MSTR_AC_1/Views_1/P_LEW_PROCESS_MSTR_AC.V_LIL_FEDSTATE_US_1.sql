CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_fedstate_us_1 (client_id, region_sid, fedstate_cd, valid_from,
valid_to, active_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 region_sid,
 fedstate_cd,
 valid_from,
 valid_to,
 active_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_fedstate_us_1;