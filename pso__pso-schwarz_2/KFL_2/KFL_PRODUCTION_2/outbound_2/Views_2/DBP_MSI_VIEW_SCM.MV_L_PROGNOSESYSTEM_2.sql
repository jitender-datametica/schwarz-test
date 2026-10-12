CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_prognosesystem_2 AS SELECT prognose_system
FROM (SELECT 'UDF' AS prognose_system
   UNION ALL
   SELECT 'FUR' AS prognose_system);