-- 2024-04-22, AP0179753, dknop, initial
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_l_einh
(einh_id, mandant_id) AS SELECT einh_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_einh
UNION ALL
SELECT DISTINCT ' ' AS einh_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_einh;