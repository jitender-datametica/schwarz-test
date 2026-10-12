CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_lylty_clus_soc_dmgr_grp_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT CAST(LCSD.lcsd_group_id AS BIGNUMERIC) AS lcsd_group_id,
 CAST(COALESCE(TRDE.trans_text, LCSD.lcsd_group_desc) AS STRING) AS lcsd_group_desc,
 CAST(COALESCE(TREN.trans_text, LCSD.lcsd_group_desc) AS STRING) AS lcsd_group_desc_en
FROM ldl_p_lew_process_mstr_ac.v_lil_lylty_clus_soc_dmgr_grp_1 AS LCSD
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_1 AS TRDE ON TRDE.context = 'LCSD_GROUP_DESC' AND LCSD.lcsd_group_id
      = TRDE.trans_id AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_1 AS TREN ON TREN.context = 'LCSD_GROUP_DESC' AND LCSD.lcsd_group_id
      = TREN.trans_id AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1;
