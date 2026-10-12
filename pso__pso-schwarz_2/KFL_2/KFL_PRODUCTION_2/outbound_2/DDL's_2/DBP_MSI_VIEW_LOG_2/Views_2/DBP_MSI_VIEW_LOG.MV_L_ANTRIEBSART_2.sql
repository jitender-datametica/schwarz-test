-- 2026-02-27, AP0304701, dknop, initial
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_antriebsart_2 (antriebsart_id
, antriebsart_bez) AS (SELECT -1 AS antriebsart_id,
  '' AS antriebsart_bez
 UNION DISTINCT
 (SELECT 0 AS antriebsart_id,
   'keine Zuordnung' AS antriebsart_bez
  UNION DISTINCT
  SELECT 1 AS antriebsart_id,
   'Diesel' AS antriebsart_bez))
UNION DISTINCT
(SELECT 2 AS antriebsart_id,
  'Elektro' AS antriebsart_bez
 UNION DISTINCT
 (SELECT 3 AS antriebsart_id,
   'Gas' AS antriebsart_bez
  UNION DISTINCT
  SELECT 4 AS antriebsart_id,
   'Wasserstoff' AS antriebsart_bez));