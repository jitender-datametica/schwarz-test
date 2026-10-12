CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_ebene_1 (ebene_1_id, number_level_1) AS SELECT
 ebene_1_id,
 MAX(number_level_1) AS number_level_1
FROM kfl_production_dbp_data.crm_l_themenbaum_lv2
GROUP BY ebene_1_id;