CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_abt_inventurart_int_zu_1 AS SELECT DISTINCT CASE
  WHEN INV.inventurart_int_id = 8
  THEN 90 + ABT.abt_id
  WHEN ABT.abt_id = 5
  THEN 50
  WHEN ABT.abt_id = 4 AND INV.inventurart_int_id IN (3, 6, 7)
  THEN 43
  WHEN ABT.abt_id = 6 AND INV.inventurart_int_id IN (3, 6, 7)
  THEN 63
  WHEN ABT.abt_id = 7 AND INV.inventurart_int_id IN (3, 6, 7)
  THEN 73
  WHEN ABT.abt_id = 8 AND INV.inventurart_int_id IN (3, 6, 7)
  THEN 83
  ELSE ABT.abt_id * 10 + INV.inventurart_int_id
  END AS abt_invart_id,
 ABT.abt_id,
 INV.inventurart_int_id
FROM kfl_production_dbp_view.v_abt_per_1 AS ABT_1
 INNER JOIN kfl_production_dbp_view.v_l_inventurart_int_1 AS INV ON TRUE;