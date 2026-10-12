CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_fact_measurement_production_line_per_intervall_moving (production_line_resource_item_sid
, shift_id, measurement_dt, measurement_tm, measurement_tmsp, production_line_parameter_resource_item_sid, unit_id,
granularity_type, parameter_per_intervall_moving_value, min_parameter_per_intervall_moving_val,
max_parameter_per_intervall_moving_val, target_parameter_per_intervall_moving_val,
lower_warning_limit_parameter_per_intervall_moving_val, upper_warning_limit_parameter_per_intervall_moving_val,
interval_five_min_hr) AS SELECT PRL1.production_line_id AS production_line_resource_item_sid,
 MPL.shift_id,
 MPL.measurement_dt,
 MPL.measurement_tm,
 MPL.measurement_tmsp,
 CONCAT(CAST(PRL1.production_line_id AS STRING), PRM.production_line_parameter_cd) AS
 production_line_parameter_resource_item_sid,
 PRM.unit_id,
 PRM.granularity_type,
  CASE
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_3_MAG01_340')
  THEN MPL.naoh_dosage_qty
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_3_MAG01_342')
  THEN MPL.added_additive_qty
  WHEN PRM.production_line_parameter_cd IN ('Detergent_dosage_rate')
  THEN MPL.detergent_dosage_rate
  ELSE NULL
  END AS parameter_per_intervall_moving_value,
 TPPMR.min_val AS min_parameter_per_intervall_moving_val,
 TPPMR.max_val AS max_parameter_per_intervall_moving_val,
 TPPMR.target_val AS target_parameter_per_intervall_moving_val,
 TPPMR.lower_warning_limit_val AS lower_warning_limit_parameter_per_intervall_moving_val,
 TPPMR.upper_warning_limit_val AS upper_warning_limit_parameter_per_intervall_moving_val,
 MPL.interval_five_min_hr
FROM produktion_core.t_fact_measurement_production_line_per_intervall_moving AS MPL
 INNER JOIN produktion_core.t_dim_production_line_parameter AS PRM ON MPL.production_line_resource_item_sid = PRM.production_line_resource_item_sid
  
 INNER JOIN produktion_core.t_dim_production_line AS PRL1 ON MPL.production_line_resource_item_sid = PRL1.resource_item_sid
  
 INNER JOIN produktion_core.t_fact_threshold_parameter_per_material_rel AS TPPMR ON PRM.resource_item_sid = TPPMR.production_line_parameter_resource_item_sid
  
WHERE PRM.production_line_parameter_cd IN ('MVA_L1_3_MAG01_340', 'MVA_L1_3_MAG01_342', 'Detergent_dosage_rate');