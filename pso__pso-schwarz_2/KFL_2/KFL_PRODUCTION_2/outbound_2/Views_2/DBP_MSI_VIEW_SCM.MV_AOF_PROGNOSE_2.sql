CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_aof_prognose_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 zeitreihenart,
 dat_prognoselauf,
 dat,
 menge AS menge_prognose
FROM kfl_production_dbp_view.v_aof_prognose_2 AS V01;