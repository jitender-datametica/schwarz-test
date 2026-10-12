CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cos_bonuspunkte_1 AS SELECT crm_konto_id,
 dat_verfall_bonuspunkte,
 mandant_id,
 anz_bonuspunkte,
 datzeit_update
FROM kfl_production_dbp_data.cos_bonuspunkte_1;