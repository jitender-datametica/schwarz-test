CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_FACT_SALES_PACKAGE_SHIPMENT
AS
SELECT
     IFNULL(WSHOP_CD,'-1')                                                                                                                                      AS WSHOP_CD -- why IFNULL?: possible NULL values due to KFL Parkside shipments
    ,DIST_CHANNEL_CD                                                                                                                                            AS DIST_CHANNEL_CD
    ,IFNULL(PACK_SID, -1)                                                                                                                                       AS PACK_SID
    ,CASE WHEN PACK_TRACKING_NR='' THEN '-1' ELSE PACK_TRACKING_NR END                                                                                          AS PACK_TRACKING_NR 
    ,EWM_PACK_NR                                                                                                                                                AS EWM_PACK_NR
    ,PACK_TRACKING_URL                                                                                                                                          AS PACK_TRACKING_URL
    ,PACK_ORDER_NR                                                                                                                                              AS PACK_ORDER_NR
    ,DELIVERY_ORDER_NR                                                                                                                                          AS DELIVERY_ORDER_NR
    ,CUST_DELIVERY_TGT_DT                                                                                                                                       AS CUST_DELIVERY_TGT_DT
    ,CONVERT_TIMEZONE('Europe/Berlin', pack_order_tgt_create_tmsp)::TIMESTAMP_NTZ                                                                               AS pack_order_tgt_create_tmsp
    ,DATE(pack_order_tgt_create_tmsp)                                                                                                                           AS pack_order_tgt_create_date
    ,CASE WHEN DELIVERY_ORDER_NR LIKE '6%' THEN CONVERT_TIMEZONE('Europe/Berlin', PACK_ORDER_ACTUAL_CREATE_TMSP)::TIMESTAMP_NTZ 
          WHEN DELIVERY_ORDER_NR LIKE '8%' THEN CONVERT_TIMEZONE('Europe/Berlin', PACK_ORDER_ORIG_CREATE_TMSP)::TIMESTAMP_NTZ 
          ELSE CONVERT_TIMEZONE('Europe/Berlin', PACK_ORDER_ACTUAL_CREATE_TMSP)::TIMESTAMP_NTZ 
          END                                                                                                                                                   AS PACK_ORDER_ORIGINAL_CREATE_TMSP
	,DATE(PACK_ORDER_ORIGINAL_CREATE_TMSP) 																														AS PACK_ORDER_ORIGINAL_CREATE_DATE
	,TO_TIME(PACK_ORDER_ORIGINAL_CREATE_TMSP) 																													AS PACK_ORDER_ORIGINAL_CREATE_TM
    ,CONVERT_TIMEZONE('Europe/Berlin', pack_order_actual_create_tmsp)::TIMESTAMP_NTZ                                                                            AS pack_order_actual_create_tmsp -- not needed in frontend, instead pack_order_original_create_tmsp
    ,DATE(pack_order_actual_create_tmsp)                                                                                                                        AS pack_order_actual_create_date -- not needed in frontend, instead pack_order_original_create_tmsp
    ,TO_TIME(CONVERT_TIMEZONE('Europe/Berlin', pack_order_actual_create_tmsp)::TIMESTAMP_NTZ)                                                                   AS PACK_ORDER_ACTUAL_CREATE_TM -- not needed in frontend, instead pack_order_original_create_tmsp
    ,CONVERT_TIMEZONE('Europe/Berlin', cust_delivery_tgt_hauler_tmsp)::TIMESTAMP_NTZ                                                                            AS cust_delivery_tgt_hauler_tmsp
    ,DATE(cust_delivery_tgt_hauler_tmsp)                                                                                                                        AS cust_delivery_tgt_hauler_date
    ,CONVERT_TIMEZONE('Europe/Berlin', wh_leave_tgt_tmsp)::TIMESTAMP_NTZ                                                                                        AS wh_leave_tgt_tmsp
    ,DATE(wh_leave_tgt_tmsp)                                                                                                                                    AS wh_leave_tgt_date
    ,CONVERT_TIMEZONE('Europe/Berlin', wh_leave_actual_tmsp)::TIMESTAMP_NTZ                                                                                     AS wh_leave_actual_tmsp
    ,DATE(wh_leave_actual_tmsp)                                                                                                                                 AS wh_leave_actual_date
    ,CONVERT_TIMEZONE('Europe/Berlin', first_hub_scan_actual_tmsp)::TIMESTAMP_NTZ                                                                               AS first_hub_scan_actual_tmsp
    ,DATE(first_hub_scan_actual_tmsp)                                                                                                                           AS first_hub_scan_actual_date
    ,CONVERT_TIMEZONE('Europe/Berlin', first_hub_scan_tgt_tmsp)::TIMESTAMP_NTZ                                                                                  AS first_hub_scan_tgt_tmsp
    ,DATE(first_hub_scan_tgt_tmsp)                                                                                                                              AS first_hub_scan_tgt_date
    ,CONVERT_TIMEZONE('Europe/Berlin', first_attempt_delivery_tmsp)::TIMESTAMP_NTZ                                                                              AS first_attempt_delivery_tmsp
    ,DATE(first_attempt_delivery_tmsp)                                                                                                                          AS first_attempt_delivery_date
    ,CONVERT_TIMEZONE('Europe/Berlin', cust_delivery_actual_tmsp)::TIMESTAMP_NTZ                                                                                AS cust_delivery_actual_tmsp
    ,DATE(cust_delivery_actual_tmsp)                                                                                                                            AS cust_delivery_actual_date
    ,IFNULL(WH_SID, -1)                                                                                                                                         AS WH_SID
    ,IS_DAMAGED_FG                                                                                                                                              AS IS_DAMAGED_FG
    ,CASE WHEN PACK_SIZE_TYPE_CD = '' THEN '-1' ELSE IFNULL(PACK_SIZE_TYPE_CD, '-1') END                                                                        AS PACK_SIZE_TYPE_CD
    ,CASE WHEN DELIVERY_TYPE_CD = '' THEN '-1' ELSE IFNULL(DELIVERY_TYPE_CD, '-1') END                                                                          AS DELIVERY_TYPE_CD
    ,IFNULL(DELIVERY_ADDR_SID, -1)                                                                                                                              AS DELIVERY_ADDR_SID
    ,CASE WHEN DELIVERY_ZIP_SHORT_CD = '' THEN '-1' ELSE IFNULL(DELIVERY_ZIP_SHORT_CD, '-1')::VARCHAR(20) END                                                   AS DELIVERY_ZIP_SHORT_CD
    ,IFNULL(HAULER_SID, -1)                                                                                                                                     AS HAULER_SID
    ,HAULER_NAME                                                                                                                                                AS HAULER_NAME
    ,IFF(HAULER_NAME = 'PL_DPD', (PACK_LENGTH_MEAS * PACK_WIDTH_MEAS * PACK_HEIGHT_MEAS)/0.006, NULL)                                                           AS PACK_VOLUMETRIC_WEIGHT_GROSS
    ,PACK_HEIGHT_MEAS                                                                                                                                           AS PACK_HEIGHT_MEAS
    ,LEFT(PACK_HEIGHT_MEAS || ' ' || UOM_PACK_HEIGHT.UOM_CD, 20)::VARCHAR(20)                                                                                   AS PACK_HEIGHT_STR
    ,PACK_HEIGHT_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                                AS PACK_HEIGHT_MEAS_STANDARD
    ,IFNULL(UOM_PACK_HEIGHT.UOM_STANDARD_CD, '-1')                                                                                                              AS PACK_HEIGHT_MEAS_STANDARD_UOM_CD
    ,PACK_WIDTH_MEAS                                                                                                                                            AS PACK_WIDTH_MEAS
    ,LEFT(PACK_WIDTH_MEAS || ' ' || UOM_PACK_WIDTH.UOM_CD, 20)::VARCHAR(20)                                                                                     AS PACK_WIDTH_STR
    ,PACK_WIDTH_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                                 AS PACK_WIDTH_MEAS_STANDARD
    ,IFNULL(UOM_PACK_WIDTH.UOM_STANDARD_CD, '-1')                                                                                                               AS PACK_WIDTH_MEAS_STANDARD_UOM_CD
    ,PACK_LENGTH_MEAS                                                                                                                                           AS PACK_LENGTH_MEAS
    ,PACK_MEAN_LENGTH_MEAS                                                                                                                                      AS PACK_MEAN_LENGTH_MEAS
    ,PACK_SHORTEST_LENGTH_MEAS                                                                                                                                  AS PACK_SHORTEST_LENGTH_MEAS
    ,PACK_LONGEST_LENGTH_MEAS                                                                                                                                   AS PACK_LONGEST_LENGTH_MEAS
    ,LEFT(PACK_LENGTH_MEAS || ' ' || UOM_PACK_LENGTH.UOM_CD, 20)::VARCHAR(20)                                                                                   AS PACK_LENGTH_STR
    ,PACK_LENGTH_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                                AS PACK_LENGTH_MEAS_STANDARD
    ,LEFT(PACK_MEAN_LENGTH_MEAS || ' ' || UOM_PACK_LENGTH.UOM_CD, 20)::VARCHAR(20)                                                                              AS PACK_MEAN_LENGTH_STR
    ,PACK_MEAN_LENGTH_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                           AS PACK_MEAN_LENGTH_MEAS_STANDARD
    ,LEFT(PACK_SHORTEST_LENGTH_MEAS || ' ' || UOM_PACK_LENGTH.UOM_CD, 20)::VARCHAR(20)                                                                          AS PACK_SHORTEST_LENGTH_STR
    ,PACK_SHORTEST_LENGTH_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                       AS PACK_SHORTEST_LENGTH_MEAS_STANDARD
    ,LEFT(PACK_LONGEST_LENGTH_MEAS || ' ' || UOM_PACK_LENGTH.UOM_CD, 20)::VARCHAR(20)                                                                           AS PACK_LONGEST_LENGTH_STR
    ,PACK_LONGEST_LENGTH_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                        AS PACK_LONGEST_LENGTH_MEAS_STANDARD
    ,IFNULL(UOM_PACK_LENGTH.UOM_STANDARD_CD, '-1')                                                                                                              AS PACK_LENGTH_MEAS_STANDARD_UOM_CD
    ,PACK_GIRTH_WEST_MEAS                                                                                                                                       AS PACK_GIRTH_WEST_MEAS
    ,PACK_GIRTH_EAST_MEAS                                                                                                                                       AS PACK_GIRTH_EAST_MEAS
    ,LEFT(PACK_GIRTH_WEST_MEAS || ' ' || UOM_PACK_GIRTH.UOM_CD, 20)::VARCHAR(20)                                                                                AS PACK_GIRTH_WEST_STR
    ,PACK_GIRTH_WEST_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                            AS PACK_GIRTH_WEST_MEAS_STANDARD
    ,LEFT(PACK_GIRTH_EAST_MEAS || ' ' || UOM_PACK_GIRTH.UOM_CD, 20)::VARCHAR(20)                                                                                AS PACK_GIRTH_EAST_STR
    ,PACK_GIRTH_EAST_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                            AS PACK_GIRTH_EAST_MEAS_STANDARD
    ,IFNULL(UOM_PACK_GIRTH.UOM_STANDARD_CD, '-1')                                                                                                               AS PACK_GIRTH_MEAS_STANDARD_UOM_CD
    ,PACK_WEIGHT_MEAS                                                                                                                                           AS PACK_WEIGHT_MEAS
    ,LEFT(PACK_WEIGHT_MEAS || ' ' || UOM_PACK_WEIGHT.UOM_CD, 20)::VARCHAR(20)                                                                                   AS PACK_WEIGHT_STR
    ,PACK_WEIGHT_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                                AS PACK_WEIGHT_MEAS_STANDARD
    ,IFNULL(UOM_PACK_WEIGHT.UOM_STANDARD_CD, '-1')                                                                                                              AS PACK_WEIGHT_MEAS_STANDARD_UOM_CD
    ,PACK_VOLUME_MEAS                                                                                                                                           AS PACK_VOLUME_MEAS
    ,LEFT(PACK_VOLUME_MEAS || ' ' || UOM_PACK_VOLUME.UOM_CD, 20)::VARCHAR(20)                                                                                   AS PACK_VOLUME_STR
    ,PACK_VOLUME_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                                AS PACK_VOLUME_MEAS_STANDARD
    ,IFNULL(UOM_PACK_VOLUME.UOM_STANDARD_CD, '-1')                                                                                                              AS PACK_VOLUME_MEAS_STANDARD_UOM_CD
    ,CASE WHEN WEIGHT_CLASS_CD = '' THEN '-1' ELSE IFNULL(WEIGHT_CLASS_CD, '-1') END                                                                            AS WEIGHT_CLASS_CD
    ,CASE WHEN VOLUME_CLASS_CD = '' THEN '-1' ELSE IFNULL(VOLUME_CLASS_CD, '-1') END                                                                            AS VOLUME_CLASS_CD
    ,IFNULL(DELIVERY_ORDER_SID, -1)                                                                                                                             AS DELIVERY_ORDER_SID
    ,PACK_MATERIAL_NR                                                                                                                                           AS PACK_MATERIAL_NR
    ,WH_PUNCTUALITY_CD                                                                                                                                          AS WAREHOUSE_PUNCTUALITY
    ,HAULER_PUNCTUALITY_CD                                                                                                                                      AS SERVICE_PROVIDER_PUNCTUALITY
    ,CUST_SHIP_PUNCTUALITY_CD                                                                                                                                   AS CUSTOMER_PUNCTUALITY_SHIPMENT_LEVEL
    ,PACK_ORDER_CREATE_PUNCTUALITY_CD                                                                                                                           AS EWM_ORDER_PUNCTUALITY
    ,CASE WHEN PACK_ORDER_CREATE_PUNCTUALITY_CD='zu spät' AND PACK_ORDER_ORIGINAL_CREATE_DATE=DATE(CONVERT_TIMEZONE('Europe/Berlin', WH_LEAVE_TGT_TMSP)::TIMESTAMP_NTZ ) THEN 'T0'
          WHEN PACK_ORDER_CREATE_PUNCTUALITY_CD='zu spät' AND PACK_ORDER_ORIGINAL_CREATE_DATE>DATE(CONVERT_TIMEZONE('Europe/Berlin', WH_LEAVE_TGT_TMSP)::TIMESTAMP_NTZ ) THEN 'T1'
          ELSE '-1' END                                                                                                                                         AS EWM_ORDER_DELAY_STATUS
    ,WH_DELAY_HR                                                                                                                                                AS WAREHOUSE_DELAY_IN_HOURS
    ,CEIL(WH_DELAY_HR / 24)                                                                                                                                     AS WAREHOUSE_DELAY_IN_DAYS
    ,HAULER_DELAY_HR                                                                                                                                             AS SERVICE_PROVIDER_DELAY_IN_HOURS
    ,CEIL(HAULER_DELAY_HR / 24)                                                                                                                                  AS SERVICE_PROVIDER_DELAY_IN_DAYS
    ,CUST_SHIP_DELAY_DAY                                                                                                                                         AS CUSTOMER_SHIPMENT_LEVEL_DELAY_IN_DAYS
    ,VEHICLE_INTERNAL_NR                                                                                                                                         AS VEHICLE_INTERNAL_NR
	,VEHICLE_LICENSE_PLATE_NR                                                                                                                                    AS VEHICLE_LICENSE_PLATE_NR
	,CONVERT_TIMEZONE('Europe/Berlin', VEHICLE_DEPARTURE_TMSP)::TIMESTAMP_NTZ                                                                                    AS VEHICLE_DEPARTURE_TMSP
    ,TO_DATE(VEHICLE_DEPARTURE_TMSP)                                                                                                                             AS VEHICLE_DEPARTURE_DATE
    ,CONVERT_TIMEZONE('Europe/Berlin', VEHICLE_LOADING_START_TMSP)::TIMESTAMP_NTZ                                                                                AS VEHICLE_LOADING_START_TMSP
    ,TO_DATE(VEHICLE_LOADING_START_TMSP)                                                                                                                         AS VEHICLE_LOADING_START_DATE
    ,CONVERT_TIMEZONE('Europe/Berlin', VEHICLE_LOADING_END_TMSP)::TIMESTAMP_NTZ                                                                                  AS VEHICLE_LOADING_END_TMSP
    ,TO_DATE(VEHICLE_LOADING_END_TMSP)                                                                                                                           AS VEHICLE_LOADING_END_DATE
    ,CONVERT_TIMEZONE('Europe/Berlin', VEHICLE_HUB_LOADING_START_TMSP)::TIMESTAMP_NTZ                                                                            AS TRUCK_UNLOADING_START_AT_HUB_TMSP
    ,DATE(VEHICLE_HUB_LOADING_START_TMSP)                                                                                                                        AS TRUCK_UNLOADING_START_AT_HUB_DATE
    ,CONVERT_TIMEZONE('Europe/Berlin', VEHICLE_HUB_LOADING_END_TMSP)::TIMESTAMP_NTZ                                                                              AS TRUCK_UNLOADING_STOP_AT_HUB_TMSP
    ,DATE(VEHICLE_HUB_LOADING_END_TMSP)                                                                                                                          AS TRUCK_UNLOADING_STOP_AT_HUB_DATE
    ,VEHICLE_HUB_LOADING_DUR_HR                                                                                                                                  AS DURATION_OF_UNLOADING_AT_HUB_IN_H
    ,VEHICLE_HUB_LOADING_PCT                                                                                                                                     AS TRUCK_UNLOADING_STOP_AT_HUB_TMSP_PERCENTRANK_SELECTED_GROUP
    ,IS_GHOST_PACK_FG                                                                                                                                            AS IS_GHOST_PACK_FG
    ,IS_GHOST_PACK_RETURN_FG                                                                                                                                     AS IS_GHOST_PACK_RETURN_FG
    ,IS_LOST_PACK_FG                                                                                                                                             AS IS_LOST_PACK_FG
    ,CONVERT_TIMEZONE('Europe/Berlin', PACK_RETURN_TMSP)::TIMESTAMP_NTZ                                                                                          AS PACK_RETURN_TMSP
    ,DATE(PACK_RETURN_TMSP)                                                                                                                                      AS PACK_RETURN_DATE
    ,GHOST_PACK_RETURN_DURATION_DAYS_CNT                                                                                                                         AS GHOST_PACK_RETURN_DURATION_DAYS_CNT
    ,FIRST_HUB_LOC_DESCR                                                                                                                                         AS FIRST_HUB_LOC_DESCR
    ,SECOND_HUB_LOC_DESCR                                                                                                                                        AS SECOND_HUB_LOC_DESCR
    ,COALESCE(CUST_ORDER_NR,'-1')                                                                                                                                AS CUST_ORDER_NR
    ,CUST_ORDER_DT                                                                                                                                               AS CUST_ORDER_DT 
    ,CUST_ORDER_TYPE_CD                                                                                                                                          AS CUST_ORDER_TYPE_CD --in ETL script coalesce of order line and intercompany line values
    ,COALESCE(CUST_PAYM_METHOD_CD,'-1')                                                                                                                          AS CUST_PAYM_METHOD_CD 
    ,COALESCE(IC_ORDER_NR,'-1')                                                                                                                                  AS IC_ORDER_NR
    ,IC_ORDER_DT                                                                                                                                                 AS IC_ORDER_DT
    ,deliv_prod_qty                                                                                                                                              AS DELIV_PROD_QTY
FROM
    lec_share.v_fact_sales_package_shipment FACT_SPS
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT UOM_PACK_HEIGHT ON UOM_PACK_HEIGHT.UOM_SID = IFNULL(FACT_SPS.PACK_HEIGHT_UOM_SID, '-1') 
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT UOM_PACK_WIDTH ON UOM_PACK_WIDTH.UOM_SID = IFNULL(FACT_SPS.PACK_WIDTH_UOM_SID, '-1') 
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT UOM_PACK_LENGTH ON UOM_PACK_LENGTH.UOM_SID = IFNULL(FACT_SPS.PACK_LENGTH_UOM_SID, '-1') 
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT UOM_PACK_GIRTH ON UOM_PACK_GIRTH.UOM_SID = IFNULL(FACT_SPS.PACK_GIRTH_UOM_SID, '-1') 
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT UOM_PACK_WEIGHT ON UOM_PACK_WEIGHT.UOM_SID = IFNULL(FACT_SPS.PACK_WEIGHT_UOM_SID, '-1') 
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT UOM_PACK_VOLUME ON UOM_PACK_VOLUME.UOM_SID = IFNULL(FACT_SPS.PACK_VOLUME_UOM_SID, '-1') 
;