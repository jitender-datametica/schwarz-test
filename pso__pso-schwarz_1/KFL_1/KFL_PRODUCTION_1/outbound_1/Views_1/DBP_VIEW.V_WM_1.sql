CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wm_1 AS SELECT wm_id,
 mandant_id,
 wm_name,
 td_insert,
 td_update
FROM kfl_production_dbp_data.wm_1;