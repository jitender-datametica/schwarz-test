/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_fact_normalized_order_measures
Description		  | Order measures normalized on pallet
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_fact_normalized_order_measures (delivering_supplier_sid,
delivering_supplier_site_sid, main_crossdock_sid, main_crossdock_operating_hauler_sid, receiving_wh_sid, product_sid,
product_variant_sid, bus_country_cd, logistic_temp_cd, logistic_type_cd, cal_dt, normalized_pallet_cnt,
normalized_case_cnt, normalized_volume_meas, normalized_weight_meas) AS SELECT delivering_supplier_sid,
 delivering_supplier_site_sid,
 main_crossdock_sid,
 main_crossdock_operating_hauler_sid,
 receiving_wh_sid,
 product_sid,
 product_variant_sid,
 bus_country_cd,
 logistic_temp_cd,
 logistic_type_cd,
 cal_dt,
 normalized_pallet_cnt,
 normalized_case_cnt,
 normalized_volume_meas,
 normalized_weight_meas
FROM ldl_score_core.t_fact_normalized_order_measures;