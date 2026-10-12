CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_fact_measurement_production_line_per_intervall (production_line_resource_item_sid
, material_resource_item_sid, measurement_dt, measurement_tm, measurement_tmsp,
production_line_parameter_resource_item_sid, unit_id, granularity_type, parameter_per_intervall_value,
min_parameter_per_intervall_val, max_parameter_per_intervall_val, target_parameter_per_intervall_val,
lower_warning_limit_parameter_per_intervall_val, upper_warning_limit_parameter_per_intervall_val, interval_five_min_hr)
AS SELECT PRL1.production_line_id AS production_line_resource_item_sid,
 MATR1.material_id AS material_resource_item_sid,
 MPL.measurement_dt,
 MPL.measurement_tm,
 MPL.measurement_tmsp,
 CONCAT(CAST(PRL1.production_line_id AS STRING), PRM.production_line_parameter_cd) AS
 production_line_parameter_resource_item_sid,
 PRM.unit_id,
 PRM.granularity_type,
  CASE
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_2_MAG01_0202')
  THEN MPL.avg_feeder_speed_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_2_MAG01_0198', 'MVA_L2_2_MAG01_0172')
  THEN MPL.avg_feeder_speed_pct
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_3_MAG01_170')
  THEN MPL.avg_bulk_material_balance_buffersilo_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_4_MAG01_770', 'MVA_L2_4_MAG01_376', 'MVA_L3_4_MAG01_0376')
  THEN MPL.avg_extruder_output_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_4_MAG02_210', 'MVA_L2_4_MAG02_0384', 'MVA_L3_4_MAG02_0384')
  THEN MPL.avg_fill_level_reactor_vessel_pct
  WHEN PRM.production_line_parameter_cd IN ('Throughput_Preform')
  THEN MPL.avg_throughput_preform_qty
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_3_MAG01_296')
  THEN MPL.avg_bulk_material_balance_buffersilo_out_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L2_2_MAG01_0504')
  THEN MPL.avg_bale_weight_qty
  WHEN PRM.production_line_parameter_cd IN ('Bulk_material_balance_Washing')
  THEN MPL.avg_bulk_material_balance_washing_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_7_MAG01_0674')
  THEN MPL.avg_feeder_utilization_mill_unit_output_silo_pct
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_7_MAG01_0682')
  THEN MPL.avg_feeder_utilization_mill_unit_pct
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_3_MAG01_190', 'MVA_L2_3_MAG01_0308')
  THEN MPL.avg_washer_tank_temperature_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_3_MAG01_250', 'MVA_L2_3_MAG01_0364')
  THEN MPL.avg_rewasher_tank_temperature_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_4_MAG01_786', 'MVA_L2_4_MAG01_960', 'MVA_L3_4_MAG01_0960')
  THEN MPL.avg_inline_iv_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_4_MAG02_208', 'MVA_L2_4_MAG02_0536', 'MVA_L3_4_MAG02_0536')
  THEN MPL.avg_regranulation_vacuum_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_1_MAG01_200', 'MVA_L1_1_MAG01_464', 'MVA_L2_1_MAG01_200',
    'MVA_L4_1_MAG01_200', 'MVA_L5_1_MAG01_200', 'MVA_L6_1_MAG01_200', 'MVA_L7_1_MAG02_188', 'MVA_L8_1_MAG01_200',
    'MVA_L9_1_MAG01_200', 'MVA_L10_1_MAG01_200', 'MVA_L11_1_MAG01_200', 'MVA_L12_1_MAG01_200', 'MVA_L13_1_MAG01_200',
    'MVA_L13_1_MAG01_464')
  THEN MPL.avg_heating_box_temperature_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_1_MAG01_222', 'MVA_L2_1_MAG01_222', 'MVA_L4_1_MAG01_222',
    'MVA_L5_1_MAG01_222', 'MVA_L6_1_MAG01_222', 'MVA_L7_1_MAG02_784', 'MVA_L8_1_MAG01_222', 'MVA_L9_1_MAG01_222',
    'MVA_L10_1_MAG01_222', 'MVA_L11_1_MAG01_222', 'MVA_L12_1_MAG01_222', 'MVA_L13_1_MAG01_222')
  THEN MPL.avg_booster_temperature_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_1_MAG01_172', 'MVA_L2_1_MAG01_172', 'MVA_L4_1_MAG01_172',
    'MVA_L5_1_MAG01_172', 'MVA_L6_1_MAG01_172', 'MVA_L7_1_MAG02_228', 'MVA_L8_1_MAG01_172', 'MVA_L9_1_MAG01_172',
    'MVA_L10_1_MAG01_172', 'MVA_L11_1_MAG01_172', 'MVA_L12_1_MAG01_172', 'MVA_L13_1_MAG01_172')
  THEN MPL.avg_dryer_dew_point_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_1_MAG01_178', 'MVA_L2_1_MAG01_178', 'MVA_L4_1_MAG01_178',
    'MVA_L5_1_MAG01_178', 'MVA_L6_1_MAG01_178', 'MVA_L8_1_MAG01_178', 'MVA_L9_1_MAG01_178', 'MVA_L10_1_MAG01_178',
    'MVA_L11_1_MAG01_178', 'MVA_L12_1_MAG01_178', 'MVA_L13_1_MAG01_178')
  THEN MPL.avg_eta_box_temperature_meas
  ELSE NULL
  END AS parameter_per_intervall_value,
 COALESCE(TPPMR.min_val, TPPMR2.min_val) AS min_parameter_per_intervall_val,
 COALESCE(TPPMR.max_val, TPPMR2.max_val) AS max_parameter_per_intervall_val,
 COALESCE(TPPMR.target_val, TPPMR2.target_val) AS target_parameter_per_intervall_val,
 COALESCE(TPPMR.lower_warning_limit_val, TPPMR2.lower_warning_limit_val) AS
 lower_warning_limit_parameter_per_intervall_val,
 COALESCE(TPPMR.upper_warning_limit_val, TPPMR2.upper_warning_limit_val) AS
 upper_warning_limit_parameter_per_intervall_val,
 MPL.interval_five_min_hr
