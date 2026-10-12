CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_einh_2 (einh_id, mandant_id) AS SELECT einh_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_einh_2
UNION ALL
SELECT DISTINCT ' ' AS einh_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_einh_2;