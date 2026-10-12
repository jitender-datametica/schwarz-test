CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_woche_start_sonntag (dat, dat_vj, kjwo, kjwo_vj, akt_wo)
AS SELECT DATE_ADD(dat, INTERVAL 6 DAY) AS dat,
 DATE_ADD(dat_vj, INTERVAL 6 DAY) AS dat_vj,
 kjwo,
 kjwo_vj,
 akt_wo
FROM kfl_production_dbp_view.v_tag;