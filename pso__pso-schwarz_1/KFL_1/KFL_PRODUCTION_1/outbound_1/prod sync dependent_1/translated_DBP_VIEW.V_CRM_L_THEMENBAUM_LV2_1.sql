CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_l_themenbaum_lv2_1 (crm_themenbaum_lv2_id, crm_themenbaum_lv1_id,
ebene_1_id, ebene_2_id, ebene_3_id, number_level_1, number_level_2, number_level_3, td_update, td_insert) AS SELECT
 crm_themenbaum_lv2_id,
 crm_themenbaum_lv1_id,
 ebene_1_id,
 ebene_2_id,
 ebene_3_id,
 number_level_1,
 number_level_2,
 number_level_3,
 td_update,
 td_insert
FROM kfl_production_dbp_data.crm_l_themenbaum_lv2_1;