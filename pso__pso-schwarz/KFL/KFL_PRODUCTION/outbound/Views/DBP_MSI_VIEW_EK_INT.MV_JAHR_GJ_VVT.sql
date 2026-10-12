CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_jahr_gj_vvt AS SELECT gj,
 akt_gj,
 akt_gj_komplett
FROM kfl_production_dbp_msi_view_ek_int.mv_tag
GROUP BY gj,
 akt_gj,
 akt_gj_komplett;