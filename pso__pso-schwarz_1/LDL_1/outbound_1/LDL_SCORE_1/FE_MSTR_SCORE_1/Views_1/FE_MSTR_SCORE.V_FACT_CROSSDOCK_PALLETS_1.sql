/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_fact_crossdock_pallets_1
Description		  | Provides the information from which crossdock the products com from and where they go
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_fact_crossdock_pallets_1 (current_crossdock_sid,
current_crossdock_start_from_dt, current_crossdock_start_to_dt, next_crossdock_sid, next_crossdock_end_from_dt,
next_crossdock_end_to_dt, previous_crossdock_sid, previous_crossdock_start_from_dt, previous_crossdock_start_to_dt,
delivering_supplier_sid, delivering_supplier_site_sid, receiving_wh_sid, product_sid, product_variant_sid,
bus_country_cd, logistic_temp_cd, logistic_type_cd, pallet_type_cd, cal_dt, pallet_cnt) AS SELECT current_crossdock_sid
 ,
 current_crossdock_start_from_dt,
 current_crossdock_start_to_dt,
 next_crossdock_sid,
 next_crossdock_end_from_dt,
 next_crossdock_end_to_dt,
 previous_crossdock_sid,
 previous_crossdock_start_from_dt,
 previous_crossdock_start_to_dt,
 delivering_supplier_sid,
 delivering_supplier_site_sid,
 receiving_wh_sid,
 product_sid,
 product_variant_sid,
 bus_country_cd,
 logistic_temp_cd,
 logistic_type_cd,
 pallet_type_cd,
 cal_dt,
 pallet_cnt
FROM ldl_score_core.t_fact_crossdock_pallets_1;