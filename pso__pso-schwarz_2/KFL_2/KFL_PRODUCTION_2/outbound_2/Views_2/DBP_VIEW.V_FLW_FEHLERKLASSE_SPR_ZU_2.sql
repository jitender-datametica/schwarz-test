CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_fehlerklasse_spr_zu_2 AS SELECT mandant_id,
 fehlerklasse_id,
 spr_id,
 fehlerklasse_bez,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_fehlerklasse_spr_zu_2;