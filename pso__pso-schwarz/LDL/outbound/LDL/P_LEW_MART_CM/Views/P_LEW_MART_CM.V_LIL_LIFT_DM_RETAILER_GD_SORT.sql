CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_lift_dm_retailer_gd_sort (client_id, rtl_grp_id, rtl_grp_desc,
rtl_grp_desc_en, rtl_grp_tp, clnt_rtl_grp_sort, prot_fg) AS SELECT CAST(client_id AS BIGNUMERIC) AS client_id,
 rtl_id AS rtl_grp_id,
 CAST(rtl_desc AS STRING) AS rtl_grp_desc,
 CAST(rtl_desc_en AS STRING) AS rtl_grp_desc0,
 rtl_tp_id AS rtl_grp_tp,
 clnt_rtl_srt_cd AS clnt_rtl_grp_sort,
 0 AS prot_fg
FROM ldl_p_lew_process_mstr_ac.v_lil_lift_dm_retailer_gd_sort;