CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lagersortiment AS SELECT mandant_id,
 lagernummer_id,
 lagersortiment_id,
 wup_id,
 nb_id
FROM kfl_production_dbp_view.v_l_lagersortiment AS V0
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND wup_id > 0
GROUP BY mandant_id,
 lagernummer_id,
 lagersortiment_id,
 wup_id,
 nb_id
UNION ALL
SELECT mandant_id,
 lagernummer_id,
  CASE
  WHEN CAST(lagersortiment_id AS FLOAT64) = 1
  THEN '0'
  WHEN CAST(lagersortiment_id AS FLOAT64) = 2
  THEN '9'
  ELSE NULL
  END AS lagersortiment_id,
 wup_id,
 nb_id
FROM kfl_production_dbp_view.v_l_lagersortiment AS V0
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND lagersortiment_id IN ('1', '2')
 AND wup_id > 0
GROUP BY mandant_id,
 lagernummer_id,
 V0.lagersortiment_id,
 wup_id,
 nb_id;