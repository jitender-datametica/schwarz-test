/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_fact_normalized_vehicle_measures
Description		  | Vehicle measures normalized on pallet
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_fact_normalized_vehicle_measures (inbound_dispo_order_sid,
transport_unit_seq, executing_hauler_sid, receiving_wh_sid, main_crossdock_sid, supplier_site_sid, logistic_type_cd,
logistic_temp_cd, bus_country_cd, means_of_transport_cd, cal_dt, transport_vehicle_descr, avg_vehicle_count) AS SELECT
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
 avg_vehicle_cnt AS avg_vehicle_count
FROM ldl_score_core.t_fact_normalized_vehicle_measures;