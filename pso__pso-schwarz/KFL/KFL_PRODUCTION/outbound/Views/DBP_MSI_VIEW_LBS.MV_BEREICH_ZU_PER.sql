CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_bereich_zu_per (ber_id, mandant_id, arthiertyp_id) AS SELECT
 wg_hierarchie_mutter_id AS ber_id,
 mandant_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per AS V01
WHERE arthiertyp_id = 10
 AND wg_hierarchie_ebene_id = 2
 AND CURRENT_DATE BETWEEN dat_von AND dat_bis;