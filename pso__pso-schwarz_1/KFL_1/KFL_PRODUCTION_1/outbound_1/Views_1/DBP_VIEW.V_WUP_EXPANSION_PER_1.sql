CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_expansion_per_1 AS SELECT wup_id,
 nb_id,
 mandant_id,
 dat_von,
 expansionstyp_id,
 filialart_id,
 dat_bis
FROM kfl_production_dbp_data.wup_expansion_per_1;