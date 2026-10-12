CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_woche_start_donnerstag (dat, kjwo, akt_wo) AS SELECT DATE_ADD(dat
  ,INTERVAL 3 DAY) AS dat,
 kjwo,
 akt_wo
FROM kfl_production_dbp_view.v_tag;