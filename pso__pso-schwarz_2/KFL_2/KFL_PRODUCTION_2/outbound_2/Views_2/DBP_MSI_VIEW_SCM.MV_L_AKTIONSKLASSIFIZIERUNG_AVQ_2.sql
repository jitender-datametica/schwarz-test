CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_aktionsklassifizierung_avq_2 (aktionsklassifizierung_id,
aktionsklassifizierung_bez) AS SELECT *
FROM (SELECT 1 AS aktionsklassifizierung_id,
    'Standard' AS aktionsklassifizierung_bez
   UNION ALL
   SELECT 2 AS aktionsklassifizierung_id,
    'Standard + K-Card' AS aktionsklassifizierung_bez
   UNION ALL
   SELECT 3 AS aktionsklassifizierung_id,
    'K-Card Only (KDN)' AS aktionsklassifizierung_bez
   UNION ALL
   SELECT 4 AS aktionsklassifizierung_id,
    'K-Card Only (KDP)' AS aktionsklassifizierung_bez
   UNION ALL
   SELECT 5 AS aktionsklassifizierung_id,
    'BBY' AS aktionsklassifizierung_bez
   UNION ALL
   SELECT 6 AS aktionsklassifizierung_id,
    'Standard + BBY' AS aktionsklassifizierung_bez
   UNION ALL
   SELECT 7 AS aktionsklassifizierung_id,
    'BBY + K-Card' AS aktionsklassifizierung_bez)
UNION DISTINCT
SELECT - 1 AS aktionsklassifizierung_id,
 'N/A' AS aktionsklassifizierung_bez;