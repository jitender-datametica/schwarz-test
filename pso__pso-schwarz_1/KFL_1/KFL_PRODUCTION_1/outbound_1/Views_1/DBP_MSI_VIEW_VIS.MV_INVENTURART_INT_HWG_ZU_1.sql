CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_inventurart_int_hwg_zu_1 AS SELECT LIA.inventurart_int_id * 100
  + CAST(WGH.wg_hierarchie_id AS BIGNUMERIC) AS inventur_hwg_id,
 LIA.inventurart_int_id,
 WGH.wg_hierarchie_id AS hwg_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per_1 AS WGH
 INNER JOIN kfl_production_dbp_view.v_l_inventurart_int_1 AS LIA ON TRUE
WHERE WGH.arthiertyp_id = 5
 AND WGH.wg_hierarchie_ebene_id = 3
 AND WGH.dat_bis = DATE '9999-12-31'
GROUP BY inventur_hwg_id,
 LIA.inventurart_int_id,
 hwg_id;