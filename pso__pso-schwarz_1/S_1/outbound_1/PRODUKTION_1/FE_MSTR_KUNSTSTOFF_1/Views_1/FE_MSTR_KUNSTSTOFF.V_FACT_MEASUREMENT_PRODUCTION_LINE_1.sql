CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_fact_measurement_production_line_1 (production_line_resource_item_sid
, material_resource_item_sid, shift_id, measurement_dt, measurement_tm, measurement_tmsp,
production_line_parameter_resource_item_sid, unit_id, granularity_type, parameter_value, min_val, max_val, target_val,
lower_warning_limit_val, upper_warning_limit_val, preform_downtime_fg, dwh_src_1_tmsp, machine_status_cd,
interval_min_hr) AS SELECT PRL1.production_line_id AS production_line_resource_item_sid,
 MATR1.material_id AS material_resource_item_sid,
 MPL.shift_id,
 MPL.measurement_dt,
 MPL.measurement_tm,
 MPL.measurement_tmsp,
 CONCAT(CAST(PRL1.production_line_id AS STRING), PRM.production_line_parameter_cd) AS
 production_line_parameter_resource_item_sid,
 PRM.unit_id,
 PRM.granularity_type,
  CASE
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_5_MAG03_1344', 'MVA_L1_6_MAG02_03_1480', 'MVA_L3_5_MAG03_1344',
    'MVA_L4_5_MAG03_1344', 'MVA_L1_1_MAG02_1344', 'MVA_L2_1_MAG02_1344', 'MVA_L4_1_MAG02_1344', 'MVA_L5_1_MAG02_1344',
    'MVA_L6_1_MAG02_1344', 'MVA_L7_1_MAG03_1344', 'MVA_L8_1_MAG02_1344', 'MVA_L9_1_MAG02_1344', 'MVA_L10_1_MAG02_1216',
    'MVA_L11_1_MAG02_1216', 'MVA_L12_1_MAG02_1216', 'MVA_L13_1_MAG02_1216', 'MVA_L1_2_MAG02_880', 'MVA_L2_2_MAG02_880',
    'MVA_L3_2_MAG02_880', 'MVA_L4_2_MAG02_880', 'MVA_L5_2_MAG02_700', 'MVA_L6_2_MAG02_700', 'MVA_L7_2_MAG02_700',
    'MVA_L8_2_MAG02_700')
  THEN MPL.cavity_qty
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_5_MAG03_168', 'MVA_L1_6_MAG02_03_228', 'MVA_L3_5_MAG03_168',
    'MVA_L4_5_MAG03_168', 'MVA_L1_1_MAG02_168', 'MVA_L2_1_MAG02_168', 'MVA_L4_1_MAG02_168', 'MVA_L5_1_MAG02_168',
    'MVA_L6_1_MAG02_168', 'MVA_L7_1_MAG03_168', 'MVA_L8_1_MAG02_168', 'MVA_L9_1_MAG02_168', 'MVA_L10_1_MAG02_168',
    'MVA_L11_1_MAG02_168', 'MVA_L12_1_MAG02_168', 'MVA_L13_1_MAG02_168', 'MVA_L1_2_MAG02_168', 'MVA_L2_2_MAG02_168',
    'MVA_L3_2_MAG02_168', 'MVA_L4_2_MAG02_168', 'MVA_L5_2_MAG02_168', 'MVA_L6_2_MAG02_168', 'MVA_L7_2_MAG02_168',
    'MVA_L8_2_MAG02_168')
  THEN MPL.cycle_time_qty
  WHEN PRM.production_line_parameter_cd = 'CTA_IV'
  THEN MPL.cta_iv_meas
  WHEN PRM.production_line_parameter_cd = 'CTA_IV_Prediction_Fit'
  THEN MPL.cta_iv_prediction_fit_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_4_MAG01_786', 'MVA_L2_4_MAG01_960', 'MVA_L3_4_MAG01_0960')
  THEN MPL.inline_iv_meas
  WHEN PRM.production_line_parameter_cd = 'MVA_L1_4_MAG01_180'
  THEN MPL.pdu_return_temperature_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_4_MAG01_770', 'MVA_L2_4_MAG01_376', 'MVA_L3_4_MAG01_0376')
  THEN MPL.extruder_output_meas
  WHEN PRM.production_line_parameter_cd = 'MVA_L1_4_MAG01_284'
  THEN MPL.zone_18_melting_pump_meas
  WHEN PRM.production_line_parameter_cd = 'MVA_L1_4_MAG01_264'
  THEN MPL.zone_4_adapter_de_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_4_MAG02_224', 'MVA_L2_4_MAG02_0216', 'MVA_L3_4_MAG02_0216')
  THEN MPL.nitrogen_flow_ssp_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_4_MAG02_226', 'MVA_L2_4_MAG02_0740', 'MVA_L3_4_MAG02_0740')
  THEN MPL.target_retentiontime_ssp_qty
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_2_MAG01_0198', 'MVA_L2_2_MAG01_0172')
  THEN MPL.feeder_speed_pct
  WHEN PRM.production_line_parameter_cd = 'MVA_L1_3_MAG01_170'
  THEN MPL.bulk_material_balance_buffersilo_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_4_MAG02_210', 'MVA_L2_4_MAG02_0384', 'MVA_L3_4_MAG02_0384')
  THEN MPL.fill_level_reactor_vessel_pct
  WHEN PRM.production_line_parameter_cd = 'MVA_L1_2_MAG01_0202'
  THEN MPL.feeder_speed_meas
  WHEN PRM.production_line_parameter_cd = 'Throughput_Preform' AND MPL.throughput_preform_res_item_sid > - 1
  THEN MPL.throughput_preform_qty
  WHEN PRM.production_line_parameter_cd = 'MVA_L2_2_MAG01_0504'
  THEN MPL.bale_weight_qty
  WHEN PRM.production_line_parameter_cd = 'Bulk_material_balance_Washing'
  THEN MPL.bulk_material_balance_washing_meas
  WHEN PRM.production_line_parameter_cd = 'MVA_L1_7_MAG01_0674'
  THEN MPL.feeder_utilization_mill_unit_output_silo_pct
  WHEN PRM.production_line_parameter_cd = 'MVA_L1_7_MAG01_0682'
  THEN MPL.feeder_utilization_mill_unit_pct
  WHEN PRM.production_line_parameter_cd IN ('MVA_L2_3_MAG01_0312', 'MVA_L1_3_MAG01_192')
  THEN MPL.washer_tank_conduct_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_4_MAG02_208', 'MVA_L2_4_MAG02_0536', 'MVA_L3_4_MAG02_0536')
  THEN MPL.regranulation_vacuum_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_3_MAG01_190', 'MVA_L2_3_MAG01_0308')
  THEN MPL.washer_tank_temperature_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_3_MAG01_296')
  THEN MPL.bulk_material_balance_buffersilo_out_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_3_MAG01_250', 'MVA_L2_3_MAG01_0364')
  THEN MPL.rewasher_tank_temperature_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_1_MAG01_178', 'MVA_L2_1_MAG01_178', 'MVA_L4_1_MAG01_178',
    'MVA_L5_1_MAG01_178', 'MVA_L6_1_MAG01_178', 'MVA_L8_1_MAG01_178', 'MVA_L9_1_MAG01_178', 'MVA_L10_1_MAG01_178',
    'MVA_L11_1_MAG01_178', 'MVA_L12_1_MAG01_178', 'MVA_L13_1_MAG01_178')
  THEN MPL.eta_box_temperature_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_1_MAG01_200', 'MVA_L1_1_MAG01_464', 'MVA_L2_1_MAG01_200',
    'MVA_L4_1_MAG01_200', 'MVA_L5_1_MAG01_200', 'MVA_L6_1_MAG01_200', 'MVA_L7_1_MAG02_188', 'MVA_L8_1_MAG01_200',
    'MVA_L9_1_MAG01_200', 'MVA_L10_1_MAG01_200', 'MVA_L11_1_MAG01_200', 'MVA_L12_1_MAG01_200', 'MVA_L13_1_MAG01_200',
    'MVA_L13_1_MAG01_464')
  THEN MPL.heating_box_temperature_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_1_MAG01_222', 'MVA_L2_1_MAG01_222', 'MVA_L4_1_MAG01_222',
    'MVA_L5_1_MAG01_222', 'MVA_L6_1_MAG01_222', 'MVA_L7_1_MAG02_784', 'MVA_L8_1_MAG01_222', 'MVA_L9_1_MAG01_222',
    'MVA_L10_1_MAG01_222', 'MVA_L11_1_MAG01_222', 'MVA_L12_1_MAG01_222', 'MVA_L13_1_MAG01_222')
  THEN MPL.booster_temperature_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_1_MAG01_172', 'MVA_L2_1_MAG01_172', 'MVA_L4_1_MAG01_172',
    'MVA_L5_1_MAG01_172', 'MVA_L6_1_MAG01_172', 'MVA_L7_1_MAG02_228', 'MVA_L8_1_MAG01_172', 'MVA_L9_1_MAG01_172',
    'MVA_L10_1_MAG01_172', 'MVA_L11_1_MAG01_172', 'MVA_L12_1_MAG01_172', 'MVA_L13_1_MAG01_172')
  THEN MPL.dryer_dew_point_meas
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_1_MAG02_1344-still', 'MVA_L2_1_MAG02_1344-still',
    'MVA_L4_1_MAG02_1344-still', 'MVA_L5_1_MAG02_1344-still', 'MVA_L6_1_MAG02_1344-still', 'MVA_L7_1_MAG03_1344-still',
    'MVA_L8_1_MAG02_1344-still', 'MVA_L9_1_MAG02_1344-still', 'MVA_L10_1_MAG02_1216-still', 'MVA_L11_1_MAG02_1216-still'
    , 'MVA_L12_1_MAG02_1216-still', 'MVA_L13_1_MAG02_1216-still', 'MVA_L1_2_MAG02_880-still', 'MVA_L2_2_MAG02_880-still'
    , 'MVA_L3_2_MAG02_880-still', 'MVA_L4_2_MAG02_880-still', 'MVA_L5_2_MAG02_700-still', 'MVA_L6_2_MAG02_700-still',
    'MVA_L7_2_MAG02_700-still', 'MVA_L8_2_MAG02_700-still')
  THEN MPL.inop_cavity_qty
  WHEN PRM.production_line_parameter_cd IN ('Total_Cavity')
  THEN MPL.total_cavity_qty
  WHEN PRM.production_line_parameter_cd IN ('MVA_L1_1_MAG02_1352', 'MVA_L2_1_MAG02_1352', 'MVA_L4_1_MAG02_1352',
    'MVA_L5_1_MAG02_1352', 'MVA_L6_1_MAG02_1352', 'MVA_L7_1_MAG03_1352', 'MVA_L8_1_MAG02_1352', 'MVA_L9_1_MAG02_1352',
    'MVA_L10_1_MAG02_1224', 'MVA_L11_1_MAG02_1224', 'MVA_L12_1_MAG02_1224', 'MVA_L13_1_MAG02_1225')
  THEN MPL.content_container_qty
  ELSE NULL
  END AS parameter_value,
 COALESCE(TPPMR.min_val, TPPMR2.min_val) AS min_val,
 COALESCE(TPPMR.max_val, TPPMR2.max_val) AS max_val,
 COALESCE(TPPMR.target_val, TPPMR2.target_val) AS target_val,
 COALESCE(TPPMR.lower_warning_limit_val, TPPMR2.lower_warning_limit_val) AS lower_warning_limit_val,
 COALESCE(TPPMR.upper_warning_limit_val, TPPMR2.upper_warning_limit_val) AS upper_warning_limit_val,
 MPL.preform_downtime_fg,
 MPL.dwh_src_1_tmsp,
 MPL.machine_status_cd,
 MPL.interval_min_hr
