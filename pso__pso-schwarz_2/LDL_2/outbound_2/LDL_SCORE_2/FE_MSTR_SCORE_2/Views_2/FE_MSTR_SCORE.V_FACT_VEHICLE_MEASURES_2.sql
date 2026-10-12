/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_fact_vehicle_measures_2
Description		  | This view lists the vehicles with which a disposition is executed
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_fact_vehicle_measures_2 (inbound_dispo_order_sid, transport_unit_seq,
executing_hauler_sid, receiving_wh_sid, main_crossdock_sid, supplier_site_sid, logistic_type_cd, logistic_temp_cd,
bus_country_cd, means_of_transport_cd, cal_dt, transport_vehicle_descr, vehicle_count, planned_order_dt) AS SELECT
 inbound_dispo_order_sid,
 transport_unit_seq,
 executing_hauler_sid,
 receiving_wh_sid,
 main_crossdock_sid,
 supplier_site_sid,
 logistic_type_cd,
 logistic_temp_cd,
 bus_country_cd,
 means_of_transport_cd,
 cal_dt,
 transport_vehicle_descr,
 vehicle_cnt AS vehicle_count,
 planned_order_dt
FROM ldl_score_core.t_fact_vehicle_measures_2;