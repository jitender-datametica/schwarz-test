CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bestellart_wg_vorlauf_per_2 AS SELECT mandant_id,
 wg_id,
 arthiertyp_id,
 bestellart_id,
 dat_von,
 dat_bis,
 tage_vorlauf
FROM kfl_production_dbp_data.bestellart_wg_vorlauf_per_2;