FROM produktion_core.t_fact_measurement_production_line_1 AS MPL
 INNER JOIN produktion_core.t_dim_production_line_parameter_1 AS PRM ON MPL.production_line_resource_item_sid = PRM.production_line_resource_item_sid
  
 INNER JOIN produktion_core.t_dim_material_1 AS MATR1 ON MPL.material_resource_item_sid = MATR1.resource_item_sid
 INNER JOIN produktion_core.t_dim_production_line_1 AS PRL1 ON MPL.production_line_resource_item_sid = PRL1.resource_item_sid
  
 LEFT JOIN produktion_core.t_fact_threshold_parameter_per_material_rel_1 AS TPPMR ON PRM.resource_item_sid = TPPMR.production_line_parameter_resource_item_sid
    AND MPL.material_resource_item_sid = TPPMR.material_resource_item_sid
 INNER JOIN produktion_core.t_fact_threshold_parameter_per_material_rel_1 AS TPPMR2 ON PRM.resource_item_sid = TPPMR2.production_line_parameter_resource_item_sid
    AND - 1 = TPPMR2.material_resource_item_sid
WHERE PRM.production_line_parameter_cd IN ('MVA_L1_5_MAG03_1344', 'MVA_L1_6_MAG02_03_1480', 'MVA_L3_5_MAG03_1344',
   'MVA_L4_5_MAG03_1344', 'MVA_L1_5_MAG03_168', 'MVA_L1_6_MAG02_03_228', 'MVA_L3_5_MAG03_168', 'MVA_L4_5_MAG03_168',
   'CTA_IV', 'CTA_IV_Prediction_Fit', 'MVA_L1_4_MAG01_786', 'MVA_L2_4_MAG01_960', 'MVA_L3_4_MAG01_0960',
   'MVA_L1_4_MAG01_180', 'MVA_L1_4_MAG01_770', 'MVA_L2_4_MAG01_376', 'MVA_L3_4_MAG01_0376', 'MVA_L1_4_MAG01_284',
   'MVA_L1_4_MAG01_264', 'MVA_L1_4_MAG02_224', 'MVA_L2_4_MAG02_0216', 'MVA_L3_4_MAG02_0216', 'MVA_L1_4_MAG02_226',
   'MVA_L2_4_MAG02_0740', 'MVA_L3_4_MAG02_0740', 'MVA_L1_2_MAG01_0198', 'MVA_L2_2_MAG01_0172', 'MVA_L1_3_MAG01_170',
   'MVA_L1_4_MAG02_210', 'MVA_L2_4_MAG02_0384', 'MVA_L3_4_MAG02_0384', 'MVA_L1_2_MAG01_0202', 'Throughput_Preform',
   'MVA_L2_2_MAG01_0504', 'Bulk_material_balance_Washing', 'MVA_L1_7_MAG01_0674', 'MVA_L1_7_MAG01_0682',
   'MVA_L2_3_MAG01_0312', 'MVA_L1_3_MAG01_192', 'MVA_L1_4_MAG02_208', 'MVA_L2_4_MAG02_0536', 'MVA_L3_4_MAG02_0536',
   'MVA_L1_3_MAG01_190', 'MVA_L2_3_MAG01_0308', 'MVA_L1_3_MAG01_296', 'MVA_L1_3_MAG01_250', 'MVA_L2_3_MAG01_0364',
   'MVA_L1_1_MAG02_1344', 'MVA_L2_1_MAG02_1344', 'MVA_L4_1_MAG02_1344', 'MVA_L5_1_MAG02_1344', 'MVA_L6_1_MAG02_1344',
   'MVA_L7_1_MAG03_1344', 'MVA_L8_1_MAG02_1344', 'MVA_L9_1_MAG02_1344', 'MVA_L10_1_MAG02_1216', 'MVA_L11_1_MAG02_1216',
   'MVA_L12_1_MAG02_1216', 'MVA_L13_1_MAG02_1216', 'MVA_L1_2_MAG02_880', 'MVA_L2_2_MAG02_880', 'MVA_L3_2_MAG02_880',
   'MVA_L4_2_MAG02_880', 'MVA_L5_2_MAG02_700', 'MVA_L6_2_MAG02_700', 'MVA_L7_2_MAG02_700', 'MVA_L8_2_MAG02_700',
   'MVA_L1_1_MAG02_168', 'MVA_L2_1_MAG02_168', 'MVA_L4_1_MAG02_168', 'MVA_L5_1_MAG02_168', 'MVA_L6_1_MAG02_168',
   'MVA_L7_1_MAG03_168', 'MVA_L8_1_MAG02_168', 'MVA_L9_1_MAG02_168', 'MVA_L10_1_MAG02_168', 'MVA_L11_1_MAG02_168',
   'MVA_L12_1_MAG02_168', 'MVA_L13_1_MAG02_168', 'MVA_L1_2_MAG02_168', 'MVA_L2_2_MAG02_168', 'MVA_L3_2_MAG02_168',
   'MVA_L4_2_MAG02_168', 'MVA_L5_2_MAG02_168', 'MVA_L6_2_MAG02_168', 'MVA_L7_2_MAG02_168', 'MVA_L8_2_MAG02_168',
   'MVA_L1_1_MAG01_178', 'MVA_L2_1_MAG01_178', 'MVA_L4_1_MAG01_178', 'MVA_L5_1_MAG01_178', 'MVA_L6_1_MAG01_178',
   'MVA_L8_1_MAG01_178', 'MVA_L9_1_MAG01_178', 'MVA_L10_1_MAG01_178', 'MVA_L11_1_MAG01_178', 'MVA_L12_1_MAG01_178',
   'MVA_L13_1_MAG01_178', 'MVA_L1_1_MAG01_200', 'MVA_L1_1_MAG01_464', 'MVA_L2_1_MAG01_200', 'MVA_L4_1_MAG01_200',
   'MVA_L5_1_MAG01_200', 'MVA_L6_1_MAG01_200', 'MVA_L7_1_MAG02_188', 'MVA_L8_1_MAG01_200', 'MVA_L9_1_MAG01_200',
   'MVA_L10_1_MAG01_200', 'MVA_L11_1_MAG01_200', 'MVA_L12_1_MAG01_200', 'MVA_L13_1_MAG01_200', 'MVA_L13_1_MAG01_464',
   'MVA_L1_1_MAG01_222', 'MVA_L2_1_MAG01_222', 'MVA_L4_1_MAG01_222', 'MVA_L5_1_MAG01_222', 'MVA_L6_1_MAG01_222',
   'MVA_L7_1_MAG02_784', 'MVA_L8_1_MAG01_222', 'MVA_L9_1_MAG01_222', 'MVA_L10_1_MAG01_222', 'MVA_L11_1_MAG01_222',
   'MVA_L12_1_MAG01_222', 'MVA_L13_1_MAG01_222', 'MVA_L1_1_MAG01_172', 'MVA_L2_1_MAG01_172', 'MVA_L4_1_MAG01_172',
   'MVA_L5_1_MAG01_172', 'MVA_L6_1_MAG01_172', 'MVA_L7_1_MAG02_228', 'MVA_L8_1_MAG01_172', 'MVA_L9_1_MAG01_172',
   'MVA_L10_1_MAG01_172', 'MVA_L11_1_MAG01_172', 'MVA_L12_1_MAG01_172', 'MVA_L13_1_MAG01_172',
   'MVA_L1_1_MAG02_1344-still', 'MVA_L2_1_MAG02_1344-still', 'MVA_L4_1_MAG02_1344-still', 'MVA_L5_1_MAG02_1344-still',
   'MVA_L6_1_MAG02_1344-still', 'MVA_L7_1_MAG03_1344-still', 'MVA_L8_1_MAG02_1344-still', 'MVA_L9_1_MAG02_1344-still',
   'MVA_L10_1_MAG02_1216-still', 'MVA_L11_1_MAG02_1216-still', 'MVA_L12_1_MAG02_1216-still',
   'MVA_L13_1_MAG02_1216-still', 'MVA_L1_2_MAG02_880-still', 'MVA_L2_2_MAG02_880-still', 'MVA_L3_2_MAG02_880-still',
   'MVA_L4_2_MAG02_880-still', 'MVA_L5_2_MAG02_700-still', 'MVA_L6_2_MAG02_700-still', 'MVA_L7_2_MAG02_700-still',
   'MVA_L8_2_MAG02_700-still', 'Total_Cavity', 'MVA_L1_1_MAG02_1352', 'MVA_L2_1_MAG02_1352', 'MVA_L4_1_MAG02_1352',
   'MVA_L5_1_MAG02_1352', 'MVA_L6_1_MAG02_1352', 'MVA_L7_1_MAG03_1352', 'MVA_L8_1_MAG02_1352', 'MVA_L9_1_MAG02_1352',
   'MVA_L10_1_MAG02_1224', 'MVA_L11_1_MAG02_1224', 'MVA_L12_1_MAG02_1224', 'MVA_L13_1_MAG02_1225');