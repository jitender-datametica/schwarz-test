CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_transportsortiment_prompt_1 AS ((SELECT mandant_id,
   CAST(lagersortiment_id AS STRING) AS transportsortiment_id
  FROM kfl_production_dbp_view.v_l_lagersortiment_1 AS V0
  WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
   AND lagersortiment_id NOT IN ('2', '5', '7')
  GROUP BY mandant_id,
   lagersortiment_id
  UNION DISTINCT
  SELECT mandant_id,
   '27' AS transportsortiment_id
  FROM kfl_production_dbp_view.v_l_lagersortiment_1 AS V0
  WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
   AND lagersortiment_id = '2'
  GROUP BY mandant_id)
 UNION DISTINCT
 SELECT mandant_id,
  '-1' AS transportsortiment_id
 FROM kfl_production_dbp_view.v_l_lagersortiment_1 AS V0
 WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
  AND lagersortiment_id = '2'
 GROUP BY mandant_id)
UNION DISTINCT
SELECT mandant_id,
 '99' AS transportsortiment_id
FROM kfl_production_dbp_view.v_l_lagersortiment_1 AS V0
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND lagersortiment_id = '2'
GROUP BY mandant_id;