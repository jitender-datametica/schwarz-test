CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_ebene_2 (ebene_2_id, number_level_2, ebene_1_id) AS
SELECT ebene_2_id,
 MAX(number_level_2) AS number_level_2,
 MAX(ebene_1_id) AS ebene_1_id
FROM kfl_production_dbp_data.crm_l_themenbaum_lv2
GROUP BY ebene_2_id;