CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_tankst_eigen_spr_zu_2 AS SELECT CASE
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY)
  THEN 1
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
  THEN 0
  ELSE - 1
  END AS tankstelle_eigen_fg,
  CASE
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY)
  THEN 'Eigen'
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
  THEN 'Fremd'
  ELSE ''
  END AS tankstelle_eigen_bez
FROM kfl_production_dbp_view.v_tag_2
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE);