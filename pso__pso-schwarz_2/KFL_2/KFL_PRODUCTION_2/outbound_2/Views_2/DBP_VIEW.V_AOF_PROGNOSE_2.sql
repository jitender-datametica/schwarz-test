CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aof_prognose_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 zeitreihenart,
 dat_prognoselauf,
 dat,
 menge
FROM kfl_production_dbp_data.aof_prognose_2;