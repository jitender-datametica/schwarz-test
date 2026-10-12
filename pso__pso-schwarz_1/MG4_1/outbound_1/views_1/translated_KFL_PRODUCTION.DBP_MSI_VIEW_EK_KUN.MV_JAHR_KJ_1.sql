CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_jahr_kj_1 (kj, akt_kj, akt_kj_komplett) AS SELECT kj,
 akt_kj,
 akt_kj_komplett
FROM kfl_production_dbp_view.v_jahr_kj_1 AS v01;