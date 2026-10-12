CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_objectstatus (objectstatus_id, comment_string, dat_lastedit,
user_lastedit, load_id) AS SELECT objectstatus_id,
 comment_string,
 dat_lastedit,
 user_lastedit,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_objectstatus;