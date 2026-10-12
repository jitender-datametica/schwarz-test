CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_kumulation_monat_2 (gj, kjmo, kjmo_kum, kjmo_vj_kum) AS SELECT A
 .gj,
 A.kjmo,
 B.kjmo AS kjmo_kum,
 B.kjmo_vj AS kjmo_vj_kum
FROM kfl_production_dbp_view.v_monat_2 AS A
 INNER JOIN kfl_production_dbp_view.v_monat_2 AS B ON A.kjmo >= B.kjmo AND A.gj = B.gj;