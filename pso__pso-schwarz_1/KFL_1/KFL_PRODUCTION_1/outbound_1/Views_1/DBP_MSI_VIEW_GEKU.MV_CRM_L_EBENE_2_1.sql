CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_l_ebene_2_1 AS SELECT ebene_2_id,
 MAX(number_level_2) AS number_level_2,
 MAX(ebene_1_id) AS ebene_1_id
FROM kfl_production_dbp_view.v_crm_l_themenbaum_lv2_1
GROUP BY ebene_2_id;