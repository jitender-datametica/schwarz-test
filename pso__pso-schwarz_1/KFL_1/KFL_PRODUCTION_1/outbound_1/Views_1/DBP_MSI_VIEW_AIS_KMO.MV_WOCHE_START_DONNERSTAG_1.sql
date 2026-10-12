CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_woche_start_donnerstag_1 (dat, dat_vj, kjwo, kjwo_vj, akt_wo
) AS SELECT DATE_ADD(dat, INTERVAL 3 DAY) AS dat,
 DATE_ADD(dat_vj, INTERVAL 3 DAY) AS dat_vj,
 kjwo,
 kjwo_vj,
 akt_wo
FROM kfl_production_dbp_view.v_tag_1;