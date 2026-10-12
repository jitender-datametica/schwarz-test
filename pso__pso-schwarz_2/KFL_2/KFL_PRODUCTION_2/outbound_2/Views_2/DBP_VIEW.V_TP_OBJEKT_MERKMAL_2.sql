CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tp_objekt_merkmal_2 AS SELECT mandant_id,
 tp_merkmal_id,
 tp_objekt_id,
 dat_von,
 tp_merkmal_klasse_id,
 tp_merkmalwert
FROM kfl_production_dbp_data.tp_objekt_merkmal_2;