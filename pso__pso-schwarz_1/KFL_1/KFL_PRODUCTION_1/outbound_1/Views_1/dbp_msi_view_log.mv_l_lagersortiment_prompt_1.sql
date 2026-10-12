CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lagersortiment_prompt_1 AS SELECT lagersortiment_id
FROM kfl_production_dbp_view.v_l_lagersortiment_1 AS V0
GROUP BY lagersortiment_id
UNION ALL
SELECT CASE
  WHEN CAST(lagersortiment_id AS FLOAT64) = 1
  THEN '0'
  WHEN CAST(lagersortiment_id AS FLOAT64) = 2
  THEN '9'
  ELSE NULL
  END AS lagersortiment_id
FROM kfl_production_dbp_view.v_l_lagersortiment_1 AS V0
WHERE CAST(lagersortiment_id AS INTEGER) IN (1, 2)
GROUP BY V0.lagersortiment_id;