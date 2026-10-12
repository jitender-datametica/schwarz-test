-- 15.06.2023 snik: SPEC0200542 Lookup GJ
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_jahr_gj_1 (gj, akt_gj,
akt_gj_komplett) AS SELECT gj,
 akt_gj,
 akt_gj_komplett
FROM kfl_production_dbp_view.v_jahr_gj_1 AS v01
WHERE gj >= 2023;