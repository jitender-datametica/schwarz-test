CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_tms_tourart (tourart_id, tourart_bez) AS SELECT 1 AS
 tourart_id,
 'Filialbelieferung' AS tourart_bez
UNION ALL
SELECT 2 AS tourart_id,
 'Shuttle' AS tourart_bez
UNION ALL
SELECT 3 AS tourart_id,
 'Hofverkehr' AS tourart_bez
UNION ALL
SELECT 4 AS tourart_id,
 'Industrieabholung' AS tourart_bez
UNION ALL
SELECT 5 AS tourart_id,
 'Zusatztour' AS tourart_bez
UNION ALL
SELECT 6 AS tourart_id,
 'Fleischwerktour' AS tourart_bez
UNION ALL
SELECT 7 AS tourart_id,
 'Int. Transport' AS tourart_bez;