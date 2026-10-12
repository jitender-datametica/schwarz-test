CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_mat_kjmo_1 AS SELECT kjmo,
 kjmo_vj,
 akt_mo
FROM kfl_production_dbp_view.v_monat_1 AS V01
WHERE akt_mo BETWEEN - 120 AND 0;