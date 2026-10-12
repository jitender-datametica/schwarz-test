CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wug_restlaufzeit_kunde_zu_1 AS SELECT mandant_id,
 einstellung_objekt,
 einstellung_schema,
 arthiertyp_id,
 wg_id,
 wug_id,
 mhd_zeitraum_ab,
 restlaufzeit_ist,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wug_restlaufzeit_kunde_zu_1;