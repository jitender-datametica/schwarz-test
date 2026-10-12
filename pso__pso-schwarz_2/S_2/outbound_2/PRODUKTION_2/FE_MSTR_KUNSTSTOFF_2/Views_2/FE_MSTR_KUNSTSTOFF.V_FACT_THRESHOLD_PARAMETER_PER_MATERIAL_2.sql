CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_fact_threshold_parameter_per_material_2 (production_line_parameter_resource_item_sid
, production_line_resource_item_sid, material_resource_item_sid, min_val, max_val, lower_warning_limit_val,
upper_warning_limit_val, target_val) AS SELECT CONCAT(CAST(PRL1.production_line_id AS STRING), PLPT.production_line_parameter_cd
  ) AS production_line_parameter_resource_item_sid,
 PRL1.production_line_id AS production_line_resource_item_sid,
 MATR1.material_id AS material_resource_item_sid,
 THRES.min_val,
 THRES.max_val,
 THRES.lower_warning_limit_val,
 THRES.upper_warning_limit_val AS upper_warning_limit_va,
 THRES.target_val
FROM produktion_core.t_fact_threshold_parameter_per_material_rel_2 AS THRES
 INNER JOIN produktion_core.t_dim_production_line_parameter_2 AS PLPT ON THRES.production_line_parameter_resource_item_sid
   = PLPT.resource_item_sid
 INNER JOIN produktion_core.t_dim_material_2 AS MATR1 ON THRES.material_resource_item_sid = MATR1.resource_item_sid
 INNER JOIN produktion_core.t_dim_production_line_2 AS PRL1 ON PLPT.production_line_resource_item_sid = PRL1.resource_item_sid
  
WHERE PLPT.production_line_parameter_cd IN ('MVA_L1_5_MAG03_1344', 'MVA_L1_6_MAG02_03_1480', 'MVA_L3_5_MAG03_1344',
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
   'MVA_L1_1_MAG02_1344 _still', 'MVA_L2_1_MAG02_1344_still', 'MVA_L4_1_MAG02_1344_still', 'MVA_L5_1_MAG02_1344_still',
   'MVA_L6_1_MAG02_1344_still', 'MVA_L7_1_MAG03_1344_still', 'MVA_L8_1_MAG02_1344_still', 'MVA_L9_1_MAG02_1344_still',
   'MVA_L10_1_MAG02_1216_still', 'MVA_L11_1_MAG02_1216_still', 'MVA_L12_1_MAG02_1216_still',
   'MVA_L13_1_MAG02_1216_still', 'MVA_L1_2_MAG02_880_still', 'MVA_L2_2_MAG02_880_still', 'MVA_L3_2_MAG02_880_still',
   'MVA_L4_2_MAG02_880_still', 'MVA_L5_2_MAG02_700_still', 'MVA_L6_2_MAG02_700_still', 'MVA_L7_2_MAG02_700_still',
   'MVA_L8_2_MAG02_700_still', 'Total_Cavity', 'MVA_L1_1_MAG02_1352', 'MVA_L2_1_MAG02_1352', 'MVA_L4_1_MAG02_1352',
   'MVA_L5_1_MAG02_1352', 'MVA_L6_1_MAG02_1352', 'MVA_L7_1_MAG03_1352', 'MVA_L8_1_MAG02_1352', 'MVA_L9_1_MAG02_1352',
   'MVA_L10_1_MAG02_1224', 'MVA_L11_1_MAG02_1224', 'MVA_L12_1_MAG02_1224', 'MVA_L13_1_MAG02_1225');