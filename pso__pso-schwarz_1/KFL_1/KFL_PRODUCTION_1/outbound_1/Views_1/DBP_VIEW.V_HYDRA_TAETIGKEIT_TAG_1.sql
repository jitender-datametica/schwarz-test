CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hydra_taetigkeit_tag_1 AS SELECT mandant_id,
 pers_teilbereich_id,
 dat,
 taetigkeit_id,
 kostenstelle_id,
 dauer,
 abrechnung_fg
FROM kfl_production_dbp_data.hydra_taetigkeit_tag_1;