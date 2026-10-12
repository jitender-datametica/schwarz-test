CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_lin_stichtag_2 (kjmo) AS SELECT kjmo
FROM kfl_production_dbp_view.v_monat_2
WHERE akt_mo_komplett BETWEEN - 5 AND 0
GROUP BY kjmo;