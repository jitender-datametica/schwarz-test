CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_interface_1 (system_key, interface_key, process_name, comment_string,
dat_lastedit, user_lastedit, load_id) AS SELECT system_key,
 interface_key,
 process_name,
 comment_string,
 dat_lastedit,
 user_lastedit,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_interface_1;