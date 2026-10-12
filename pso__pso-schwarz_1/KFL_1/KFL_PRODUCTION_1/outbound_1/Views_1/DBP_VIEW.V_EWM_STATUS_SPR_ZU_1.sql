CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ewm_status_spr_zu_1 AS SELECT status_id,
 spr_id,
 status_schema_id,
 status_kbez,
 status_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ewm_status_spr_zu_1;