FROM produktion_core.t_fact_measurement_production_line_per_intervall AS MPL
 INNER JOIN produktion_core.t_dim_production_line_parameter AS PRM ON MPL.production_line_resource_item_sid = PRM.production_line_resource_item_sid
  
 INNER JOIN produktion_core.t_dim_material AS MATR1 ON MPL.material_resource_item_sid = MATR1.resource_item_sid
 INNER JOIN produktion_core.t_dim_production_line AS PRL1 ON MPL.production_line_resource_item_sid = PRL1.resource_item_sid
  
 LEFT JOIN produktion_core.t_fact_threshold_parameter_per_material_rel AS TPPMR ON PRM.resource_item_sid = TPPMR.production_line_parameter_resource_item_sid
    AND MPL.material_resource_item_sid = TPPMR.material_resource_item_sid
 INNER JOIN produktion_core.t_fact_threshold_parameter_per_material_rel AS TPPMR2 ON PRM.resource_item_sid = TPPMR2.production_line_parameter_resource_item_sid
    AND - 1 = TPPMR2.material_resource_item_sid
WHERE PRM.production_line_parameter_cd IN ('MVA_L1_2_MAG01_0198', 'MVA_L2_2_MAG01_0172', 'MVA_L1_2_MAG01_0202',
   'MVA_L1_3_MAG01_170', 'MVA_L1_4_MAG01_770', 'MVA_L2_4_MAG01_376', 'MVA_L3_4_MAG01_0376', 'MVA_L1_4_MAG02_210',
   'MVA_L2_4_MAG02_0384', 'MVA_L3_4_MAG02_0384', 'Throughput_Preform', 'MVA_L1_3_MAG01_296', 'MVA_L2_2_MAG01_0504',
   'Bulk_material_balance_Washing', 'MVA_L1_7_MAG01_0674', 'MVA_L1_7_MAG01_0682', 'MVA_L1_3_MAG01_190',
   'MVA_L2_3_MAG01_0308', 'MVA_L1_3_MAG01_250', 'MVA_L2_3_MAG01_0364', 'MVA_L1_4_MAG01_786', 'MVA_L2_4_MAG01_960',
   'MVA_L3_4_MAG01_0960', 'MVA_L1_4_MAG02_208', 'MVA_L2_4_MAG02_0536', 'MVA_L3_4_MAG02_0536', 'MVA_L1_1_MAG01_200',
   'MVA_L1_1_MAG01_464', 'MVA_L2_1_MAG01_200', 'MVA_L4_1_MAG01_200', 'MVA_L5_1_MAG01_200', 'MVA_L6_1_MAG01_200',
   'MVA_L7_1_MAG02_188', 'MVA_L8_1_MAG01_200', 'MVA_L9_1_MAG01_200', 'MVA_L10_1_MAG01_200', 'MVA_L11_1_MAG01_200',
   'MVA_L12_1_MAG01_200', 'MVA_L13_1_MAG01_200', 'MVA_L13_1_MAG01_464', 'MVA_L1_1_MAG01_222', 'MVA_L2_1_MAG01_222',
   'MVA_L4_1_MAG01_222', 'MVA_L5_1_MAG01_222', 'MVA_L6_1_MAG01_222', 'MVA_L7_1_MAG02_784', 'MVA_L8_1_MAG01_222',
   'MVA_L9_1_MAG01_222', 'MVA_L10_1_MAG01_222', 'MVA_L11_1_MAG01_222', 'MVA_L12_1_MAG01_222', 'MVA_L13_1_MAG01_222',
   'MVA_L1_1_MAG01_172', 'MVA_L2_1_MAG01_172', 'MVA_L4_1_MAG01_172', 'MVA_L5_1_MAG01_172', 'MVA_L6_1_MAG01_172',
   'MVA_L7_1_MAG02_228', 'MVA_L8_1_MAG01_172', 'MVA_L9_1_MAG01_172', 'MVA_L10_1_MAG01_172', 'MVA_L11_1_MAG01_172',
   'MVA_L12_1_MAG01_172', 'MVA_L13_1_MAG01_172', 'MVA_L1_1_MAG01_178', 'MVA_L2_1_MAG01_178', 'MVA_L4_1_MAG01_178',
   'MVA_L5_1_MAG01_178', 'MVA_L6_1_MAG01_178', 'MVA_L8_1_MAG01_178', 'MVA_L9_1_MAG01_178', 'MVA_L10_1_MAG01_178',
   'MVA_L11_1_MAG01_178', 'MVA_L12_1_MAG01_178', 'MVA_L13_1_MAG01_178');