CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_wg_hier_ebene6_spr_zu_sk_2 AS SELECT V01.in_wg_ebene6_id,
 V02.in_wg_struktur_bez AS in_wg_ebene6_bez,
  CASE
  WHEN LENGTH(V01.in_wg_ebene6_id) = 12
  THEN V02.in_wg_struktur_bez
  ELSE ''
  END AS in_wg_ebene6_hier_bez
FROM kfl_production_dbp_msi_view_bis.mv_l_wg_hier_ebene6_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_wg_struktur_spr_zu_2 AS V02 ON V01.in_wg_ebene6_id = V02.in_wg_struktur_id
WHERE V02.spr_id = 108;