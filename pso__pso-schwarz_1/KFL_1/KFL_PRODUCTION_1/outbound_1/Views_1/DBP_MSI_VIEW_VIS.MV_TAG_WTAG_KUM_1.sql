CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_tag_wtag_kum_1 (dat, dat_kum, dat_kum_vj) AS SELECT AKT.dat,
 VOR_WOCHEN.dat AS dat_kum,
 VOR_WOCHEN.dat_vj AS dat_kum_vj
FROM kfl_production_dbp_view.v_tag_1 AS AKT
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS VOR_WOCHEN ON AKT.dat > VOR_WOCHEN.dat AND AKT.wtag_id = VOR_WOCHEN.wtag_id
   
WHERE AKT.akt_mo_komplett BETWEEN 1 AND 3
 AND VOR_WOCHEN.akt_mo_komplett = 0;