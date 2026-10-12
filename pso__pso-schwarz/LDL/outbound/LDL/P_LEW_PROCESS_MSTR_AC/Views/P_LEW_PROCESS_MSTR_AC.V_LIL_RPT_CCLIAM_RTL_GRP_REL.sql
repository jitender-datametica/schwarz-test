CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_rpt_ccliam_rtl_grp_rel (ccliam_rtl_grp_id, rtl_id, dwh_load_id,
dwh_created, dwh_updated) AS SELECT ccliam_rtl_grp_id,
 rtl_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_rpt_ccliam_rtl_grp_rel;