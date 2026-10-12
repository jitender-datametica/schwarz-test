CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_ebene_3_2 (ebene_3_id, number_level_3, ebene_2_id) AS
SELECT ebene_3_id,
 MAX(number_level_3) AS number_level_3,
 MAX(ebene_2_id) AS ebene_2_id
FROM kfl_production_dbp_data.crm_l_themenbaum_lv2_2
GROUP BY ebene_3_id;