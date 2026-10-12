CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_jahr_kj_1 (kj, akt_kj, akt_kj_komplett, kj_kurz) AS SELECT kj,
 akt_kj,
 akt_kj_komplett,
 SUBSTR(SUBSTR(CAST(kj AS STRING), 1, 4), 3, 2) AS kj_kurz
FROM kfl_production_dbp_view.v_jahr_kj_1 AS v01;