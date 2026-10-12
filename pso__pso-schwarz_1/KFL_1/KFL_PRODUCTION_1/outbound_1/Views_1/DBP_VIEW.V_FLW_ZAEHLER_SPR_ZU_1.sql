CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_zaehler_spr_zu_1 AS SELECT mandant_id,
 zaehler_id,
 spr_id,
 system_id,
 zaehler_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_zaehler_spr_zu_1;