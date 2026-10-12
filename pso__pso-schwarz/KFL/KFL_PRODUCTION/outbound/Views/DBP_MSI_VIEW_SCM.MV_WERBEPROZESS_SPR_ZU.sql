CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_werbeprozess_spr_zu (werbeprozess_id, werbeprozess_bez) AS
SELECT *
FROM (SELECT 1 AS werbeprozess_id,
    'WBS TP1' AS werbeprozess_bez
   UNION ALL
   SELECT 2 AS werbeprozess_id,
    'WBS TP2' AS werbeprozess_bez
   UNION ALL
   SELECT 3 AS werbeprozess_id,
    'WBS TP1+TP2' AS werbeprozess_bez
   UNION ALL
   SELECT 4 AS werbeprozess_id,
    'F&R' AS werbeprozess_bez
   UNION ALL
   SELECT 0 AS werbeprozess_id,
    'N/A' AS werbeprozess_bez)
UNION DISTINCT
SELECT - 1 AS werbeprozess_id,
 'N/A' AS werbeprozess_bez;