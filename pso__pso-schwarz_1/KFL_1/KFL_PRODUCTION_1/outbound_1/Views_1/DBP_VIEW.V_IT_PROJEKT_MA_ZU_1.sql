CREATE OR REPLACE VIEW kfl_production_dbp_view.v_it_projekt_ma_zu_1 AS SELECT it_projekt_id,
 mandant_id,
 ma_id,
 ma_funktion_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.it_projekt_ma_zu_1;