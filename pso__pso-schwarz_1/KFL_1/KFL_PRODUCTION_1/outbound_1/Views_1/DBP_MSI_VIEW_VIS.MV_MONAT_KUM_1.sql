CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_monat_kum_1 AS SELECT A.gj,
 A.kjmo,
 B.kjmo AS kjmo_kum,
 B.kjmo_vj AS kjmo_vj_kum
FROM kfl_production_dbp_view.v_monat_1 AS A
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS B ON A.kjmo >= B.kjmo AND A.gj = B.gj
WHERE A.gj >= 2012
 AND A.akt_gj <= 1;