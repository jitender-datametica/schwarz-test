CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_fact_booking_per_order_business_day_1 (order_id, order_nr,
production_line_resource_item_sid, material_resource_item_sid, booking_business_dt, movement_type_id,
material_group_resource_item_group_sid, order_start_dt, order_end_dt, order_start_tmsp, order_end_tmsp,
production_line_start_tmsp, production_line_end_tmsp, consumed_material_qty, produced_material_qty, dwh_src_1_tmsp,
max_booking_tmsp) AS SELECT TF1.order_id,
 TF1.order_nr,
 TD1.production_line_id AS production_line_resource_item_sid,
 TD2.material_id AS material_resource_item_sid,
 TF1.booking_business_dt,
 TF1.movement_type_id,
 TD3.material_group_nr AS material_group_resource_item_group_sid,
 TF1.order_start_dt,
 TF1.order_end_dt,
 TF1.order_start_tmsp,
 TF1.order_end_tmsp,
 TF1.production_line_start_tmsp,
 TF1.production_line_end_tmsp,
 TF1.consumed_material_qty,
 TF1.produced_material_qty,
 TF1.dwh_src_1_tmsp,
 TF1.max_booking_tmsp
FROM produktion_core.t_fact_booking_per_order_business_day_1 AS TF1
 INNER JOIN produktion_core.t_dim_production_line_1 AS TD1 ON TF1.production_line_resource_item_sid = TD1.resource_item_sid
  
 INNER JOIN produktion_core.t_dim_material_1 AS TD2 ON TF1.material_resource_item_sid = TD2.resource_item_sid
 INNER JOIN produktion_core.t_dim_material_group_1 AS TD3 ON TF1.material_group_resource_item_group_sid = TD3.resource_item_group_sid;