CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_soll_haben_kz AS SELECT CASE
  WHEN dat = CURRENT_DATE
  THEN 'S'
  ELSE 'H'
  END AS soll_haben_kz
FROM kfl_production_dbp_view.v_tag
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) AND (CURRENT_DATE);