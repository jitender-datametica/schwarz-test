CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_status (geku_status_id, td_update, td_insert) AS SELECT
 geku_status_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geku_status;