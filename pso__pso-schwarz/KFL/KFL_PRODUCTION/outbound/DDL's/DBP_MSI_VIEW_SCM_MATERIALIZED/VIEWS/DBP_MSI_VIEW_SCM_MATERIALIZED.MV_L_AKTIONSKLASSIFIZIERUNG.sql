-- 20230123, AP0153906,dknop, initial
 -- 20231120, AP0153906, adding AKTIONSKLASSIFIZIERUNG_ID=9

-- 20230824, AP0153906, adding AKTIONSKLASSIFIZIERUNG_ID=4

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_l_aktionsklassifizierung (aktionsklassifizierung_id
, aktionsklassifizierung_bez) AS SELECT 1 AS aktionsklassifizierung_id,
 'Standard' AS aktionsklassifizierung_bez
UNION ALL
SELECT 2 AS aktionsklassifizierung_id,
 'Standard + K-Card' AS aktionsklassifizierung_bez
UNION ALL
SELECT 3 AS aktionsklassifizierung_id,
 'K-Card Only' AS aktionsklassifizierung_bez
UNION ALL
SELECT 4 AS aktionsklassifizierung_id,
 'Bonuskauf (BBY)' AS aktionsklassifizierung_bez;