CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_plan_indicators_1 AS SELECT indicator_id,
 indicator_desc,
 indicator_valuetype,
 dat_dayend
FROM ldl_p_lew_core_ac.v_wawi_ref_plan_indicators_1 AS RPI;