CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_materialgruppe_db_1 (materialgruppe_db_id,
materialgruppe_db_bez) AS SELECT CASE
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)
  THEN 1
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 3 DAY)
  THEN 2
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY)
  THEN 3
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
  THEN 4
  ELSE 5
  END AS materialgruppe_db_id,
  CASE
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)
  THEN 'Fleisch'
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 3 DAY)
  THEN 'Wurst'
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY)
  THEN 'HAWA'
  WHEN dat = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
  THEN 'Produktion'
  ELSE 'nicht zugeordnet'
  END AS materialgruppe_db_bez
FROM kfl_production_dbp_view.v_tag_1
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY) AND (CURRENT_DATE);