CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_kumulation_gjmo (gj, mo_gj, gjmo, gjmo_kum) AS SELECT A.gj,
 A.mo_gj,
 A.gjmo,
 B.gjmo AS gjmo_kum
FROM kfl_production_dbp_view.v_monat AS A
 INNER JOIN kfl_production_dbp_view.v_monat AS B ON A.gjmo >= B.gjmo AND A.gj = B.gj;