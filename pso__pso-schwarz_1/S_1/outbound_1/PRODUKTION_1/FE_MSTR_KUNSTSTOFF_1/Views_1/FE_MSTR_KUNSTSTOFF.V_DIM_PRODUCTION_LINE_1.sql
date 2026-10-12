CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_dim_production_line_1 (resource_item_sid, plant_resource_item_sid,
production_line_name, plant_name) AS SELECT PRL1.production_line_id AS resource_item_sid,
 PLA1.plant_name AS plant_resource_item_sid,
 PRL1.production_line_name,
 PLA1.plant_name
FROM produktion_core.t_dim_production_line_1 AS PRL1
 INNER JOIN produktion_core.t_dim_plant_1 AS PLA1 ON PRL1.plant_resource_item_sid = PLA1.resource_item_sid;