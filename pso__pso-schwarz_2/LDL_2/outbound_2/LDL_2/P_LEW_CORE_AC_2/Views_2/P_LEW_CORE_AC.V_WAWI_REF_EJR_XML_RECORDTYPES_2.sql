CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_ejr_xml_recordtypes_2 (recordtype_id, interface_desc, comment_string,
dat_lastedit, user_lastedit, load_id) AS SELECT recordtype_id,
 interface_desc,
 comment_string,
 dat_lastedit,
 user_lastedit,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_ejr_xml_recordtypes_2;