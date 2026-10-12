CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_jahr_kj_1 (kj, akt_kj, akt_kj_komplett) AS SELECT kj,
 akt_kj,
 akt_kj_komplett
FROM kfl_production_dbp_view.v_jahr_kj_1
WHERE kj > 2003;