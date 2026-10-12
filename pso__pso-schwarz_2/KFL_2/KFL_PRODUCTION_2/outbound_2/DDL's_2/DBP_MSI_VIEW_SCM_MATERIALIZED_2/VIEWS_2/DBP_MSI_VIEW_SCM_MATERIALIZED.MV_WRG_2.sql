CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_wrg_2 (wrg_id, wrg_bez, td_update, td_insert) AS
SELECT *
FROM kfl_production_dbp_view.v_wrg_2;