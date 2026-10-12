CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_it_projekt_bereich AS SELECT mandant_id,
 it_projekt_bereich_id,
 it_projekt_bereich_bez,
 sparte_id
FROM kfl_production_dbp_data.l_it_projekt_bereich;