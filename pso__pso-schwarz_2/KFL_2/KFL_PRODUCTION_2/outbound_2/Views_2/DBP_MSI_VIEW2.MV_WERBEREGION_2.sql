CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_werberegion_2 (wreg_id, wreg_bez) AS SELECT CASE
  WHEN vs_id IN (2, 7)
  THEN 1
  WHEN vs_id IN (1, 3)
  THEN 2
  WHEN vs_id IN (6, 8)
  THEN 3
  ELSE NULL
  END AS wreg_id,
  CASE
  WHEN vs_id IN (2, 7)
  THEN 'Süd'
  WHEN vs_id IN (1, 3)
  THEN 'Ost'
  WHEN vs_id IN (6, 8)
  THEN 'West'
  ELSE NULL
  END AS wreg_bez
FROM kfl_production_dbp_view.v_vs_2 AS V01
WHERE mandant_id = 1
 AND vk_id = 1
GROUP BY wreg_id,
 wreg_bez;