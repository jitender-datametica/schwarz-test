CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_monat_listung (kjmo, kj, akt_kj) AS SELECT kjmo,
 kj,
 akt_kj
FROM kfl_production_dbp_view.v_monat AS V01
WHERE akt_kj > - 3
UNION ALL
SELECT DISTINCT 999912 AS kjmo,
 9999 AS kj,
 9999 AS akt_kj
FROM kfl_production_dbp_view.v_monat;