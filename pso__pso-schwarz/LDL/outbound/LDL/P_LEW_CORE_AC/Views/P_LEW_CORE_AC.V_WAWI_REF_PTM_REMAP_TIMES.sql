CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_ptm_remap_times (country_iso_cd, client_id, wh_loc_sid,
workingtype_id, source_ptm_table, target_ptm_table, load_id) AS SELECT country_iso_cd,
 client_id,
 wh_loc_sid,
 workingtype_id,
 source_ptm_table,
 target_ptm_table,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_ptm_remap_times;