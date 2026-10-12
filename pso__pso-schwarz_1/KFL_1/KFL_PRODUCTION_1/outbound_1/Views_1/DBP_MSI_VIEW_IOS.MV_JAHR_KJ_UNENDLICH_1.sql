CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_jahr_kj_unendlich_1 (kj, akt_kj) AS SELECT kj,
 akt_kj
FROM kfl_production_dbp_view.v_jahr_kj_1
WHERE akt_kj > - 3
UNION ALL
SELECT DISTINCT 9999 AS kj,
 9999 AS akt_kj
FROM kfl_production_dbp_view.v_jahr_kj_1;