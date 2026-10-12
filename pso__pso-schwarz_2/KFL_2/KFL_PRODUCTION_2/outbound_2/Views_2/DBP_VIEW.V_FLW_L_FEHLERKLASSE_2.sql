CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_l_fehlerklasse_2 AS SELECT mandant_id,
 fehlerklasse_id,
 system_id,
 fehlerklasse_kennzahl,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_l_fehlerklasse_2;