CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_inventurart_int_vis_zu_1 AS SELECT DISTINCT ABT.abt_id,
 INV.inventurart_int_id,
 CAST(CASE
   WHEN INV.inventurart_int_id NOT IN (8) AND ABT.abt_id = 5
   THEN 10
   WHEN INV.inventurart_int_id IN (1)
   THEN 11
   WHEN INV.inventurart_int_id IN (2)
   THEN 12
   WHEN INV.inventurart_int_id IN (3, 6, 7)
   THEN 13
   WHEN INV.inventurart_int_id IN (4)
   THEN 14
   WHEN INV.inventurart_int_id IN (5)
   THEN 15
   ELSE 99
   END AS BIGNUMERIC) AS inventurart_vis_id
FROM kfl_production_dbp_view.v_abt_per_1 AS ABT_1
 INNER JOIN kfl_production_dbp_view.v_l_inventurart_int_1 AS INV ON TRUE;