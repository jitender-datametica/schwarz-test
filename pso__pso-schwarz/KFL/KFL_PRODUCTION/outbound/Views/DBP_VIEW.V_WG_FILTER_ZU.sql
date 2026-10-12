CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wg_filter_zu AS SELECT mandant_id,
 wg_id,
 arthiertyp_id,
 wg_filter_id,
 wug_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wg_filter_zu;