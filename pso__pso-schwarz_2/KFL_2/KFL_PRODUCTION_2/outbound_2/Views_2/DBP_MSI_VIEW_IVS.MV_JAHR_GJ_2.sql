CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_jahr_gj_2 AS SELECT gj,
 akt_gj,
 akt_gj_komplett
FROM kfl_production_dbp_view.v_jahr_gj_2
WHERE akt_gj BETWEEN - 5 AND 1;