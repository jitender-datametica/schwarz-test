CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_hydra_taetigkeit_tag (mandant_id, pers_teilbereich_id, dat,
taetigkeit_id, kostenstelle_id, dauer, abrechnung_fg) AS SELECT mandant_id,
 pers_teilbereich_id,
 dat,
 taetigkeit_id,
 COALESCE(CASE
   WHEN kostenstelle_id = ''
   THEN NULL
   ELSE kostenstelle_id
   END, '0') AS kostenstelle_id,
 dauer,
 abrechnung_fg
FROM kfl_production_dbp_view.v_hydra_taetigkeit_tag;