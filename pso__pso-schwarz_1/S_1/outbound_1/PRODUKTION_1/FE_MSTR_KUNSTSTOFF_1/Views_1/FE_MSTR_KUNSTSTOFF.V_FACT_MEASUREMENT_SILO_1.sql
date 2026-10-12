CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_fact_measurement_silo_1 (production_line_resource_item_sid,
warehouse_resource_item_sid, silo_resource_item_sid, mixer_line_resource_item_sid,
production_line_parameter_resource_item_sid, material_id, measurement_dt, measurement_tm, measurement_tmsp,
fill_level_unit_id, fill_level_pct, fill_level_meas) AS SELECT PRL1.production_line_id AS
 production_line_resource_item_sid,
 WRH1.warehouse_name AS warehouse_resource_item_sid,
 SILDIM1.silo_name AS silo_resource_item_sid,
 MIX1.mixer_line_cd AS mixer_line_resource_item_sid,
 CONCAT(PRL1.production_line_id, PRM.production_line_parameter_cd) AS production_line_parameter_resource_item_sid,
 MATR1.material_id,
 SILFA1.measurement_dt,
 SILFA1.measurement_tm,
 SILFA1.measurement_tmsp,
 SILFA1.fill_level_unit_id,
 SILFA1.fill_level_pct,
 SILFA1.fill_level_meas
FROM produktion_core.t_fact_measurement_silo_1 AS SILFA1
 INNER JOIN produktion_core.t_dim_production_line_1 AS PRL1 ON SILFA1.production_line_resource_item_sid = PRL1.resource_item_sid
  
 INNER JOIN produktion_core.t_dim_warehouse_1 AS WRH1 ON SILFA1.warehouse_resource_item_sid = WRH1.resource_item_sid
 INNER JOIN produktion_core.t_dim_silo_1 AS SILDIM1 ON SILFA1.silo_resource_item_sid = SILDIM1.resource_item_sid
 INNER JOIN produktion_core.t_dim_mixer_line_1 AS MIX1 ON SILFA1.mixer_line_resource_item_sid = MIX1.resource_item_sid
 INNER JOIN produktion_core.t_dim_production_line_parameter_1 AS PRM ON SILFA1.fill_level_res_item_sid = PRM.resource_item_sid
  
 INNER JOIN produktion_core.t_dim_material_1 AS MATR1 ON SILFA1.material_resource_item_sid = MATR1.resource_item_sid;