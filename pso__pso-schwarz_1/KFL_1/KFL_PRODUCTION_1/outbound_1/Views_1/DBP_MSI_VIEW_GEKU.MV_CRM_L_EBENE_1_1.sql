CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_l_ebene_1_1 AS SELECT ebene_1_id,
 MAX(number_level_1) AS number_level_1
FROM kfl_production_dbp_view.v_crm_l_themenbaum_lv2_1
GROUP BY ebene_1_id;