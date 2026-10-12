CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_dim_plant_2 (resource_item_sid, plant_name) AS SELECT plant_name AS
 resource_item_sid,
 plant_name
FROM produktion_core.t_dim_plant_2;