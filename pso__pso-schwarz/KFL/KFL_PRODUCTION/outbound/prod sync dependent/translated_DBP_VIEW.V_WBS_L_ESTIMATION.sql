CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wbs_l_estimation (mandant_id, estimation_id, estimation_bez) AS SELECT
 mandant_id,
 estimation_id,
 estimation_bez
FROM kfl_production_dbp_data.wbs_l_estimation;