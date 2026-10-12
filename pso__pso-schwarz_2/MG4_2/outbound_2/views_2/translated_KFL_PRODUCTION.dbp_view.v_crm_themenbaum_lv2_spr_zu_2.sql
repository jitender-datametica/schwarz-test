CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_themenbaum_lv2_spr_zu_2 (crm_themenbaum_lv2_id, spr_id, ebene_1_id,
ebene_2_id, ebene_3_id, ebene_1_bez, ebene_2_bez, ebene_3_bez) AS SELECT crm_themenbaum_lv2_id,
 spr_id,
 ebene_1_id,
 ebene_2_id,
 ebene_3_id,
 ebene_1_bez,
 ebene_2_bez,
 ebene_3_bez
FROM kfl_production_dbp_data.crm_themenbaum_lv2_spr_zu_2;