CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_dim_production_line_parameter_2 (resource_item_sid,
production_line_parameter_cd, production_line_parameter_name) AS SELECT DISTINCT CONCAT(CAST(PRL1.production_line_id AS STRING)
  , PRM1.production_line_parameter_cd) AS resource_item_sid,
 PRM1.production_line_parameter_cd,
 PRM1.production_line_parameter_name
FROM produktion_core.t_dim_production_line_parameter_2 AS PRM1
 INNER JOIN produktion_core.t_dim_production_line_2 AS PRL1 ON PRM1.production_line_resource_item_sid = PRL1.resource_item_sid;