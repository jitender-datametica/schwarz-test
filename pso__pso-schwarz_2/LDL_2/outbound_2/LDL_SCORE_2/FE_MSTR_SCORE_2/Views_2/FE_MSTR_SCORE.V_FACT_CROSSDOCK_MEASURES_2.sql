/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_fact_crossdock_measures_2
Description		  | This factual table basically captures the capacities of crossdocks
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_fact_crossdock_measures_2 (crossdock_sid, operating_hauler_sid,
logistic_temp_cd, transport_service_type_cd, pallet_type_cd, cal_dt, first_day_of_time_range_fg,
day_accurate_delivery_fg, pallet_cnt, receiving_bus_country_cd, weighted_pallet_cnt, adv_pallet_cnt,
transport_storage_space_qty, transport_storage_space_weighted_qty, logistics_storage_space_qty,
logistics_storage_space_weighted_qty, site_capacity_asis_qty, site_capacity_hist_qty) AS SELECT crossdock_sid,
 operating_hauler_sid,
 logistic_temp_cd,
 transport_service_type_cd,
 pallet_type_cd,
 cal_dt,
 first_day_of_time_range_fg,
 day_accurate_delivery_fg,
 pallet_cnt,
 receiving_bus_country_cd,
 weighted_pallet_cnt,
 adv_pallet_cnt,
 transport_storage_space_qty,
 transport_storage_space_weighted_qty,
 logistics_storage_space_qty,
 logistics_storage_space_weighted_qty,
 site_capacity_asis_qty,
 site_capacity_hist_qty
FROM ldl_score_core.t_fact_crossdock_measures_2;