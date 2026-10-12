CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_fact_booking_1 (booking_id, plant_resource_item_sid, shift_id,
orig_shift_id, material_resource_item_sid, warehouse_resource_item_sid, booking_dt, material_unit,
material_movement_type_id, material_group_resource_item_group_sid, material_qty, booking_tmsp) AS SELECT BO1.booking_id
 ,
 PLA1.plant_name AS plant_resource_item_sid,
 BO1.shift_id,
 BO1.orig_shift_id,
 MATR1.material_id AS material_resource_item_sid,
 WRH1.warehouse_name AS warehouse_resource_item_sid,
 BO1.booking_dt,
 BO1.material_unit,
 BO1.material_movement_type_id,
 MGR1.material_group_nr AS material_group_resource_item_group_sid,
 BO1.material_qty,
 BO1.booking_tmsp
FROM produktion_core.t_fact_booking_1 AS BO1
 INNER JOIN produktion_core.t_dim_plant_1 AS PLA1 ON BO1.plant_resource_item_sid = PLA1.resource_item_sid
 INNER JOIN produktion_core.t_dim_warehouse_1 AS WRH1 ON BO1.warehouse_resource_item_sid = WRH1.resource_item_sid
 INNER JOIN produktion_core.t_dim_material_group_1 AS MGR1 ON BO1.material_group_resource_item_group_sid = MGR1.resource_item_group_sid
  
 INNER JOIN produktion_core.t_dim_material_1 AS MATR1 ON BO1.material_resource_item_sid = MATR1.resource_item_sid;