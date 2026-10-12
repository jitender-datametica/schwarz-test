CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_einheiten_umrechnung_2 AS SELECT einh_id,
 dimension_id,
 zaehler,
 nenner,
 basis_einh_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_einheiten_umrechnung_2;