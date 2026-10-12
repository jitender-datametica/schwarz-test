CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_l_zaehler AS SELECT zaehler_id,
 mandant_id,
 system_id,
 zaehlerart,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_l_zaehler;