CREATE OR REPLACE VIEW kfl_production_dbp_view.v_blockbestand_per_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat_von,
 prozess_id,
 dat_bis,
 menge_blockbestand
FROM kfl_production_dbp_data.blockbestand_per_1;