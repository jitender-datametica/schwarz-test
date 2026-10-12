CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_subsystem_2 (system_key, system_desc, dat_lastedit, user_lastedit,
load_id) AS SELECT system_key,
 system_desc,
 dat_lastedit,
 user_lastedit,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_subsystem_2;