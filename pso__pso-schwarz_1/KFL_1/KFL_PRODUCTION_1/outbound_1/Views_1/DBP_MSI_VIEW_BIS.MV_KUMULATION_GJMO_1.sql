CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_kumulation_gjmo_1 (gj, mo_gj, gjmo, gjmo_kum) AS SELECT A.gj,
 A.mo_gj,
 A.gjmo,
 B.gjmo AS gjmo_kum
FROM kfl_production_dbp_view.v_monat_1 AS A
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS B ON A.gjmo >= B.gjmo AND A.gj = B.gj;