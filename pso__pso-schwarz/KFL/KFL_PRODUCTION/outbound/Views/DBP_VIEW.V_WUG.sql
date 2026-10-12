CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wug AS SELECT wug_id,
 wg_id,
 arthiertyp_id,
 mandant_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wug;