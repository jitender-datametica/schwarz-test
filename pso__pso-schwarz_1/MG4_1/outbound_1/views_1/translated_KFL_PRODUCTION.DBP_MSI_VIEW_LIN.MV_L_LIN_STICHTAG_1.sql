CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_l_lin_stichtag_1 (kjmo) AS SELECT kjmo
FROM kfl_production_dbp_view.v_monat_1
WHERE akt_mo_komplett BETWEEN - 11 AND 0
GROUP BY kjmo;