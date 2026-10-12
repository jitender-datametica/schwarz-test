CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_wg_hier_ebene2_spr_zu_sk_1 AS SELECT V01.in_wg_ebene2_id,
 V02.in_wg_struktur_bez AS in_wg_ebene2_bez
FROM kfl_production_dbp_msi_view_bis.mv_l_wg_hier_ebene2_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_wg_struktur_spr_zu_1 AS V02 ON V01.in_wg_ebene2_id = V02.in_wg_struktur_id
WHERE V02.spr_id = 108;