CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_kreistyp_gruppe AS SELECT mandant_id,
 kreistyp_gruppe_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.l_kreistyp_gruppe;