CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_max_gj_2 AS SELECT gj,
 akt_gj,
 MAX(dat) AS dat_termin_gj
FROM kfl_production_dbp_msi_view_ios.mv_tag_2
GROUP BY gj,
 akt_gj;