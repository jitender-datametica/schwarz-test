CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_wrg (wrg_id, wrg_bez, td_update, td_insert) AS SELECT wrg_id,
 wrg_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wrg;