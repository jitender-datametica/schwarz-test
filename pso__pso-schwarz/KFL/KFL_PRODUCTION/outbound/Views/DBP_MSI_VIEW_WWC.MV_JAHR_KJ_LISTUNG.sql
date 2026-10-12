CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_jahr_kj_listung (kj, akt_kj) AS SELECT kj,
 akt_kj
FROM kfl_production_dbp_view.v_jahr_kj
WHERE akt_kj > - 3
UNION ALL
SELECT DISTINCT 9999 AS kj,
 9999 AS akt_kj
FROM kfl_production_dbp_view.v_jahr_kj;