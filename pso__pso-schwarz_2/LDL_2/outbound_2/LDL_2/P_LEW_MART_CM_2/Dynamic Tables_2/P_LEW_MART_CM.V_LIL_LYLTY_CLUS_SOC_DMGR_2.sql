CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_lylty_clus_soc_dmgr_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT CAST(LP.lcsd_id AS BIGNUMERIC) AS lcsd_id,
 CAST(COALESCE(DSDE.lcsd_descr, LP.lcsd_desc) AS STRING) AS lcsd_desc,
 CAST(COALESCE(DSEN.lcsd_descr, LP.lcsd_desc) AS STRING) AS lcsd_desc_en,
 CAST(COALESCE(DSDE.lcsd_short_descr, LP.lcsd_short_desc) AS STRING) AS lcsd_short_desc,
 CAST(COALESCE(DSEN.lcsd_short_descr, LP.lcsd_short_desc) AS STRING) AS lcsd_short_desc_en,
 LP.srt_cd AS sort,
 LP.lcsd_group_id AS lcsd_group,
 CAST(COALESCE(DSDE.lcsd_explain, LC.lcsd_explain) AS STRING) AS lcsd_explain,
 CAST(COALESCE(DSEN.lcsd_explain, LC.lcsd_explain) AS STRING) AS lcsd_explain_en
FROM ldl_p_lew_process_mstr_ac.v_lil_lylty_clus_soc_dmgr_2 AS LP
 INNER JOIN ldl_p_lew_core_ac.v_ref_lil_lcsd_2 AS LC ON LP.lcsd_id = LC.lcsd_id
 LEFT JOIN ldl_p_lew_core_ac.v_ref_lil_lcsd_descr_2 AS DSDE ON LC.lcsd_id = DSDE.lcsd_id AND DSDE.lang_cd = 'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_ref_lil_lcsd_descr_2 AS DSEN ON LC.lcsd_id = DSEN.lcsd_id AND DSEN.lang_cd = 'EN';