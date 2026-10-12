CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_gl_region (client_id, gl_region_id, gl_region_desc, gl_last_name,
gl_first_name, load_id) AS SELECT client_id,
 gl_region_id,
 gl_region_desc,
 gl_last_name,
 gl_first_name,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_gl_region;