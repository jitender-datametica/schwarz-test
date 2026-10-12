CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_hydra_zeiterfassung_2 (mandant_id, pers_teilbereich_id, dat,
dauer, abrechnung_fg) AS SELECT mandant_id,
 pers_teilbereich_id,
 dat,
 dauer,
 abrechnung_fg
FROM kfl_production_dbp_view.v_hydra_zeiterfassung_2;