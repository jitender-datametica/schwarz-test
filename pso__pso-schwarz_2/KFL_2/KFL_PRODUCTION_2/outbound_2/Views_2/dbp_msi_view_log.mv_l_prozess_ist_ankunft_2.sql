CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_prozess_ist_ankunft_2 (plombe_prozess_id, plombe_prozess_bez)
AS SELECT *
FROM (SELECT 1 AS plombe_prozess_id,
    'Plombe' AS plombe_prozess_bez
   UNION ALL
   SELECT 2 AS plombe_prozess_id,
    'WE_Palette' AS plombe_prozess_bez)
UNION DISTINCT
SELECT - 1 AS plombe_prozess_id,
 '' AS plombe_prozess_bez;