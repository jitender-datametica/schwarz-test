CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_dim_material_1 (resource_item_sid, material_id, material_name) AS
SELECT material_id AS resource_item_sid,
 material_id,
 material_name
FROM produktion_core.t_dim_material_1;