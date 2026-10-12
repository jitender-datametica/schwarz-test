CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_hydra_taetigkeit_int_1 (taetigkeit_int_id, taetigkeit_int_bez
) AS SELECT taetigkeit_int_id,
 taetigkeit_int_bez
FROM kfl_production_dbp_view.v_l_hydra_taetigkeit_int_1
GROUP BY taetigkeit_int_id,
 taetigkeit_int_bez
UNION DISTINCT
SELECT - 1,
 'N/A';