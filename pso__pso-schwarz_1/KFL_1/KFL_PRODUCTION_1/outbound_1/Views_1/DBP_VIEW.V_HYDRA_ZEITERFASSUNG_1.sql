CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hydra_zeiterfassung_1 AS SELECT mandant_id,
 pers_teilbereich_id,
 dat,
 dauer,
 abrechnung_fg
FROM kfl_production_dbp_data.hydra_zeiterfassung_1;