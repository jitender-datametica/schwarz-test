CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_jahr_kj (kj, akt_kj, akt_kj_komplett) AS SELECT kj,
 akt_kj,
 akt_kj_komplett
FROM kfl_production_dbp_view.v_jahr_kj;