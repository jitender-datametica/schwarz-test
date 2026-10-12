CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_kumulation_tag (gj, kj, dat, dat_kum, dat_vj_kum) AS SELECT A
 .gj,
 A.kj,
 A.dat,
 B.dat AS kjmo_kum,
 B.dat_vj AS kjmo_vj_kum
FROM kfl_production_dbp_view.v_tag AS A
 INNER JOIN kfl_production_dbp_view.v_tag AS B ON A.dat >= B.dat AND A.gj = B.gj;