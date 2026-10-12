CREATE OR REPLACE VIEW szd_production_fe_mstr_wholesale.v_dim_lot_part_2 (lot_part_prod_instance_group_sid,
dwh_valid_from_tmsp, dwh_valid_to_tmsp, dwh_valid_fg, lot_part_status_cd, lot_prod_instance_group_sid,
ship_destination_cd, gtin_nr, is_spare_unit_fg, shipped_carton_qty, piece_per_carton_qty, piece_per_carton_qty_agg,
length_m_meas, width_m_meas, height_m_meas, net_weight_kg_qty, gross_weight_kg_qty) AS SELECT product_instance_group_sid
  AS lot_part_prod_instance_group_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 lot_part_status_cd,
 lot_product_instance_group_sid AS lot_prod_instance_group_sid,
 shipping_destination_cd AS ship_destination_cd,
 gtin_nr,
 spare_unit_fg AS is_spare_unit_fg,
 shipped_carton_qty,
 piece_per_carton_qty,
 SUM(piece_per_carton_qty) OVER (PARTITION BY CAST(lot_product_instance_group_sid AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS piece_per_carton_qty_agg,
 length_m_meas,
 width_m_meas,
 height_m_meas,
 net_weight_kg_qty,
 gross_weight_kg_qty
FROM szd_production_core.t_dim_lot_part_2
WHERE dwh_valid_fg
 AND lot_part_status_cd <> 'C';