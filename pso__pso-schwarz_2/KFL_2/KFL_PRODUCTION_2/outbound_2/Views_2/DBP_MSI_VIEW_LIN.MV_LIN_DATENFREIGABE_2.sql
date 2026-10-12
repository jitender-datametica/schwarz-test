CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_lin_datenfreigabe_2 (kjmo, akt_kjmo) AS SELECT kjmo,
 RANK() OVER (ORDER BY kjmo IS NULL, kjmo) AS akt_kjmo
FROM kfl_production_dbp_msi_v_view.v_lin_datenfreigabe_2 AS V01
WHERE lin_freigabe_fg = 1
 AND vertrieb_fg = 0
GROUP BY kjmo;