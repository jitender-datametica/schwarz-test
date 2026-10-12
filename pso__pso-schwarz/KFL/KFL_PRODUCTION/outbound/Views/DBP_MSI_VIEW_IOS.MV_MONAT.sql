CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_monat (kjmo, gjmo, kj, gj, akt_mo, akt_gj, akt_kj, mo_gj,
mo_kj) AS SELECT kjmo,
 gjmo,
 kj,
 gj,
 akt_mo,
 akt_gj,
 akt_kj,
 mo_gj,
 mo_kj
FROM kfl_production_dbp_view.v_monat
UNION ALL
SELECT DISTINCT 209912 AS kjmo,
 209910 AS gjmo,
 2099 AS kj,
 2099 AS gj,
 999 AS akt_mo,
 99 AS akt_gj,
 99 AS akt_kj,
 10 AS mo_gj,
 12 AS mo_kj
FROM kfl_production_dbp_view.v_monat;