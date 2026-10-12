CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_dim_warehouse_1 (resource_item_sid, plant_resource_item_sid,
warehouse_name, plant_name, warehouse_type_name) AS SELECT WRH1.warehouse_name AS resource_item_sid,
 PLA1.plant_name AS plant_resource_item_sid,
 WRH1.warehouse_name,
 PLA1.plant_name,
 WRH1.warehouse_type_name
FROM produktion_core.t_dim_warehouse_1 AS WRH1
 INNER JOIN produktion_core.t_dim_plant_1 AS PLA1 ON WRH1.plant_resource_item_sid = PLA1.resource_item_sid;