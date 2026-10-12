CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_l_ebene_3_1 AS SELECT ebene_3_id,
 MAX(number_level_3) AS number_level_3,
 MAX(ebene_2_id) AS ebene_2_id
FROM kfl_production_dbp_view.v_crm_l_themenbaum_lv2_1
GROUP BY ebene_3_id;