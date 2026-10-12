CREATE OR REPLACE VIEW szd_production_fe_mstr_wholesale.v_fact_lot_destination_fe_1 (lot_prod_instance_group_sid,
ship_destination_cd, delivery_week_start_dt, dwh_valid_fg, shifted_delivery_week_start_dt, ship_mark_txt,
nom_tot_carton_qty, booked_tot_carton_qty, nom_piece_per_carton_qty, booked_piece_per_carton_qty, length_m_meas,
width_m_meas, height_m_meas, net_weight_kg_qty, gross_weight_kg_qty, piece_per_carton_qty, ordered_cartons_qty,
booked_tot_carton_qty_lot_level, lot_land_share, total_shipped_teu_land) AS SELECT DISTINCT ld.lot_product_instance_group_sid
  AS lot_prod_instance_group_sid,
 ld.shipping_destination_cd AS ship_destination_cd,
 ld.delivery_week_start_dt,
 ld.dwh_valid_fg,
 ld.shifted_delivery_week_start_dt,
 ld.shipping_mark_txt AS ship_mark_txt,
 ld.nominated_total_carton_qty AS nom_tot_carton_qty,
 ld.booked_total_carton_qty AS booked_tot_carton_qty,
 ld.nominated_piece_per_carton_qty AS nom_piece_per_carton_qty,
 ld.booked_piece_per_carton_qty,
 ld.length_m_meas,
 ld.width_m_meas,
 ld.height_m_meas,
 ld.net_weight_kg_qty,
 ld.gross_weight_kg_qty,
 SUM(lp.piece_per_carton_qty) AS piece_per_carton_qty,
 SUM(lp.piece_per_carton_qty * ld.nominated_total_carton_qty) AS ordered_cartons_qty,
 SUM(ld.booked_total_carton_qty) OVER (PARTITION BY CAST(ld.lot_product_instance_group_sid AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS booked_tot_carton_qty_lot_level,
 IF((SUM(ld.booked_total_carton_qty) OVER (PARTITION BY CAST(ld.lot_product_instance_group_sid AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, 0, SAFE_DIVIDE(ld.booked_total_carton_qty, SUM(ld.booked_total_carton_qty
    ) OVER (PARTITION BY CAST(ld.lot_product_instance_group_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING))) AS lot_land_share,
  lo.shipped_teu_meas * IF((SUM(ld.booked_total_carton_qty) OVER (PARTITION BY CAST(ld.lot_product_instance_group_sid AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, 0, SAFE_DIVIDE(ld.booked_total_carton_qty, SUM(ld
     .booked_total_carton_qty) OVER (PARTITION BY CAST(ld.lot_product_instance_group_sid AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS total_shipped_teu_land
FROM szd_production_core.t_dim_lot_destination_1 AS ld
 INNER JOIN szd_production_core.t_dim_lot_part_1 AS lp ON ld.lot_product_instance_group_sid = lp.lot_product_instance_group_sid
      AND ld.shipping_destination_cd = CASE
      WHEN lp.shipping_destination_cd = 'NA'
      THEN ld.shipping_destination_cd
      ELSE lp.shipping_destination_cd
      END AND ld.dwh_valid_fg AND lp.dwh_valid_fg
 LEFT JOIN szd_production_core.t_dim_lot_1 AS lo ON ld.lot_product_instance_group_sid = lo.product_instance_group_sid AND
  lo.dwh_valid_fg
WHERE lp.lot_part_status_cd <> 'C'
 AND ld.shipping_destination_cd <> 'SpareItems'
GROUP BY lot_prod_instance_group_sid,
 ship_destination_cd,
 ld.delivery_week_start_dt,
 ld.dwh_valid_fg,
 ld.shifted_delivery_week_start_dt,
 ship_mark_txt,
 nom_tot_carton_qty,
 booked_tot_carton_qty,
 nom_piece_per_carton_qty,
 ld.booked_piece_per_carton_qty,
 ld.length_m_meas,
 ld.width_m_meas,
 ld.height_m_meas,
 ld.net_weight_kg_qty,
 ld.gross_weight_kg_qty,
 lo.shipped_teu_meas;