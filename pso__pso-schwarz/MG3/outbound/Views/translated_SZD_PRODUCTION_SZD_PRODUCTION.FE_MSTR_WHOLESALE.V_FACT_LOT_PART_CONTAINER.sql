CREATE OR REPLACE VIEW szd_production_fe_mstr_wholesale.v_fact_lot_part_container (lot_part_prod_instance_group_sid,
lot_nr, container_resource_sid, lot_prod_instance_group_sid, gtin_nr, ship_destination_cd, total_ship_prod_qty,
shipped_product_qty, other_lots_in_container_cnt, other_lots_in_container_txt, total_ship_cont_prod_qty,
container_share_pct, produced_pcs_cnt, teu_share, carton_volume, carton_volume_lot, container_share_volume) AS SELECT
DISTINCT lpc.lot_part_product_instance_group_sid AS lot_part_prod_instance_group_sid,
 lpc.lot_nr,
 lpc.container_resource_item_sid AS container_resource_sid,
 lpc.lot_product_instance_group_sid AS lot_prod_instance_group_sid,
 lpc.gtin_nr,
 lpc.shipping_destination_cd AS ship_destination_cd,
 lpc.total_shipped_product_qty AS total_ship_prod_qty,
 lpc.shipped_product_qty,
 lpc.other_lots_in_container_cnt,
 lpc.other_lots_in_container_txt,
 lpc.total_shipped_container_product_qty AS total_ship_cont_prod_qty,
 lpc.container_share_pct,
  lp.piece_per_carton_qty * lpc.shipped_product_qty AS produced_pcs_cnt,
  lpc.container_share_pct * c.teu_qty AS teu_share,
    lp.length_m_meas * lp.width_m_meas * lp.height_m_meas * lpc.shipped_product_qty AS carton_volume,
 SUM(lp.length_m_meas * lp.width_m_meas * lp.height_m_meas * lpc.shipped_product_qty) OVER (PARTITION BY CAST(lpc.container_resource_item_sid AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS carton_volume_lot,
 IF((SUM(lp.length_m_meas * lp.width_m_meas * lp.height_m_meas * lpc.shipped_product_qty) OVER (PARTITION BY CAST(lpc.container_resource_item_sid AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, 0, SAFE_DIVIDE(lp.length_m_meas * lp.width_m_meas
       * lp.height_m_meas * lpc.shipped_product_qty, SUM(lp.length_m_meas * lp.width_m_meas * lp.height_m_meas * lpc.shipped_product_qty
     ) OVER (PARTITION BY CAST(lpc.container_resource_item_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING))) AS container_share_volume
FROM szd_production_core.t_fact_lot_lot_part_container AS lpc
 LEFT JOIN szd_production_core.t_dim_lot_part AS lp ON lpc.lot_part_product_instance_group_sid = lp.product_instance_group_sid
     AND lpc.lot_product_instance_group_sid = lp.lot_product_instance_group_sid AND lpc.shipping_destination_cd = lp.shipping_destination_cd
   
 LEFT JOIN szd_production_core.t_dim_container AS c ON lpc.container_resource_item_sid = c.resource_item_sid
WHERE lpc.dwh_valid_fg
 AND lp.dwh_valid_fg
 AND c.dwh_valid_fg
 AND c.container_status_cd = 'A'
 AND lp.lot_part_status_cd = 'A';