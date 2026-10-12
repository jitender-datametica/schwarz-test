CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_lot_destination_1 (lot_prod_instance_group_sid, ship_destination_cd,
delivery_week_start_dt, dwh_valid_fg, shifted_delivery_week_start_dt, ship_mark_txt, lob_cd, nom_tot_carton_qty,
booked_tot_carton_qty, nom_piece_per_carton_qty, booked_piece_per_carton_qty, length_m_meas, width_m_meas, height_m_meas
, net_weight_kg_qty, gross_weight_kg_qty) AS SELECT DISTINCT lot_product_instance_group_sid AS
 lot_prod_instance_group_sid,
 shipping_destination_cd AS ship_destination_cd,
 delivery_week_start_dt,
 dwh_valid_fg,
 shifted_delivery_week_start_dt,
 shipping_mark_txt AS ship_mark_txt,
 lob_cd,
 nominated_total_carton_qty AS nom_tot_carton_qty,
 booked_total_carton_qty AS booked_tot_carton_qty,
 nominated_piece_per_carton_qty AS nom_piece_per_carton_qty,
 booked_piece_per_carton_qty,
 length_m_meas,
 width_m_meas,
 height_m_meas,
 net_weight_kg_qty,
 gross_weight_kg_qty
FROM szd_core.t_dim_lot_destination_1
WHERE dwh_valid_fg;