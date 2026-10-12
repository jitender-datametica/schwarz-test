CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_fact_lot_destination_fe_1 (lot_prod_instance_group_sid, ship_destination_cd
, delivery_week_start_dt, dwh_valid_fg, shifted_delivery_week_start_dt, ship_mark_txt, nom_tot_carton_qty,
booked_tot_carton_qty, nom_piece_per_carton_qty, booked_piece_per_carton_qty, length_m_meas, width_m_meas, height_m_meas
, net_weight_kg_qty, gross_weight_kg_qty, piece_per_carton_qty, ordered_cartons_qty, booked_tot_carton_qty_lot_level,
lot_land_share, total_shipped_teu_land) AS SELECT DISTINCT LD.lot_product_instance_group_sid AS
 lot_prod_instance_group_sid,
 LD.shipping_destination_cd AS ship_destination_cd,
 LD.delivery_week_start_dt,
 LD.dwh_valid_fg,
 LD.shifted_delivery_week_start_dt,
 LD.shipping_mark_txt AS ship_mark_txt,
 LD.nominated_total_carton_qty AS nom_tot_carton_qty,
 LD.booked_total_carton_qty AS booked_tot_carton_qty,
 LD.nominated_piece_per_carton_qty AS nom_piece_per_carton_qty,
 LD.booked_piece_per_carton_qty,
 LD.length_m_meas,
 LD.width_m_meas,
 LD.height_m_meas,
 LD.net_weight_kg_qty,
 LD.gross_weight_kg_qty,
 SUM(LP.piece_per_carton_qty) AS piece_per_carton_qty,
 SUM(LP.piece_per_carton_qty * LD.nominated_total_carton_qty) AS ordered_cartons_qty,
 SUM(LD.booked_total_carton_qty) OVER (PARTITION BY CAST(LD.lot_product_instance_group_sid AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS booked_tot_carton_qty_lot_level,
 IF((SUM(LD.booked_total_carton_qty) OVER (PARTITION BY CAST(LD.lot_product_instance_group_sid AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, 0, SAFE_DIVIDE(LD.booked_total_carton_qty, SUM(LD.booked_total_carton_qty
    ) OVER (PARTITION BY CAST(LD.lot_product_instance_group_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING))) AS lot_land_share,
  LO.shipped_teu_meas * IF((SUM(LD.booked_total_carton_qty) OVER (PARTITION BY CAST(LD.lot_product_instance_group_sid AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, 0, SAFE_DIVIDE(LD.booked_total_carton_qty, SUM(LD
     .booked_total_carton_qty) OVER (PARTITION BY CAST(LD.lot_product_instance_group_sid AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS total_shipped_teu_land
FROM szd_core.t_dim_lot_destination_1 AS LD
 INNER JOIN szd_core.t_dim_lot_part_1 AS LP ON LD.lot_product_instance_group_sid = LP.lot_product_instance_group_sid AND
     LD.shipping_destination_cd = CASE
      WHEN LP.shipping_destination_cd = 'NA'
      THEN LD.shipping_destination_cd
      ELSE LP.shipping_destination_cd
      END AND LD.dwh_valid_fg AND LP.dwh_valid_fg
 LEFT JOIN szd_core.t_dim_lot_1 AS LO ON LD.lot_product_instance_group_sid = LO.product_instance_group_sid AND LO.dwh_valid_fg
  
WHERE LP.lot_part_status_cd <> 'C'
 AND LD.shipping_destination_cd <> 'SpareItems'
GROUP BY lot_prod_instance_group_sid,
 ship_destination_cd,
 LD.delivery_week_start_dt,
 LD.dwh_valid_fg,
 LD.shifted_delivery_week_start_dt,
 ship_mark_txt,
 nom_tot_carton_qty,
 booked_tot_carton_qty,
 nom_piece_per_carton_qty,
 LD.booked_piece_per_carton_qty,
 LD.length_m_meas,
 LD.width_m_meas,
 LD.height_m_meas,
 LD.net_weight_kg_qty,
 LD.gross_weight_kg_qty,
 LO.shipped_teu_meas;