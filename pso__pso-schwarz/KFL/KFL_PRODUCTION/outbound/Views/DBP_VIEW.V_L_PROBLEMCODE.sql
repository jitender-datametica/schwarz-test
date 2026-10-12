CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_problemcode AS SELECT system_id,
 mandant_id,
 problemcode_id,
 problemklasse_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_problemcode;