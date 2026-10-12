CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_energiedaten_2 AS SELECT mandant_id,
 zaehler_id,
 dat,
 pc_id,
 krk_id,
 kjmo,
 menge_verbrauch,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_energiedaten_2;