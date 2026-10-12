/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	V_QUINTIQ_REPORTEDKPI_WEEKLY_SSBI_1
Description		|	QUINTIQ REPORTEDKPI data for SSBI on Week Level
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedkpi_weekly_ssbi_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), lidl_country
OPTIONS(description='Country_1 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), cy_week, pallets_total, pallet_stores, pallet_non_stores, count_trucks_total
, count_trucks_store_delivery, count_trucks_non_store_delivery, count_shifts_total, count_shifts_store_delivery,
count_shifts_non_store_delivery, use_time_in_sec, use_time_in_min, use_time_in_hr, use_time_in_sec_store_delivery,
use_time_in_min_store_delivery, use_time_in_hr_store_delivery, use_time_in_sec_non_store_delivery,
use_time_in_min_non_store_delivery, use_time_in_hr_non_store_delivery, kilometer, kilometer_store_delivery,
kilometer_non_store_delivery, dv_diesel_total, dv_diesel_store_delivery, dv_diesel_non_store_delivery, dv_lng_total,
dv_lng_store_delivery, dv_lng_non_store_delivery, dv_cng_total, dv_cng_store_delivery, dv_cng_non_store_delivery,
dv_elektro_total, dv_elektro_store_delivery, dv_elektro_non_store_delivery, dv_wasserstoff_total,
dv_wasserstoff_store_delivery, dv_wasserstoff_non_store_delivery, count_tours_total, count_tours_store_delivery,
count_tours_non_store_delivery, tours_per_shift_total, tours_per_shift_store_delivery,
tours_per_shift_non_store_delivery, pallets_planned_on_shift_store_delivery, pallets_planned_on_shift_non_store_delivery
, pallets_per_shift_total, pallets_per_shift_store_delivery, pallets_per_shift_non_store_delivery,
total_num_pallets_planned, total_num_pallets_planned_on_tour_store_deliveries,
total_num_pallets_planned_on_tour_non_store_deliveries, total_num_pallets_capacity,
total_num_pallets_capacity_on_tour_store_deliveries, total_num_pallets_capacity_on_tour_non_store_deliveries,
utilization_percent_total, utilization_percent_store_delivery, utilization_percent_non_store_delivery,
km_per_pallet_total, km_per_pallet_store_delivery, km_per_pallet_non_store_delivery, use_time_in_sec_per_shift,
use_time_in_min_per_shift, use_time_in_hr_per_shift, use_time_in_sec_per_shift_store_delivery,
use_time_in_min_per_shift_store_delivery, use_time_in_hr_per_shift_store_delivery,
use_time_in_sec_per_shift_non_store_delivery, use_time_in_min_per_shift_non_store_delivery,
use_time_in_hr_per_shift_non_store_delivery, use_time_in_sec_per_truck, use_time_in_min_per_truck,
use_time_in_hr_per_truck, use_time_in_sec_per_truck_store_delivery, use_time_in_min_per_truck_store_delivery,
use_time_in_hr_per_truck_store_delivery, use_time_in_sec_per_truck_non_store_delivery,
use_time_in_min_per_truck_non_store_delivery, use_time_in_hr_per_truck_non_store_delivery, share_double_shifts,
share_double_shifts_store_delivery, share_double_shifts_non_store_delivery,
totalnumpalletswithisdeliverytoexternalwarehouseplannedexcldummy,
totalnumpalletswithisdeliverytointernalwarehouseplannedexcldummy,
totalnumpalletswithisdeliverytononfoodwarehouseplannedexcldummy, totalnumpalletswithisstocktransferplannedexcldummy,
totalnumpalletswithisreceivingcrossdockingplannedexcldummy, totalnumpalletswithispickingcrossdockingplannedexcldummy) AS
SELECT SSBI.client_id,
 SSBI.lidl_country,
 SSBI.source_system,
 SSBI.wh_id,
 CAL.cy_week,
 SUM(SSBI.pallets_total) AS pallets_total_wk,
 SUM(SSBI.pallet_stores) AS pallet_stores_wk,
 SUM(SSBI.pallet_non_stores) AS pallet_non_stores_wk,
 SUM(SSBI.count_trucks_total) AS count_trucks_total_wk,
 SUM(SSBI.count_trucks_store_delivery) AS count_trucks_store_delivery_wk,
 SUM(SSBI.count_trucks_non_store_delivery) AS count_trucks_non_store_delivery_wk,
 SUM(SSBI.count_shifts_total) AS count_shifts_total_wk,
 SUM(SSBI.count_shifts_store_delivery) AS count_shifts_store_delivery_wk,
 SUM(SSBI.count_shifts_non_store_delivery) AS count_shifts_non_store_delivery_wk,
 SUM(SSBI.use_time_in_sec) AS use_time_in_sec_wk,
 SUM(SSBI.use_time_in_min) AS use_time_in_min_wk,
 SUM(SSBI.use_time_in_hr) AS use_time_in_hr_wk,
 SUM(SSBI.use_time_in_sec_store_delivery) AS use_time_in_sec_store_delivery_wk,
 SUM(SSBI.use_time_in_min_store_delivery) AS use_time_in_min_store_delivery_wk,
 SUM(SSBI.use_time_in_hr_store_delivery) AS use_time_in_hr_store_delivery_wk,
 SUM(SSBI.use_time_in_sec_non_store_delivery) AS use_time_in_sec_non_store_delivery_wk,
 SUM(SSBI.use_time_in_min_non_store_delivery) AS use_time_in_min_non_store_delivery_wk,
 SUM(SSBI.use_time_in_hr_non_store_delivery) AS use_time_in_hr_non_store_delivery_wk,
 SUM(SSBI.kilometer) AS kilometer_wk,
 SUM(SSBI.kilometer_store_delivery) AS kilometer_store_delivery_wk,
 SUM(SSBI.kilometer_non_store_delivery) AS kilometer_non_store_delivery_wk,
 SUM(SSBI.dv_diesel_total) AS dv_diesel_total_wk,
 SUM(SSBI.dv_diesel_store_delivery) AS dv_diesel_store_delivery_wk,
 SUM(SSBI.dv_diesel_non_store_delivery) AS dv_diesel_non_store_delivery_wk,
 SUM(SSBI.dv_lng_total) AS dv_lng_total_wk,
 SUM(SSBI.dv_lng_store_delivery) AS dv_lng_store_delivery_wk,
 SUM(SSBI.dv_lng_non_store_delivery) AS dv_lng_non_store_delivery_wk,
 SUM(SSBI.dv_cng_total) AS dv_cng_total_wk,
 SUM(SSBI.dv_cng_store_delivery) AS dv_cng_store_delivery_wk,
 SUM(SSBI.dv_cng_non_store_delivery) AS dv_cng_non_store_delivery_wk,
 SUM(SSBI.dv_elektro_total) AS dv_elektro_total_wk,
 SUM(SSBI.dv_elektro_store_delivery) AS dv_elektro_store_delivery_wk,
 SUM(SSBI.dv_elektro_non_store_delivery) AS dv_elektro_non_store_delivery_wk,
 SUM(SSBI.dv_wasserstoff_total) AS dv_wasserstoff_total_wk,
 SUM(SSBI.dv_wasserstoff_store_delivery) AS dv_wasserstoff_store_delivery_wk,
 SUM(SSBI.dv_wasserstoff_non_store_delivery) AS dv_wasserstoff_non_store_delivery_wk,
 SUM(SSBI.count_tours_total) AS count_tours_total_wk,
 SUM(SSBI.count_tours_store_delivery) AS count_tours_store_delivery_wk,
 SUM(SSBI.count_tours_non_store_delivery) AS count_tours_non_store_delivery_wk,
 IFNULL(SUM(SSBI.count_tours_total) / IF(SUM(SSBI.count_shifts_total) = 0, NULL, SUM(SSBI.count_shifts_total)), 0) AS
 tours_per_shift_total_wk,
 IFNULL(SUM(SSBI.count_tours_store_delivery) / IF(SUM(SSBI.count_shifts_store_delivery) = 0, NULL, SUM(SSBI.count_shifts_store_delivery
     )), 0) AS tours_per_shift_store_delivery_wk,
 IFNULL(SUM(SSBI.count_tours_non_store_delivery) / IF(SUM(SSBI.count_shifts_non_store_delivery) = 0, NULL, SUM(SSBI.count_shifts_non_store_delivery
     )), 0) AS tours_per_shift_non_store_delivery_wk,
 SUM(SSBI.pallets_planned_on_shift_store_delivery) AS pallets_planned_on_shift_store_delivery_wk,
 SUM(SSBI.pallets_planned_on_shift_non_store_delivery) AS pallets_planned_on_shift_non_store_delivery_wk,
 IFNULL(SUM(SSBI.pallets_total) / IF(SUM(SSBI.count_shifts_total) = 0, NULL, SUM(SSBI.count_shifts_total)), 0) AS
 pallets_per_shift_total_wk,
 IFNULL(SUM(SSBI.pallets_planned_on_shift_store_delivery) / IF(SUM(SSBI.count_shifts_store_delivery) = 0, NULL, SUM(SSBI
     .count_shifts_store_delivery)), 0) AS pallets_per_shift_store_delivery_wk,
 IFNULL(SUM(SSBI.pallets_planned_on_shift_non_store_delivery) / IF(SUM(SSBI.count_shifts_non_store_delivery) = 0, NULL,
    SUM(SSBI.count_shifts_non_store_delivery)), 0) AS pallets_per_shift_non_store_delivery_wk,
 SUM(SSBI.total_num_pallets_planned) AS total_num_pallets_planned_wk,
 SUM(SSBI.total_num_pallets_planned_on_tour_store_deliveries) AS total_num_pallets_planned_on_tour_store_deliveries_wk,
 SUM(SSBI.total_num_pallets_planned_on_tour_non_store_deliveries) AS
 total_num_pallets_planned_on_tour_non_store_deliveries_wk,
 SUM(SSBI.total_num_pallets_capacity) AS total_num_pallets_capacity_wk,
 SUM(SSBI.total_num_pallets_capacity_on_tour_store_deliveries) AS total_num_pallets_capacity_on_tour_store_deliveries_wk
 ,
 SUM(SSBI.total_num_pallets_capacity_on_tour_non_store_deliveries) AS
 total_num_pallets_capacity_on_tour_non_store_deliveries_wk,
 IFNULL(SUM(SSBI.total_num_pallets_planned) / IF(SUM(SSBI.total_num_pallets_capacity) = 0, NULL, SUM(SSBI.total_num_pallets_capacity
      )) * 100, 0) AS utilization_percent_total_wk,
 IFNULL(SUM(SSBI.total_num_pallets_planned_on_tour_store_deliveries) / IF(SUM(SSBI.total_num_pallets_capacity_on_tour_store_deliveries
       ) = 0, NULL, SUM(SSBI.total_num_pallets_capacity_on_tour_store_deliveries)) * 100, 0) AS
 utilization_percent_store_delivery_wk,
 IFNULL(SUM(SSBI.total_num_pallets_planned_on_tour_non_store_deliveries) / IF(SUM(SSBI.total_num_pallets_capacity_on_tour_non_store_deliveries
       ) = 0, NULL, SUM(SSBI.total_num_pallets_capacity_on_tour_non_store_deliveries)) * 100, 0) AS
 utilization_percent_non_store_delivery_wk,
 IFNULL(SUM(SSBI.kilometer) / IF(SUM(SSBI.total_num_pallets_planned) = 0, NULL, SUM(SSBI.total_num_pallets_planned)), 0
  ) AS km_per_pallet_total_wk,
 IFNULL(SUM(SSBI.kilometer_store_delivery) / IF(SUM(SSBI.total_num_pallets_planned_on_tour_store_deliveries) = 0, NULL,
    SUM(SSBI.total_num_pallets_planned_on_tour_store_deliveries)), 0) AS km_per_pallet_store_delivery_wk,
 IFNULL(SUM(SSBI.kilometer_non_store_delivery) / IF(SUM(SSBI.total_num_pallets_planned_on_tour_non_store_deliveries) = 0
     , NULL, SUM(SSBI.total_num_pallets_planned_on_tour_non_store_deliveries)), 0) AS
 km_per_pallet_non_store_delivery_wk,
 SUM(SSBI.use_time_in_sec_per_shift) AS use_time_in_sec_per_shift_wk,
 SUM(SSBI.use_time_in_min_per_shift) AS use_time_in_min_per_shift_wk,
 SUM(SSBI.use_time_in_hr_per_shift) AS use_time_in_hr_per_shift_wk,
 SUM(SSBI.use_time_in_sec_per_shift_store_delivery) AS use_time_in_sec_per_shift_store_delivery_wk,
 SUM(SSBI.use_time_in_min_per_shift_store_delivery) AS use_time_in_min_per_shift_store_delivery_wk,
 SUM(SSBI.use_time_in_hr_per_shift_store_delivery) AS use_time_in_hr_per_shift_store_delivery_wk,
 SUM(SSBI.use_time_in_sec_per_shift_non_store_delivery) AS use_time_in_sec_per_shift_non_store_delivery_wk,
 SUM(SSBI.use_time_in_min_per_shift_non_store_delivery) AS use_time_in_min_per_shift_non_store_delivery_wk,
 SUM(SSBI.use_time_in_hr_per_shift_non_store_delivery) AS use_time_in_hr_per_shift_non_store_delivery_wk,
 SUM(SSBI.use_time_in_sec_per_truck) AS use_time_in_sec_per_truck_wk,
 SUM(SSBI.use_time_in_min_per_truck) AS use_time_in_min_per_truck_wk,
 SUM(SSBI.use_time_in_hr_per_truck) AS use_time_in_hr_per_truck_wk,
 SUM(SSBI.use_time_in_sec_per_truck_store_delivery) AS use_time_in_sec_per_truck_store_delivery_wk,
 SUM(SSBI.use_time_in_min_per_truck_store_delivery) AS use_time_in_min_per_truck_store_delivery_wk,
 SUM(SSBI.use_time_in_hr_per_truck_store_delivery) AS use_time_in_hr_per_truck_store_delivery_wk,
 SUM(SSBI.use_time_in_sec_per_truck_non_store_delivery) AS use_time_in_sec_per_truck_non_store_delivery_wk,
 SUM(SSBI.use_time_in_min_per_truck_non_store_delivery) AS use_time_in_min_per_truck_non_store_delivery_wk,
 SUM(SSBI.use_time_in_hr_per_truck_non_store_delivery) AS use_time_in_hr_per_truck_non_store_delivery_wk,
 IFNULL((SUM(SSBI.count_shifts_total) / IF(SUM(SSBI.count_trucks_total) = 0, NULL, SUM(SSBI.count_trucks_total)) - 1) *
   100, 0) AS share_double_shifts_wk,
 IFNULL((SUM(SSBI.count_shifts_store_delivery) / IF(SUM(SSBI.count_trucks_store_delivery) = 0, NULL, SUM(SSBI.count_trucks_store_delivery
        )) - 1) * 100, 0) AS share_double_shifts_store_delivery_wk,
 IFNULL((SUM(SSBI.count_shifts_non_store_delivery) / IF(SUM(SSBI.count_trucks_non_store_delivery) = 0, NULL, SUM(SSBI.count_trucks_non_store_delivery
        )) - 1) * 100, 0) AS share_double_shifts_non_store_delivery_wk,
 SUM(SSBI.totalnumpalletswithisdeliverytoexternalwarehouseplannedexcldummy) AS
 totalnumpalletswithisdeliverytoexternalwarehouseplannedexcldummy_wk,
 SUM(SSBI.totalnumpalletswithisdeliverytointernalwarehouseplannedexcldummy) AS
 totalnumpalletswithisdeliverytointernalwarehouseplannedexcldummy_wk,
 SUM(SSBI.totalnumpalletswithisdeliverytononfoodwarehouseplannedexcldummy) AS
 totalnumpalletswithisdeliverytononfoodwarehouseplannedexcldummy_wk,
 SUM(SSBI.totalnumpalletswithisstocktransferplannedexcldummy) AS totalnumpalletswithisstocktransferplannedexcldummy_wk,
 SUM(SSBI.totalnumpalletswithisreceivingcrossdockingplannedexcldummy) AS
 totalnumpalletswithisreceivingcrossdockingplannedexcldummy_wk,
 SUM(SSBI.totalnumpalletswithispickingcrossdockingplannedexcldummy) AS
 totalnumpalletswithispickingcrossdockingplannedexcldummy_wk
FROM ldl_logop_fe_mstr_logop.v_quintiq_reportedkpi_ssbi_1 AS SSBI
 INNER JOIN ldl_logop_data.t_cal_calendarday_1 AS CAL ON SSBI.delivery_dt = CAL.cal_dt
GROUP BY SSBI.client_id,
 SSBI.lidl_country,
 SSBI.source_system,
 SSBI.wh_id,
 CAL.cy_week;