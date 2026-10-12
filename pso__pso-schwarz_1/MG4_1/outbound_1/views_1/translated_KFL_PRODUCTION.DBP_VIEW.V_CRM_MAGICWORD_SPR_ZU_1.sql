CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_magicword_spr_zu_1 (crm_magicword_id, mandant_id, spr_id,
crm_magicword_bez) AS SELECT crm_magicword_id,
 mandant_id,
 spr_id,
 crm_magicword_bez
FROM kfl_production_dbp_data.crm_magicword_spr_zu_1;