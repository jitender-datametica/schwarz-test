CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_wh_type_1 (wh_type_id, comment_string, dat_lastedit, user_lastedit,
load_id) AS SELECT wh_type_id,
 comment_string,
 dat_lastedit,
 user_lastedit,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_wh_type_1;