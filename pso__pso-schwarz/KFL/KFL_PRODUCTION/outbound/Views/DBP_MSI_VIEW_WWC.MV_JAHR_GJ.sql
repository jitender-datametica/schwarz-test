CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_jahr_gj (gj, akt_gj, akt_gj_komplett) AS SELECT gj,
 akt_gj,
 akt_gj_komplett
FROM kfl_production_dbp_view.v_jahr_gj
WHERE akt_gj BETWEEN - 2 AND 4;