CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_item_type_ignore_1 (client_id, item_type_sid, item_type_cd, item_type_grp_cd
) AS SELECT client_id,
 item_type_sid,
 item_type_cd,
 item_type_grp_cd
FROM ldl_p_lew_process.t_item_type_ignore_1;