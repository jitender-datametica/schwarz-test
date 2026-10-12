CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_fehlartikel_kz AS SELECT CASE
  WHEN dat = CURRENT_DATE
  THEN 0
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
  THEN 1
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY)
  THEN 2
  ELSE NULL
  END AS fehlartikel_kz,
  CASE
  WHEN dat = CURRENT_DATE
  THEN 'nicht relevant'
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
  THEN 'relevant und kein Fehlartikel'
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY)
  THEN 'relevant und Fehlartikel'
  ELSE NULL
  END AS fehlartikel_bez
FROM kfl_production_dbp_view.v_tag
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE);