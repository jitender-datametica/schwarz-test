CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_kumulation_tag_auf_monat (gj, kj, dat, dat_kum, dat_vj_kum) AS
SELECT A.gj,
 A.kj,
 A.dat,
 B.dat AS dat_kum,
 B.dat_vj AS dat_vj_kum
FROM kfl_production_dbp_view.v_tag AS A
 INNER JOIN kfl_production_dbp_view.v_tag AS B ON A.dat >= B.dat AND A.gjmo = B.gjmo;