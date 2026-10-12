CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_woche_start_freitag_1 AS SELECT DATE_ADD(dat, INTERVAL 4 DAY) AS
 dat,
 kjwo,
 akt_wo
FROM kfl_production_dbp_view.v_tag_1;