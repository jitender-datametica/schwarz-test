CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_entfernungsmatrix_update (dat_insert, anz_rec) AS SELECT DATE(td_insert
  ) AS dat_insert,
 COUNT(*) AS anz_rec
FROM kfl_production_dbp_data.wup_entfernungsmatrix
WHERE DATE(td_insert) >= DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
GROUP BY dat_insert;