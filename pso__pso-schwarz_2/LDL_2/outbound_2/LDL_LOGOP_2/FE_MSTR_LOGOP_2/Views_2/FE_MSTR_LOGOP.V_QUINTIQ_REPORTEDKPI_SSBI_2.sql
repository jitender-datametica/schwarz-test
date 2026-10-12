/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	V_QUINTIQ_REPORTEDKPI_SSBI_2
Description		|	QUINTIQ REPORTEDKPI data for SSBI
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedkpi_ssbi_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), lidl_country
OPTIONS(description='Country_2 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), delivery_dt
OPTIONS(description='Inidcates the delivery day of the reporting line '), pallets_total, pallet_stores,
pallet_non_stores, count_trucks_total, count_trucks_store_delivery, count_trucks_non_store_delivery, count_shifts_total
, count_shifts_store_delivery, count_shifts_non_store_delivery, use_time_in_sec, use_time_in_min, use_time_in_hr,
use_time_in_sec_store_delivery, use_time_in_min_store_delivery, use_time_in_hr_store_delivery,
use_time_in_sec_non_store_delivery, use_time_in_min_non_store_delivery, use_time_in_hr_non_store_delivery, kilometer,
kilometer_store_delivery, kilometer_non_store_delivery, dv_diesel_total, dv_diesel_store_delivery,
dv_diesel_non_store_delivery, dv_lng_total, dv_lng_store_delivery, dv_lng_non_store_delivery, dv_cng_total,
dv_cng_store_delivery, dv_cng_non_store_delivery, dv_elektro_total, dv_elektro_store_delivery,
dv_elektro_non_store_delivery, dv_wasserstoff_total, dv_wasserstoff_store_delivery, dv_wasserstoff_non_store_delivery,
count_tours_total, count_tours_store_delivery, count_tours_non_store_delivery, tours_per_shift_total,
tours_per_shift_store_delivery, tours_per_shift_non_store_delivery, pallets_planned_on_shift_store_delivery,
pallets_planned_on_shift_non_store_delivery, pallets_per_shift_total, pallets_per_shift_store_delivery,
pallets_per_shift_non_store_delivery, total_num_pallets_planned, total_num_pallets_planned_on_tour_store_deliveries,
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
WITH GEO_MAP AS (SELECT DISTINCT client_id,
   wh_id,
    CASE
    WHEN client_id = 33
    THEN 'CONVERT'
    ELSE 'REGULAR'
    END AS conv_val,
    CASE
    WHEN client_id IN (1, 2, 3, 4, 5, 6, 8, 12, 14, 15, 16, 17, 18, 19, 21, 22, 23, 24, 26, 28, 32, 33, 34)
    THEN 'STANDARD_SHIFT'
    WHEN client_id IN (10, 11, 13, 20, 25, 27, 29, 31)
    THEN 'SHIFT_INDICATOR'
    ELSE NULL
    END AS shift_type
  FROM ldl_logop_data.t_quintiq_reportedkpi_2) (SELECT RK.client_id,
   RK.lidl_country,
   RK.source_system,
   RK.wh_id,
   RK.delivery_dt,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN RK.totalnum1apalletsplannedexcldummyconverted + RK.totalnum1bpalletsplannedexcldummyconverted
    ELSE RK.totalnum1bpalletsplannedexcldummy + RK.totalnum1apalletsplannedexcldummy
    END AS pallets_total,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN RK.totalnum1apalletsplannedexcldummyconverted
    ELSE RK.totalnum1apalletsplannedexcldummy
    END AS pallet_stores,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN RK.totalnum1bpalletsplannedexcldummyconverted
    ELSE RK.totalnum1bpalletsplannedexcldummy
    END AS pallet_non_stores,
   RK.totalroutesinuseexcldummy AS count_trucks_total,
   RK.totalroutesinusestoredeliveryexcldummy AS count_trucks_store_delivery,
   RK.totalroutesinusenonstoredeliveryexcldummy AS count_trucks_non_store_delivery,
    CASE
    WHEN GM.shift_type = 'SHIFT_INDICATOR'
    THEN RK.totalnumshiftindicatorexcldummy
    WHEN GM.shift_type = 'STANDARD_SHIFT'
    THEN RK.totalnumshiftsexcldummy
    ELSE NULL
    END AS count_shifts_total,
    CASE
    WHEN GM.shift_type = 'SHIFT_INDICATOR'
    THEN RK.totalnumshiftindicatorstoredeliveryexcldummy
    WHEN GM.shift_type = 'STANDARD_SHIFT'
    THEN RK.totalnumshiftsstoredeliveryexcldummy
    ELSE NULL
    END AS count_shifts_store_delivery,
    CASE
    WHEN GM.shift_type = 'SHIFT_INDICATOR'
    THEN RK.totalnumshiftindicatornonstoredeliveryexcldummy
    WHEN GM.shift_type = 'STANDARD_SHIFT'
    THEN RK.totalnumshiftsnonstoredeliveryexcldummy
    ELSE NULL
    END AS count_shifts_non_store_delivery,
      CAST(CASE
        WHEN RK.totaldurationexcldummy IS NOT NULL
        THEN IFNULL(SPLIT(RK.totaldurationexcldummy, ':')[SAFE_OFFSET(0)], '')
        ELSE NULL
        END AS FLOAT64) * 3600 + CAST(CASE
        WHEN RK.totaldurationexcldummy IS NOT NULL
        THEN IFNULL(SPLIT(RK.totaldurationexcldummy, ':')[SAFE_OFFSET(1)], '')
        ELSE NULL
        END AS FLOAT64) * 60 + CAST(CASE
      WHEN RK.totaldurationexcldummy IS NOT NULL
      THEN IFNULL(SPLIT(RK.totaldurationexcldummy, ':')[SAFE_OFFSET(2)], '')
      ELSE NULL
      END AS FLOAT64) AS use_time_in_sec,
     (CAST(CASE
          WHEN RK.totaldurationexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationexcldummy, ':')[SAFE_OFFSET(0)], '')
          ELSE NULL
          END AS FLOAT64) * 3600 + CAST(CASE
          WHEN RK.totaldurationexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationexcldummy, ':')[SAFE_OFFSET(1)], '')
          ELSE NULL
          END AS FLOAT64) * 60 + CAST(CASE
        WHEN RK.totaldurationexcldummy IS NOT NULL
        THEN IFNULL(SPLIT(RK.totaldurationexcldummy, ':')[SAFE_OFFSET(2)], '')
        ELSE NULL
        END AS FLOAT64)) / 60 AS use_time_in_min,
     (CAST(CASE
          WHEN RK.totaldurationexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationexcldummy, ':')[SAFE_OFFSET(0)], '')
          ELSE NULL
          END AS FLOAT64) * 3600 + CAST(CASE
          WHEN RK.totaldurationexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationexcldummy, ':')[SAFE_OFFSET(1)], '')
          ELSE NULL
          END AS FLOAT64) * 60 + CAST(CASE
        WHEN RK.totaldurationexcldummy IS NOT NULL
        THEN IFNULL(SPLIT(RK.totaldurationexcldummy, ':')[SAFE_OFFSET(2)], '')
        ELSE NULL
        END AS FLOAT64)) / 3600 AS use_time_in_hr,
      CAST(CASE
        WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
        THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
        ELSE NULL
        END AS FLOAT64) * 3600 + CAST(CASE
        WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
        THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
        ELSE NULL
        END AS FLOAT64) * 60 + CAST(CASE
      WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
      THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
      ELSE NULL
      END AS FLOAT64) AS use_time_in_sec_store_delivery,
     (CAST(CASE
          WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
          ELSE NULL
          END AS FLOAT64) * 3600 + CAST(CASE
          WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
          ELSE NULL
          END AS FLOAT64) * 60 + CAST(CASE
        WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
        THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
        ELSE NULL
        END AS FLOAT64)) / 60 AS use_time_in_min_store_delivery,
     (CAST(CASE
          WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
          ELSE NULL
          END AS FLOAT64) * 3600 + CAST(CASE
          WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
          ELSE NULL
          END AS FLOAT64) * 60 + CAST(CASE
        WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
        THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
        ELSE NULL
        END AS FLOAT64)) / 3600 AS use_time_in_hr_store_delivery,
      CAST(CASE
        WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
        THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
        ELSE NULL
        END AS FLOAT64) * 3600 + CAST(CASE
        WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
        THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
        ELSE NULL
        END AS FLOAT64) * 60 + CAST(CASE
      WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
      THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
      ELSE NULL
      END AS FLOAT64) AS use_time_in_sec_non_store_delivery,
     (CAST(CASE
          WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
          ELSE NULL
          END AS FLOAT64) * 3600 + CAST(CASE
          WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
          ELSE NULL
          END AS FLOAT64) * 60 + CAST(CASE
        WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
        THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
        ELSE NULL
        END AS FLOAT64)) / 60 AS use_time_in_min_non_store_delivery,
     (CAST(CASE
          WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
          ELSE NULL
          END AS FLOAT64) * 3600 + CAST(CASE
          WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
          ELSE NULL
          END AS FLOAT64) * 60 + CAST(CASE
        WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
        THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
        ELSE NULL
        END AS FLOAT64)) / 3600 AS use_time_in_hr_non_store_delivery,
   RK.totaluseddistanceexcldummy AS kilometer,
   RK.totaluseddistancestoredeliveryexcldummy AS kilometer_store_delivery,
   RK.totaluseddistancenonstoredeliveryexcldummy AS kilometer_non_store_delivery,
   RK.totaluseddistancedieselexcldummy AS dv_diesel_total,
   RK.totaluseddistancedieselstoredeliveryexcldummy AS dv_diesel_store_delivery,
   RK.totaluseddistancedieselnonstoredeliveryexcldummy AS dv_diesel_non_store_delivery,
   RK.totaluseddistancelngexcldummy AS dv_lng_total,
   RK.totaluseddistancelngstoredeliveryexcldummy AS dv_lng_store_delivery,
   RK.totaluseddistancelngnonstoredeliveryexcldummy AS dv_lng_non_store_delivery,
   RK.totaluseddistancecngexcldummy AS dv_cng_total,
   RK.totaluseddistancecngstoredeliveryexcldummy AS dv_cng_store_delivery,
   RK.totaluseddistancecngnonstoredeliveryexcldummy AS dv_cng_non_store_delivery,
   RK.totaluseddistanceelectricexcldummy AS dv_elektro_total,
   RK.totaluseddistanceelectricstoredeliveryexcldummy AS dv_elektro_store_delivery,
   RK.totaluseddistanceelectricnonstoredeliveryexcldummy AS dv_elektro_non_store_delivery,
   RK.totaluseddistancehydrogenexcldummy AS dv_wasserstoff_total,
   RK.totaluseddistancehydrogenstoredeliveryexcldummy AS dv_wasserstoff_store_delivery,
   RK.totaluseddistancehydrogennonstoredeliveryexcldummy AS dv_wasserstoff_non_store_delivery,
   RK.numtoursexcldummy AS count_tours_total,
   RK.numtoursstoredeliveryexcldummy AS count_tours_store_delivery,
   RK.numtoursnonstoredeliveryexcldummy AS count_tours_non_store_delivery,
    CASE
    WHEN GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL(RK.numtoursexcldummy / IF(RK.totalnumshiftindicatorexcldummy = 0, NULL, RK.totalnumshiftindicatorexcldummy
       ), 0)
    WHEN GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL(RK.numtoursexcldummy / IF(RK.totalnumshiftsexcldummy = 0, NULL, RK.totalnumshiftsexcldummy), 0)
    ELSE NULL
    END AS tours_per_shift_total,
    CASE
    WHEN GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL(RK.numtoursstoredeliveryexcldummy / IF(RK.totalnumshiftindicatorstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftindicatorstoredeliveryexcldummy
       ), 0)
    WHEN GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL(RK.numtoursstoredeliveryexcldummy / IF(RK.totalnumshiftsstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftsstoredeliveryexcldummy
       ), 0)
    ELSE NULL
    END AS tours_per_shift_store_delivery,
    CASE
    WHEN GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL(RK.numtoursnonstoredeliveryexcldummy / IF(RK.totalnumshiftindicatornonstoredeliveryexcldummy = 0, NULL,
       RK.totalnumshiftindicatornonstoredeliveryexcldummy), 0)
    WHEN GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL(RK.numtoursnonstoredeliveryexcldummy / IF(RK.totalnumshiftsnonstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftsnonstoredeliveryexcldummy
       ), 0)
    ELSE NULL
    END AS tours_per_shift_non_store_delivery,
    CASE
    WHEN GM.conv_val = 'CONVERT' AND GM.shift_type = 'SHIFT_INDICATOR'
    THEN RK.totalnumpalletsplannedonshiftindicatorstoredeliveriesexcldummyconverted
    WHEN GM.conv_val = 'CONVERT' AND GM.shift_type = 'STANDARD_SHIFT'
    THEN RK.totalnumpalletsplannedonshiftstoredeliveriesexcldummyconverted
    WHEN GM.conv_val = 'REGULAR' AND GM.shift_type = 'SHIFT_INDICATOR'
    THEN RK.totalnumpalletsplannedonshiftindicatorstoredeliveriesexcldummy
    WHEN GM.conv_val = 'REGULAR' AND GM.shift_type = 'STANDARD_SHIFT'
    THEN RK.totalnumpalletsplannedonshiftstoredeliveriesexcldummy
    ELSE NULL
    END AS pallets_planned_on_shift_store_delivery,
    CASE
    WHEN GM.conv_val = 'CONVERT' AND GM.shift_type = 'SHIFT_INDICATOR'
    THEN RK.totalnumpalletsplannedonshiftindicatornonstoredeliveriesexcldummyconverted
    WHEN GM.conv_val = 'CONVERT' AND GM.shift_type = 'STANDARD_SHIFT'
    THEN RK.totalnumpalletsplannedonshiftnonstoredeliveriesexcldummyconverted
    WHEN GM.conv_val = 'REGULAR' AND GM.shift_type = 'SHIFT_INDICATOR'
    THEN RK.totalnumpalletsplannedonshiftindicatornonstoredeliveriesexcldummy
    WHEN GM.conv_val = 'REGULAR' AND GM.shift_type = 'STANDARD_SHIFT'
    THEN RK.totalnumpalletsplannedonshiftnonstoredeliveriesexcldummy
    ELSE NULL
    END AS pallets_planned_on_shift_non_store_delivery,
    CASE
    WHEN GM.conv_val = 'CONVERT' AND GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL((RK.totalnum1apalletsplannedexcldummyconverted + RK.totalnum1bpalletsplannedexcldummyconverted) / IF(RK
        .totalnumshiftindicatorexcldummy = 0, NULL, RK.totalnumshiftindicatorexcldummy), 0)
    WHEN GM.conv_val = 'CONVERT' AND GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL((RK.totalnum1apalletsplannedexcldummyconverted + RK.totalnum1bpalletsplannedexcldummyconverted) / IF(RK
        .totalnumshiftsexcldummy = 0, NULL, RK.totalnumshiftsexcldummy), 0)
    WHEN GM.conv_val = 'REGULAR' AND GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL((RK.totalnum1bpalletsplannedexcldummy + RK.totalnum1apalletsplannedexcldummy) / IF(RK.totalnumshiftindicatorexcldummy
         = 0, NULL, RK.totalnumshiftindicatorexcldummy), 0)
    WHEN GM.conv_val = 'REGULAR' AND GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL((RK.totalnum1bpalletsplannedexcldummy + RK.totalnum1apalletsplannedexcldummy) / IF(RK.totalnumshiftsexcldummy
         = 0, NULL, RK.totalnumshiftsexcldummy), 0)
    ELSE NULL
    END AS pallets_per_shift_total,
    CASE
    WHEN GM.conv_val = 'CONVERT' AND GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL(RK.totalnumpalletsplannedonshiftindicatorstoredeliveriesexcldummyconverted / IF(RK.totalnumshiftindicatorstoredeliveryexcldummy
         = 0, NULL, RK.totalnumshiftindicatorstoredeliveryexcldummy), 0)
    WHEN GM.conv_val = 'CONVERT' AND GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL(RK.totalnumpalletsplannedonshiftstoredeliveriesexcldummyconverted / IF(RK.totalnumshiftsstoredeliveryexcldummy
         = 0, NULL, RK.totalnumshiftsstoredeliveryexcldummy), 0)
    WHEN GM.conv_val = 'REGULAR' AND GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL(RK.totalnumpalletsplannedonshiftindicatorstoredeliveriesexcldummy / IF(RK.totalnumshiftindicatorstoredeliveryexcldummy
         = 0, NULL, RK.totalnumshiftindicatorstoredeliveryexcldummy), 0)
    WHEN GM.conv_val = 'REGULAR' AND GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL(RK.totalnumpalletsplannedonshiftstoredeliveriesexcldummy / IF(RK.totalnumshiftsstoredeliveryexcldummy =
        0, NULL, RK.totalnumshiftsstoredeliveryexcldummy), 0)
    ELSE NULL
    END AS pallets_per_shift_store_delivery,
    CASE
    WHEN GM.conv_val = 'CONVERT' AND GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL(RK.totalnumpalletsplannedonshiftindicatornonstoredeliveriesexcldummyconverted / IF(RK.totalnumshiftindicatornonstoredeliveryexcldummy
         = 0, NULL, RK.totalnumshiftindicatornonstoredeliveryexcldummy), 0)
    WHEN GM.conv_val = 'CONVERT' AND GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL(RK.totalnumpalletsplannedonshiftnonstoredeliveriesexcldummyconverted / IF(RK.totalnumshiftsnonstoredeliveryexcldummy
         = 0, NULL, RK.totalnumshiftsnonstoredeliveryexcldummy), 0)
    WHEN GM.conv_val = 'REGULAR' AND GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL(RK.totalnumpalletsplannedonshiftindicatornonstoredeliveriesexcldummy / IF(RK.totalnumshiftindicatornonstoredeliveryexcldummy
         = 0, NULL, RK.totalnumshiftindicatornonstoredeliveryexcldummy), 0)
    WHEN GM.conv_val = 'REGULAR' AND GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL(RK.totalnumpalletsplannedonshiftnonstoredeliveriesexcldummy / IF(RK.totalnumshiftsnonstoredeliveryexcldummy
         = 0, NULL, RK.totalnumshiftsnonstoredeliveryexcldummy), 0)
    ELSE NULL
    END AS pallets_per_shift_non_store_delivery,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN RK.totalnumpalletsplannedontourstoredeliveriesexcldummyconverted + RK.totalnumpalletsplannedontournonstoredeliveriesexcldummyconverted
     
    ELSE RK.totalnumpalletsplannedontourstoredeliveriesexcldummy + RK.totalnumpalletsplannedontournonstoredeliveriesexcldummy
     
    END AS total_num_pallets_planned,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN RK.totalnumpalletsplannedontourstoredeliveriesexcldummyconverted
    ELSE RK.totalnumpalletsplannedontourstoredeliveriesexcldummy
    END AS total_num_pallets_planned_on_tour_store_deliveries,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN RK.totalnumpalletsplannedontournonstoredeliveriesexcldummyconverted
    ELSE RK.totalnumpalletsplannedontournonstoredeliveriesexcldummy
    END AS total_num_pallets_planned_on_tour_non_store_deliveries,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN RK.totalnumpalletscapacityontourstoredeliveriesexcldummyconverted + RK.totalnumpalletscapacityontournonstoredeliveriesexcldummyconverted
     
    ELSE RK.totalnumpalletscapacityontourstoredeliveriesexcldummy + RK.totalnumpalletscapacityontournonstoredeliveriesexcldummy
     
    END AS total_num_pallets_capacity,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN RK.totalnumpalletscapacityontourstoredeliveriesexcldummyconverted
    ELSE RK.totalnumpalletscapacityontourstoredeliveriesexcldummy
    END AS total_num_pallets_capacity_on_tour_store_deliveries,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN RK.totalnumpalletscapacityontournonstoredeliveriesexcldummyconverted
    ELSE RK.totalnumpalletscapacityontournonstoredeliveriesexcldummy
    END AS total_num_pallets_capacity_on_tour_non_store_deliveries,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN IFNULL((RK.totalnumpalletsplannedontournonstoredeliveriesexcldummyconverted + RK.totalnumpalletsplannedontourstoredeliveriesexcldummyconverted
         ) / IF(RK.totalnumpalletscapacityontourstoredeliveriesexcldummyconverted + RK.totalnumpalletscapacityontournonstoredeliveriesexcldummyconverted
           = 0, NULL, RK.totalnumpalletscapacityontourstoredeliveriesexcldummyconverted + RK.totalnumpalletscapacityontournonstoredeliveriesexcldummyconverted
         ) * 100, 0)
    ELSE IFNULL((RK.totalnumpalletsplannedontournonstoredeliveriesexcldummy + RK.totalnumpalletsplannedontourstoredeliveriesexcldummy
         ) / IF(RK.totalnumpalletscapacityontourstoredeliveriesexcldummy + RK.totalnumpalletscapacityontournonstoredeliveriesexcldummy
           = 0, NULL, RK.totalnumpalletscapacityontourstoredeliveriesexcldummy + RK.totalnumpalletscapacityontournonstoredeliveriesexcldummy
         ) * 100, 0)
    END AS utilization_percent_total,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN IFNULL(RK.totalnumpalletsplannedontourstoredeliveriesexcldummyconverted / IF(RK.totalnumpalletscapacityontourstoredeliveriesexcldummyconverted
          = 0, NULL, RK.totalnumpalletscapacityontourstoredeliveriesexcldummyconverted) * 100, 0)
    ELSE IFNULL(RK.totalnumpalletsplannedontourstoredeliveriesexcldummy / IF(RK.totalnumpalletscapacityontourstoredeliveriesexcldummy
          = 0, NULL, RK.totalnumpalletscapacityontourstoredeliveriesexcldummy) * 100, 0)
    END AS utilization_percent_store_delivery,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN IFNULL(RK.totalnumpalletsplannedontournonstoredeliveriesexcldummyconverted / IF(RK.totalnumpalletscapacityontournonstoredeliveriesexcldummyconverted
          = 0, NULL, RK.totalnumpalletscapacityontournonstoredeliveriesexcldummyconverted) * 100, 0)
    ELSE IFNULL(RK.totalnumpalletsplannedontournonstoredeliveriesexcldummy / IF(RK.totalnumpalletscapacityontournonstoredeliveriesexcldummy
          = 0, NULL, RK.totalnumpalletscapacityontournonstoredeliveriesexcldummy) * 100, 0)
    END AS utilization_percent_non_store_delivery,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN IFNULL(RK.totaluseddistanceexcldummy / IF(RK.totalnumpalletsplannedontourstoredeliveriesexcldummyconverted + RK
         .totalnumpalletsplannedontournonstoredeliveriesexcldummyconverted = 0, NULL, RK.totalnumpalletsplannedontourstoredeliveriesexcldummyconverted
         + RK.totalnumpalletsplannedontournonstoredeliveriesexcldummyconverted), 0)
    ELSE IFNULL(RK.totaluseddistanceexcldummy / IF(RK.totalnumpalletsplannedontourstoredeliveriesexcldummy + RK.totalnumpalletsplannedontournonstoredeliveriesexcldummy
          = 0, NULL, RK.totalnumpalletsplannedontourstoredeliveriesexcldummy + RK.totalnumpalletsplannedontournonstoredeliveriesexcldummy
        ), 0)
    END AS km_per_pallet_total,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN IFNULL(RK.totaluseddistancestoredeliveryexcldummy / IF(RK.totalnumpalletsplannedontourstoredeliveriesexcldummyconverted
         = 0, NULL, RK.totalnumpalletsplannedontourstoredeliveriesexcldummyconverted), 0)
    ELSE IFNULL(RK.totaluseddistancestoredeliveryexcldummy / IF(RK.totalnumpalletsplannedontourstoredeliveriesexcldummy
        = 0, NULL, RK.totalnumpalletsplannedontourstoredeliveriesexcldummy), 0)
    END AS km_per_pallet_store_delivery,
    CASE
    WHEN GM.conv_val = 'CONVERT'
    THEN IFNULL(RK.totaluseddistancenonstoredeliveryexcldummy / IF(RK.totalnumpalletsplannedontournonstoredeliveriesexcldummyconverted
         = 0, NULL, RK.totalnumpalletsplannedontournonstoredeliveriesexcldummyconverted), 0)
    ELSE IFNULL(RK.totaluseddistancenonstoredeliveryexcldummy / IF(RK.totalnumpalletsplannedontournonstoredeliveriesexcldummy
         = 0, NULL, RK.totalnumpalletsplannedontournonstoredeliveriesexcldummy), 0)
    END AS km_per_pallet_non_store_delivery,
    CASE
    WHEN GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL((CAST(CASE
            WHEN RK.totaluseddurationexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END AS FLOAT64) * 3600 + CAST(CASE
            WHEN RK.totaluseddurationexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(1)], '')
            ELSE NULL
            END AS FLOAT64) * 60 + CAST(CASE
          WHEN RK.totaluseddurationexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(2)], '')
          ELSE NULL
          END AS FLOAT64)) / IF(RK.totalnumshiftindicatorexcldummy = 0, NULL, RK.totalnumshiftindicatorexcldummy), 0)
    WHEN GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL((CAST(CASE
            WHEN RK.totaluseddurationexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END AS FLOAT64) * 3600 + CAST(CASE
            WHEN RK.totaluseddurationexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(1)], '')
            ELSE NULL
            END AS FLOAT64) * 60 + CAST(CASE
          WHEN RK.totaluseddurationexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(2)], '')
          ELSE NULL
          END AS FLOAT64)) / IF(RK.totalnumshiftsexcldummy = 0, NULL, RK.totalnumshiftsexcldummy), 0)
    ELSE NULL
    END AS use_time_in_sec_per_shift,
     CASE
     WHEN GM.shift_type = 'SHIFT_INDICATOR'
     THEN IFNULL((CAST(CASE
             WHEN RK.totaluseddurationexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS FLOAT64) * 3600 + CAST(CASE
             WHEN RK.totaluseddurationexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(1)], '')
             ELSE NULL
             END AS FLOAT64) * 60 + CAST(CASE
           WHEN RK.totaluseddurationexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(2)], '')
           ELSE NULL
           END AS FLOAT64)) / IF(RK.totalnumshiftindicatorexcldummy = 0, NULL, RK.totalnumshiftindicatorexcldummy), 0)
     WHEN GM.shift_type = 'STANDARD_SHIFT'
     THEN IFNULL((CAST(CASE
             WHEN RK.totaluseddurationexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS FLOAT64) * 3600 + CAST(CASE
             WHEN RK.totaluseddurationexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(1)], '')
             ELSE NULL
             END AS FLOAT64) * 60 + CAST(CASE
           WHEN RK.totaluseddurationexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(2)], '')
           ELSE NULL
           END AS FLOAT64)) / IF(RK.totalnumshiftsexcldummy = 0, NULL, RK.totalnumshiftsexcldummy), 0)
     ELSE NULL
     END / 60 AS use_time_in_min_per_shift,
     CASE
     WHEN GM.shift_type = 'SHIFT_INDICATOR'
     THEN IFNULL((CAST(CASE
             WHEN RK.totaluseddurationexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS FLOAT64) * 3600 + CAST(CASE
             WHEN RK.totaluseddurationexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(1)], '')
             ELSE NULL
             END AS FLOAT64) * 60 + CAST(CASE
           WHEN RK.totaluseddurationexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(2)], '')
           ELSE NULL
           END AS FLOAT64)) / IF(RK.totalnumshiftindicatorexcldummy = 0, NULL, RK.totalnumshiftindicatorexcldummy), 0)
     WHEN GM.shift_type = 'STANDARD_SHIFT'
     THEN IFNULL((CAST(CASE
             WHEN RK.totaluseddurationexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS FLOAT64) * 3600 + CAST(CASE
             WHEN RK.totaluseddurationexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(1)], '')
             ELSE NULL
             END AS FLOAT64) * 60 + CAST(CASE
           WHEN RK.totaluseddurationexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(2)], '')
           ELSE NULL
           END AS FLOAT64)) / IF(RK.totalnumshiftsexcldummy = 0, NULL, RK.totalnumshiftsexcldummy), 0)
     ELSE NULL
     END / 3600 AS use_time_in_hr_per_shift,
    CASE
    WHEN GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL((CAST(CASE
            WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END AS FLOAT64) * 3600 + CAST(CASE
            WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
            ELSE NULL
            END AS FLOAT64) * 60 + CAST(CASE
          WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
          ELSE NULL
          END AS FLOAT64)) / IF(RK.totalnumshiftindicatorstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftindicatorstoredeliveryexcldummy
       ), 0)
    WHEN GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL((CAST(CASE
            WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END AS FLOAT64) * 3600 + CAST(CASE
            WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
            ELSE NULL
            END AS FLOAT64) * 60 + CAST(CASE
          WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
          ELSE NULL
          END AS FLOAT64)) / IF(RK.totalnumshiftsstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftsstoredeliveryexcldummy
       ), 0)
    ELSE NULL
    END AS use_time_in_sec_per_shift_store_delivery,
     CASE
     WHEN GM.shift_type = 'SHIFT_INDICATOR'
     THEN IFNULL((CAST(CASE
             WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS FLOAT64) * 3600 + CAST(CASE
             WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
             ELSE NULL
             END AS FLOAT64) * 60 + CAST(CASE
           WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
           ELSE NULL
           END AS FLOAT64)) / IF(RK.totalnumshiftindicatorstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftindicatorstoredeliveryexcldummy
        ), 0)
     WHEN GM.shift_type = 'STANDARD_SHIFT'
     THEN IFNULL((CAST(CASE
             WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS FLOAT64) * 3600 + CAST(CASE
             WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
             ELSE NULL
             END AS FLOAT64) * 60 + CAST(CASE
           WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
           ELSE NULL
           END AS FLOAT64)) / IF(RK.totalnumshiftsstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftsstoredeliveryexcldummy
        ), 0)
     ELSE NULL
     END / 60 AS use_time_in_min_per_shift_store_delivery,
     CASE
     WHEN GM.shift_type = 'SHIFT_INDICATOR'
     THEN IFNULL((CAST(CASE
             WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS FLOAT64) * 3600 + CAST(CASE
             WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
             ELSE NULL
             END AS FLOAT64) * 60 + CAST(CASE
           WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
           ELSE NULL
           END AS FLOAT64)) / IF(RK.totalnumshiftindicatorstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftindicatorstoredeliveryexcldummy
        ), 0)
     WHEN GM.shift_type = 'STANDARD_SHIFT'
     THEN IFNULL((CAST(CASE
             WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS FLOAT64) * 3600 + CAST(CASE
             WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
             ELSE NULL
             END AS FLOAT64) * 60 + CAST(CASE
           WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
           ELSE NULL
           END AS FLOAT64)) / IF(RK.totalnumshiftsstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftsstoredeliveryexcldummy
        ), 0)
     ELSE NULL
     END / 3600 AS use_time_in_hr_per_shift_store_delivery,
    CASE
    WHEN GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL((CAST(CASE
            WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END AS FLOAT64) * 3600 + CAST(CASE
            WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
            ELSE NULL
            END AS FLOAT64) * 60 + CAST(CASE
          WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
          ELSE NULL
          END AS FLOAT64)) / IF(RK.totalnumshiftindicatornonstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftindicatornonstoredeliveryexcldummy
       ), 0)
    WHEN GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL((CAST(CASE
            WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END AS FLOAT64) * 3600 + CAST(CASE
            WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
            ELSE NULL
            END AS FLOAT64) * 60 + CAST(CASE
          WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
          ELSE NULL
          END AS FLOAT64)) / IF(RK.totalnumshiftsnonstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftsnonstoredeliveryexcldummy
       ), 0)
    ELSE NULL
    END AS use_time_in_sec_per_shift_non_store_delivery,
     CASE
     WHEN GM.shift_type = 'SHIFT_INDICATOR'
     THEN IFNULL((CAST(CASE
             WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS FLOAT64) * 3600 + CAST(CASE
             WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
             ELSE NULL
             END AS FLOAT64) * 60 + CAST(CASE
           WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
           ELSE NULL
           END AS FLOAT64)) / IF(RK.totalnumshiftindicatornonstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftindicatornonstoredeliveryexcldummy
        ), 0)
     WHEN GM.shift_type = 'STANDARD_SHIFT'
     THEN IFNULL((CAST(CASE
             WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS FLOAT64) * 3600 + CAST(CASE
             WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
             ELSE NULL
             END AS FLOAT64) * 60 + CAST(CASE
           WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
           ELSE NULL
           END AS FLOAT64)) / IF(RK.totalnumshiftsnonstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftsnonstoredeliveryexcldummy
        ), 0)
     ELSE NULL
     END / 60 AS use_time_in_min_per_shift_non_store_delivery,
     CASE
     WHEN GM.shift_type = 'SHIFT_INDICATOR'
     THEN IFNULL((CAST(CASE
             WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS FLOAT64) * 3600 + CAST(CASE
             WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
             ELSE NULL
             END AS FLOAT64) * 60 + CAST(CASE
           WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
           ELSE NULL
           END AS FLOAT64)) / IF(RK.totalnumshiftindicatornonstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftindicatornonstoredeliveryexcldummy
        ), 0)
     WHEN GM.shift_type = 'STANDARD_SHIFT'
     THEN IFNULL((CAST(CASE
             WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS FLOAT64) * 3600 + CAST(CASE
             WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
             THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
             ELSE NULL
             END AS FLOAT64) * 60 + CAST(CASE
           WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
           ELSE NULL
           END AS FLOAT64)) / IF(RK.totalnumshiftsnonstoredeliveryexcldummy = 0, NULL, RK.totalnumshiftsnonstoredeliveryexcldummy
        ), 0)
     ELSE NULL
     END / 3600 AS use_time_in_hr_per_shift_non_store_delivery,
   IFNULL((CAST(CASE
           WHEN RK.totaluseddurationexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(0)], '')
           ELSE NULL
           END AS FLOAT64) * 3600 + CAST(CASE
           WHEN RK.totaluseddurationexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(1)], '')
           ELSE NULL
           END AS FLOAT64) * 60 + CAST(CASE
         WHEN RK.totaluseddurationexcldummy IS NOT NULL
         THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(2)], '')
         ELSE NULL
         END AS FLOAT64)) / IF(RK.totalroutesinuseexcldummy = 0, NULL, RK.totalroutesinuseexcldummy), 0) AS
   use_time_in_sec_per_truck,
    IFNULL((CAST(CASE
            WHEN RK.totaluseddurationexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END AS FLOAT64) * 3600 + CAST(CASE
            WHEN RK.totaluseddurationexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(1)], '')
            ELSE NULL
            END AS FLOAT64) * 60 + CAST(CASE
          WHEN RK.totaluseddurationexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(2)], '')
          ELSE NULL
          END AS FLOAT64)) / IF(RK.totalroutesinuseexcldummy = 0, NULL, RK.totalroutesinuseexcldummy), 0) / 60 AS
   use_time_in_min_per_truck,
    IFNULL((CAST(CASE
            WHEN RK.totaluseddurationexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END AS FLOAT64) * 3600 + CAST(CASE
            WHEN RK.totaluseddurationexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(1)], '')
            ELSE NULL
            END AS FLOAT64) * 60 + CAST(CASE
          WHEN RK.totaluseddurationexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaluseddurationexcldummy, ':')[SAFE_OFFSET(2)], '')
          ELSE NULL
          END AS FLOAT64)) / IF(RK.totalroutesinuseexcldummy = 0, NULL, RK.totalroutesinuseexcldummy), 0) / 3600 AS
   use_time_in_hr_per_truck,
   IFNULL((CAST(CASE
           WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
           ELSE NULL
           END AS FLOAT64) * 3600 + CAST(CASE
           WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
           ELSE NULL
           END AS FLOAT64) * 60 + CAST(CASE
         WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
         THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
         ELSE NULL
         END AS FLOAT64)) / IF(RK.totalroutesinusestoredeliveryexcldummy = 0, NULL, RK.totalroutesinusestoredeliveryexcldummy
      ), 0) AS use_time_in_sec_per_truck_store_delivery,
    IFNULL((CAST(CASE
            WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END AS FLOAT64) * 3600 + CAST(CASE
            WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
            ELSE NULL
            END AS FLOAT64) * 60 + CAST(CASE
          WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
          ELSE NULL
          END AS FLOAT64)) / IF(RK.totalroutesinusestoredeliveryexcldummy = 0, NULL, RK.totalroutesinusestoredeliveryexcldummy
       ), 0) / 60 AS use_time_in_min_per_truck_store_delivery,
    IFNULL((CAST(CASE
            WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END AS FLOAT64) * 3600 + CAST(CASE
            WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
            ELSE NULL
            END AS FLOAT64) * 60 + CAST(CASE
          WHEN RK.totaldurationstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
          ELSE NULL
          END AS FLOAT64)) / IF(RK.totalroutesinusestoredeliveryexcldummy = 0, NULL, RK.totalroutesinusestoredeliveryexcldummy
       ), 0) / 3600 AS use_time_in_hr_per_truck_store_delivery,
   IFNULL((CAST(CASE
           WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
           ELSE NULL
           END AS FLOAT64) * 3600 + CAST(CASE
           WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
           THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
           ELSE NULL
           END AS FLOAT64) * 60 + CAST(CASE
         WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
         THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
         ELSE NULL
         END AS FLOAT64)) / IF(RK.totalroutesinusenonstoredeliveryexcldummy = 0, NULL, RK.totalroutesinusenonstoredeliveryexcldummy
      ), 0) AS use_time_in_sec_per_truck_non_store_delivery,
    IFNULL((CAST(CASE
            WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END AS FLOAT64) * 3600 + CAST(CASE
            WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
            ELSE NULL
            END AS FLOAT64) * 60 + CAST(CASE
          WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
          ELSE NULL
          END AS FLOAT64)) / IF(RK.totalroutesinusenonstoredeliveryexcldummy = 0, NULL, RK.totalroutesinusenonstoredeliveryexcldummy
       ), 0) / 60 AS use_time_in_min_per_truck_non_store_delivery,
    IFNULL((CAST(CASE
            WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END AS FLOAT64) * 3600 + CAST(CASE
            WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
            THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(1)], '')
            ELSE NULL
            END AS FLOAT64) * 60 + CAST(CASE
          WHEN RK.totaldurationnonstoredeliveriesexcldummy IS NOT NULL
          THEN IFNULL(SPLIT(RK.totaldurationnonstoredeliveriesexcldummy, ':')[SAFE_OFFSET(2)], '')
          ELSE NULL
          END AS FLOAT64)) / IF(RK.totalroutesinusenonstoredeliveryexcldummy = 0, NULL, RK.totalroutesinusenonstoredeliveryexcldummy
       ), 0) / 3600 AS use_time_in_hr_per_truck_non_store_delivery,
    CASE
    WHEN GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL((RK.totalnumshiftindicatorexcldummy / IF(RK.totalroutesinuseexcldummy = 0, NULL, RK.totalroutesinuseexcldummy
          ) - 1) * 100, 0)
    WHEN GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL((RK.totalnumshiftsexcldummy / IF(RK.totalroutesinuseexcldummy = 0, NULL, RK.totalroutesinuseexcldummy) -
        1) * 100, 0)
    ELSE NULL
    END AS share_double_shifts,
    CASE
    WHEN GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL((RK.totalnumshiftindicatorstoredeliveryexcldummy / IF(RK.totalroutesinusestoredeliveryexcldummy = 0,
          NULL, RK.totalroutesinusestoredeliveryexcldummy) - 1) * 100, 0)
    WHEN GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL((RK.totalnumshiftsstoredeliveryexcldummy / IF(RK.totalroutesinusestoredeliveryexcldummy = 0, NULL, RK.totalroutesinusestoredeliveryexcldummy
          ) - 1) * 100, 0)
    ELSE NULL
    END AS share_double_shifts_store_delivery,
    CASE
    WHEN GM.shift_type = 'SHIFT_INDICATOR'
    THEN IFNULL((RK.totalnumshiftindicatornonstoredeliveryexcldummy / IF(RK.totalroutesinusenonstoredeliveryexcldummy =
           0, NULL, RK.totalroutesinusenonstoredeliveryexcldummy) - 1) * 100, 0)
    WHEN GM.shift_type = 'STANDARD_SHIFT'
    THEN IFNULL((RK.totalnumshiftsnonstoredeliveryexcldummy / IF(RK.totalroutesinusenonstoredeliveryexcldummy = 0, NULL
          , RK.totalroutesinusenonstoredeliveryexcldummy) - 1) * 100, 0)
    ELSE NULL
    END AS share_double_shifts_non_store_delivery,
   RK.totalnumpalletswithisdeliverytoexternalwarehouseplannedexcldummy,
   RK.totalnumpalletswithisdeliverytointernalwarehouseplannedexcldummy,
   RK.totalnumpalletswithisdeliverytononfoodwarehouseplannedexcldummy,
   RK.totalnumpalletswithisstocktransferplannedexcldummy,
   RK.totalnumpalletswithisreceivingcrossdockingplannedexcldummy,
   RK.totalnumpalletswithispickingcrossdockingplannedexcldummy
  FROM ldl_logop_data.t_quintiq_reportedkpi_2 AS RK
   INNER JOIN GEO_MAP AS GM ON RK.client_id = GM.client_id AND RK.wh_id = GM.wh_id
  WHERE RK.dwh_valid_to = DATE '9999-12-30');