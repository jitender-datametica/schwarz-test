CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_lylty_clus_soc_dmgr (lcsd_id, lcsd_desc, lcsd_desc_en, lcsd_short_desc
, lcsd_short_desc_en, sort, lcsd_group, explanation, explanation_en) AS SELECT lcsd_id,
 lcsd_desc,
 lcsd_desc_en,
 lcsd_short_desc,
 lcsd_short_desc_en,
 sort,
 lcsd_group,
 lcsd_explain,
 lcsd_explain_en
FROM ldl_p_lew_mart_cm.v_lil_lylty_clus_soc_dmgr;
