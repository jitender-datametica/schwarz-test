CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hydra_taetigkeit_zu_2 AS SELECT mandant_id,
 pers_teilbereich_id,
 taetigkeit_id,
 taetigkeit_bez,
 taetigkeit_typ_id,
 taetigkeit_int_id
FROM kfl_production_dbp_data.hydra_taetigkeit_zu_2;