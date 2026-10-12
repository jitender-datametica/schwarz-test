CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_objectstatus_desc_1 (objectstatus_id, language_id, objectstatus_desc,
dat_lastedit, user_lastedit, load_id) AS SELECT objectstatus_id,
 language_id,
 objectstatus_desc,
 dat_lastedit,
 user_lastedit,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_objectstatus_desc_1;