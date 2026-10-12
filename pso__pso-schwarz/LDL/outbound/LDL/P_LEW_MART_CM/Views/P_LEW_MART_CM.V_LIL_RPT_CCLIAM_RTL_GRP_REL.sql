CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_rpt_ccliam_rtl_grp_rel (rtl_id, ccliam_rtl_grp_id) AS SELECT rtl_id,
 CAST(ccliam_rtl_grp_id AS BIGNUMERIC) AS ccliam_rtl_grp_id
FROM ldl_p_lew_process_mstr_ac.v_lil_rpt_ccliam_rtl_grp_rel;