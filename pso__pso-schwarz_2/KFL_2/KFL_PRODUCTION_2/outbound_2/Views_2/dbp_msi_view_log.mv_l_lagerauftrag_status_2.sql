CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lagerauftrag_status_2 AS SELECT V01.mandant_id,
 V01.lagernummer_id,
  CASE
  WHEN V02.akt_tag = - 4
  THEN ' '
  WHEN V02.akt_tag = - 3
  THEN 'A'
  WHEN V02.akt_tag = - 2
  THEN 'B'
  WHEN V02.akt_tag = - 1
  THEN 'C'
  WHEN V02.akt_tag = 0
  THEN 'D'
  ELSE NULL
  END AS lagerauftrag_status_id
FROM kfl_production_dbp_view.v_l_lagernummer_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V02 ON V02.akt_tag BETWEEN - 4 AND 0
WHERE LEFT(V01.lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND LENGTH(TRIM(V01.lagernummer_id)) = 4;