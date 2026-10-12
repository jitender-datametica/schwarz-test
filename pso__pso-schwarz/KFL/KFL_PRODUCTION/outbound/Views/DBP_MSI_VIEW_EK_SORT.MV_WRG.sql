CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_wrg (wrg_id, wrg_bez) AS SELECT wrg_id,
 wrg_bez
FROM kfl_production_dbp_view.v_wrg AS V01;