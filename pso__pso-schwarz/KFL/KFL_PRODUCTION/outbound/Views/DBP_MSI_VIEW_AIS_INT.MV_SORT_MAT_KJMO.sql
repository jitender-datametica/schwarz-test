CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sort_mat_kjmo (kjmo, kjmo_vj, akt_mo) AS SELECT kjmo,
 kjmo_vj,
 akt_mo
FROM kfl_production_dbp_data.monat AS V01
WHERE akt_mo BETWEEN - 36 AND 0;