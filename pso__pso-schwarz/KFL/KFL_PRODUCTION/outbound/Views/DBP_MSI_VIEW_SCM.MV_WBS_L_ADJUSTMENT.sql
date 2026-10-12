CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbs_l_adjustment (adjustment_id, adjustment_bez) AS SELECT
 adjustment_id,
 adjustment_bez
FROM kfl_production_dbp_view.v_wbs_l_adjustment
GROUP BY adjustment_id,
 adjustment_bez;