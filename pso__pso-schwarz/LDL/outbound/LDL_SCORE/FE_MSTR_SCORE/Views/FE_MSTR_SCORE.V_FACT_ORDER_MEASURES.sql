/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_fact_order_measures
Description		  | This view records all deliveries to a crossdock
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_fact_order_measures (delivering_supplier_sid,
delivering_supplier_site_sid, main_crossdock_sid, main_crossdock_operating_hauler_sid, executing_hauler_sid,
receiving_wh_sid, product_sid, product_variant_sid, bus_country_cd, logistic_temp_cd, logistic_type_cd,
missing_reason_cd, pallet_type_cd, double_deck_fg, cal_dt, case_cnt, pallet_cnt, std_pallet_qty, missing_pallet_cnt,
volume_meas, weight_meas) AS SELECT delivering_supplier_sid,
 delivering_supplier_site_sid,
 main_crossdock_sid,
 main_crossdock_operating_hauler_sid,
 executing_hauler_sid,
 receiving_wh_sid,
 product_sid,
 product_variant_sid,
 bus_country_cd,
 logistic_temp_cd,
 logistic_type_cd,
 missing_reason_cd,
 pallet_type_cd,
 double_deck_fg,
 cal_dt,
 case_cnt,
 pallet_cnt,
 std_pallet_qty,
 missing_pallet_cnt,
 volume_meas,
 weight_meas
FROM ldl_score_core.t_fact_order_measures;