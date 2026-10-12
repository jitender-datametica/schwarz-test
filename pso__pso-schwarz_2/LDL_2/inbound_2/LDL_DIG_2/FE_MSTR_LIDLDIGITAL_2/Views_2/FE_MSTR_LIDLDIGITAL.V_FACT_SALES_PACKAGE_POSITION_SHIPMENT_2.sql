CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_FACT_SALES_PACKAGE_POSITION_SHIPMENT_2
AS
SELECT
     IFNULL(sps.WSHOP_CD,'-1')                                                                                                                                  AS WSHOP_CD -- why IFNULL?: possible NULL values due to KFL Parkside shipments
    ,sps.DIST_CHANNEL_CD                                                                                                                                        AS DIST_CHANNEL_CD
    ,IFNULL(sps.PACK_SID, -1)                                                                                                                                   AS PACK_SID
    ,CASE WHEN PACK_TRACKING_NR='' THEN '-1' ELSE PACK_TRACKING_NR END                                                                                          AS PACK_TRACKING_NR
    ,sps.EWM_PACK_NR                                                                                                                                            AS EWM_PACK_NR
    ,sps.PACK_TRACKING_URL                                                                                                                                      AS PACK_TRACKING_URL
    ,sps.PACK_ORDER_NR                                                                                                                                          AS PACK_ORDER_NR
    ,sps.DELIVERY_ORDER_NR                                                                                                                                      AS DELIVERY_ORDER_NR
    ,sps.CUST_DELIVERY_TGT_DT                                                                                                                                   AS CUST_DELIVERY_TGT_DT
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.pack_order_tgt_create_tmsp)::TIMESTAMP_NTZ                                                                           AS pack_order_tgt_create_tmsp
    ,DATE(sps.pack_order_tgt_create_tmsp)                                                                                                                       AS pack_order_tgt_create_date
    ,CASE WHEN sps.DELIVERY_ORDER_NR LIKE '6%' THEN CONVERT_TIMEZONE('Europe/Berlin', sps.PACK_ORDER_ACTUAL_CREATE_TMSP)::TIMESTAMP_NTZ 
          WHEN sps.DELIVERY_ORDER_NR LIKE '8%' THEN CONVERT_TIMEZONE('Europe/Berlin', sps.PACK_ORDER_ORIG_CREATE_TMSP)::TIMESTAMP_NTZ 
          ELSE CONVERT_TIMEZONE('Europe/Berlin', sps.PACK_ORDER_ACTUAL_CREATE_TMSP)::TIMESTAMP_NTZ 
          END                                                                                                                                                   AS PACK_ORDER_ORIGINAL_CREATE_TMSP
	,DATE(PACK_ORDER_ORIGINAL_CREATE_TMSP) 																														AS PACK_ORDER_ORIGINAL_CREATE_DATE
	,TO_TIME(PACK_ORDER_ORIGINAL_CREATE_TMSP) 																													AS PACK_ORDER_ORIGINAL_CREATE_TM
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.pack_order_actual_create_tmsp)::TIMESTAMP_NTZ                                                                        AS pack_order_actual_create_tmsp -- not needed in frontend, instead pack_order_original_create_tmsp
    ,DATE(sps.pack_order_actual_create_tmsp)                                                                                                                    AS pack_order_actual_create_date -- not needed in frontend, instead pack_order_original_create_tmsp
    ,TO_TIME(CONVERT_TIMEZONE('Europe/Berlin', sps.pack_order_actual_create_tmsp)::TIMESTAMP_NTZ)                                                               AS PACK_ORDER_ACTUAL_CREATE_TM   -- not needed in frontend, instead pack_order_original_create_tmsp
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.cust_delivery_tgt_hauler_tmsp)::TIMESTAMP_NTZ                                                                        AS cust_delivery_tgt_hauler_tmsp
    ,DATE(sps.cust_delivery_tgt_hauler_tmsp)                                                                                                                    AS cust_delivery_tgt_hauler_date
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.wh_leave_tgt_tmsp)::TIMESTAMP_NTZ                                                                                    AS wh_leave_tgt_tmsp
    ,DATE(sps.wh_leave_tgt_tmsp)                                                                                                                                AS wh_leave_tgt_date
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.wh_leave_actual_tmsp)::TIMESTAMP_NTZ                                                                                 AS wh_leave_actual_tmsp
    ,DATE(sps.wh_leave_actual_tmsp)                                                                                                                             AS wh_leave_actual_date
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.first_hub_scan_actual_tmsp)::TIMESTAMP_NTZ                                                                           AS first_hub_scan_actual_tmsp
    ,DATE(sps.first_hub_scan_actual_tmsp)                                                                                                                       AS first_hub_scan_actual_date
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.first_hub_scan_tgt_tmsp)::TIMESTAMP_NTZ                                                                              AS first_hub_scan_tgt_tmsp
    ,DATE(sps.first_hub_scan_tgt_tmsp)                                                                                                                          AS first_hub_scan_tgt_date
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.first_attempt_delivery_tmsp)::TIMESTAMP_NTZ                                                                          AS first_attempt_delivery_tmsp
    ,DATE(sps.first_attempt_delivery_tmsp)                                                                                                                      AS first_attempt_delivery_date
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.cust_delivery_actual_tmsp)::TIMESTAMP_NTZ                                                                            AS cust_delivery_actual_tmsp
    ,DATE(sps.cust_delivery_actual_tmsp)                                                                                                                        AS cust_delivery_actual_date
    ,IFNULL(sps.WH_SID, -1)                                                                                                                                     AS WH_SID
    ,sps.IS_DAMAGED_FG                                                                                                                                          AS IS_DAMAGED_FG
    ,CASE WHEN sps.PACK_SIZE_TYPE_CD = '' THEN '-1' ELSE IFNULL(sps.PACK_SIZE_TYPE_CD, '-1') END                                                                AS PACK_SIZE_TYPE_CD
    ,CASE WHEN sps.DELIVERY_TYPE_CD = '' THEN '-1' ELSE IFNULL(sps.DELIVERY_TYPE_CD, '-1') END                                                                  AS DELIVERY_TYPE_CD
    ,IFNULL(sps.DELIVERY_ADDR_SID, -1)                                                                                                                          AS DELIVERY_ADDR_SID
    ,CASE WHEN sps.DELIVERY_ZIP_SHORT_CD = '' THEN '-1' ELSE IFNULL(sps.DELIVERY_ZIP_SHORT_CD, '-1')::VARCHAR(20) END                                           AS DELIVERY_ZIP_SHORT_CD
    ,IFNULL(sps.HAULER_SID, -1)                                                                                                                                 AS HAULER_SID
    ,sps.HAULER_NAME                                                                                                                                            AS HAULER_NAME
    ,IFF(sps.HAULER_NAME = 'PL_DPD', (sps.PACK_LENGTH_MEAS * sps.PACK_WIDTH_MEAS * sps.PACK_HEIGHT_MEAS)/0.006, NULL)                                           AS PACK_VOLUMETRIC_WEIGHT_GROSS
    ,sps.PACK_HEIGHT_MEAS                                                                                                                                       AS PACK_HEIGHT_MEAS
    ,LEFT(sps.PACK_HEIGHT_MEAS || ' ' || UOM_PACK_HEIGHT.UOM_CD, 20)::VARCHAR(20)                                                                               AS PACK_HEIGHT_STR
    ,sps.PACK_HEIGHT_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                            AS PACK_HEIGHT_MEAS_STANDARD
    ,IFNULL(UOM_PACK_HEIGHT.UOM_STANDARD_CD, '-1')                                                                                                              AS PACK_HEIGHT_MEAS_STANDARD_UOM_CD
    ,sps.PACK_WIDTH_MEAS                                                                                                                                        AS PACK_WIDTH_MEAS
    ,LEFT(sps.PACK_WIDTH_MEAS || ' ' || UOM_PACK_WIDTH.UOM_CD, 20)::VARCHAR(20)                                                                                 AS PACK_WIDTH_STR
    ,sps.PACK_WIDTH_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                             AS PACK_WIDTH_MEAS_STANDARD
    ,IFNULL(UOM_PACK_WIDTH.UOM_STANDARD_CD, '-1')                                                                                                               AS PACK_WIDTH_MEAS_STANDARD_UOM_CD
    ,sps.PACK_LENGTH_MEAS                                                                                                                                       AS PACK_LENGTH_MEAS
    ,sps.PACK_MEAN_LENGTH_MEAS                                                                                                                                  AS PACK_MEAN_LENGTH_MEAS
    ,sps.PACK_SHORTEST_LENGTH_MEAS                                                                                                                              AS PACK_SHORTEST_LENGTH_MEAS
    ,sps.PACK_LONGEST_LENGTH_MEAS                                                                                                                               AS PACK_LONGEST_LENGTH_MEAS
    ,LEFT(sps.PACK_LENGTH_MEAS || ' ' || UOM_PACK_LENGTH.UOM_CD, 20)::VARCHAR(20)                                                                               AS PACK_LENGTH_STR
    ,sps.PACK_LENGTH_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                            AS PACK_LENGTH_MEAS_STANDARD
    ,LEFT(sps.PACK_MEAN_LENGTH_MEAS || ' ' || UOM_PACK_LENGTH.UOM_CD, 20)::VARCHAR(20)                                                                          AS PACK_MEAN_LENGTH_STR
    ,sps.PACK_MEAN_LENGTH_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                       AS PACK_MEAN_LENGTH_MEAS_STANDARD
    ,LEFT(sps.PACK_SHORTEST_LENGTH_MEAS || ' ' || UOM_PACK_LENGTH.UOM_CD, 20)::VARCHAR(20)                                                                      AS PACK_SHORTEST_LENGTH_STR
    ,sps.PACK_SHORTEST_LENGTH_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                   AS PACK_SHORTEST_LENGTH_MEAS_STANDARD
    ,LEFT(sps.PACK_LONGEST_LENGTH_MEAS || ' ' || UOM_PACK_LENGTH.UOM_CD, 20)::VARCHAR(20)                                                                       AS PACK_LONGEST_LENGTH_STR
    ,sps.PACK_LONGEST_LENGTH_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                    AS PACK_LONGEST_LENGTH_MEAS_STANDARD
    ,IFNULL(UOM_PACK_LENGTH.UOM_STANDARD_CD, '-1')                                                                                                              AS PACK_LENGTH_MEAS_STANDARD_UOM_CD
    ,sps.PACK_GIRTH_WEST_MEAS                                                                                                                                   AS PACK_GIRTH_WEST_MEAS
    ,sps.PACK_GIRTH_EAST_MEAS                                                                                                                                   AS PACK_GIRTH_EAST_MEAS
    ,LEFT(sps.PACK_GIRTH_WEST_MEAS || ' ' || UOM_PACK_GIRTH.UOM_CD, 20)::VARCHAR(20)                                                                            AS PACK_GIRTH_WEST_STR
    ,sps.PACK_GIRTH_WEST_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                        AS PACK_GIRTH_WEST_MEAS_STANDARD
    ,LEFT(sps.PACK_GIRTH_EAST_MEAS || ' ' || UOM_PACK_GIRTH.UOM_CD, 20)::VARCHAR(20)                                                                            AS PACK_GIRTH_EAST_STR
    ,sps.PACK_GIRTH_EAST_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                        AS PACK_GIRTH_EAST_MEAS_STANDARD
    ,IFNULL(UOM_PACK_GIRTH.UOM_STANDARD_CD, '-1')                                                                                                               AS PACK_GIRTH_MEAS_STANDARD_UOM_CD
    ,sps.PACK_WEIGHT_MEAS                                                                                                                                       AS PACK_WEIGHT_MEAS
    ,LEFT(sps.PACK_WEIGHT_MEAS || ' ' || UOM_PACK_WEIGHT.UOM_CD, 20)::VARCHAR(20)                                                                               AS PACK_WEIGHT_STR
    ,sps.PACK_WEIGHT_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                            AS PACK_WEIGHT_MEAS_STANDARD
    ,IFNULL(UOM_PACK_WEIGHT.UOM_STANDARD_CD, '-1')                                                                                                              AS PACK_WEIGHT_MEAS_STANDARD_UOM_CD
    ,sps.PACK_VOLUME_MEAS                                                                                                                                       AS PACK_VOLUME_MEAS
    ,LEFT(sps.PACK_VOLUME_MEAS || ' ' || UOM_PACK_VOLUME.UOM_CD, 20)::VARCHAR(20)                                                                               AS PACK_VOLUME_STR
    ,sps.PACK_VOLUME_MEAS * UOM_PACK_WIDTH.UOM_STANDARD_MULTIPL_MEAS                                                                                            AS PACK_VOLUME_MEAS_STANDARD
    ,IFNULL(UOM_PACK_VOLUME.UOM_STANDARD_CD, '-1')                                                                                                              AS PACK_VOLUME_MEAS_STANDARD_UOM_CD
    ,CASE WHEN sps.WEIGHT_CLASS_CD = '' THEN '-1' ELSE IFNULL(sps.WEIGHT_CLASS_CD, '-1') END                                                                    AS WEIGHT_CLASS_CD
    ,CASE WHEN sps.VOLUME_CLASS_CD = '' THEN '-1' ELSE IFNULL(sps.VOLUME_CLASS_CD, '-1') END                                                                    AS VOLUME_CLASS_CD
    ,IFNULL(sps.DELIVERY_ORDER_SID, -1)                                                                                                                         AS DELIVERY_ORDER_SID
    ,sps.PACK_MATERIAL_NR                                                                                                                                       AS PACK_MATERIAL_NR
    ,sps.WH_PUNCTUALITY_CD                                                                                                                                      AS WAREHOUSE_PUNCTUALITY                                       
    ,sps.HAULER_PUNCTUALITY_CD                                                                                                                                  AS SERVICE_PROVIDER_PUNCTUALITY
    ,sps.CUST_SHIP_PUNCTUALITY_CD                                                                                                                               AS CUSTOMER_PUNCTUALITY_SHIPMENT_LEVEL
    ,sps.PACK_ORDER_CREATE_PUNCTUALITY_CD                                                                                                                       AS EWM_ORDER_PUNCTUALITY
    ,CASE WHEN PACK_ORDER_CREATE_PUNCTUALITY_CD='zu spät' AND PACK_ORDER_ORIGINAL_CREATE_DATE=DATE(CONVERT_TIMEZONE('Europe/Berlin', sps.WH_LEAVE_TGT_TMSP)::TIMESTAMP_NTZ ) THEN 'T0'
          WHEN PACK_ORDER_CREATE_PUNCTUALITY_CD='zu spät' AND PACK_ORDER_ORIGINAL_CREATE_DATE>DATE(CONVERT_TIMEZONE('Europe/Berlin', sps.WH_LEAVE_TGT_TMSP)::TIMESTAMP_NTZ ) THEN 'T1_2'
          ELSE '-1' END                                                                                                                                         AS EWM_ORDER_DELAY_STATUS
    ,sps.WH_DELAY_HR                                                                                                                                            AS WAREHOUSE_DELAY_IN_HOURS                                    
    ,CEIL(sps.WH_DELAY_HR / 24)                                                                                                                                 AS WAREHOUSE_DELAY_IN_DAYS                                     
    ,sps.HAULER_DELAY_HR                                                                                                                                        AS SERVICE_PROVIDER_DELAY_IN_HOURS                    
    ,CEIL(sps.HAULER_DELAY_HR / 24)                                                                                                                             AS SERVICE_PROVIDER_DELAY_IN_DAYS                              
    ,sps.CUST_SHIP_DELAY_DAY                                                                                                                                    AS CUSTOMER_SHIPMENT_LEVEL_DELAY_IN_DAYS                       
    ,sps.VEHICLE_INTERNAL_NR                                                                                                                                    AS VEHICLE_INTERNAL_NR
	,sps.VEHICLE_LICENSE_PLATE_NR                                                                                                                               AS VEHICLE_LICENSE_PLATE_NR
	,CONVERT_TIMEZONE('Europe/Berlin', sps.VEHICLE_DEPARTURE_TMSP)::TIMESTAMP_NTZ                                                                               AS VEHICLE_DEPARTURE_TMSP
    ,TO_DATE(sps.VEHICLE_DEPARTURE_TMSP)                                                                                                                        AS VEHICLE_DEPARTURE_DATE
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.VEHICLE_LOADING_START_TMSP)::TIMESTAMP_NTZ                                                                           AS VEHICLE_LOADING_START_TMSP
    ,TO_DATE(sps.VEHICLE_LOADING_START_TMSP)                                                                                                                    AS VEHICLE_LOADING_START_DATE
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.VEHICLE_LOADING_END_TMSP)::TIMESTAMP_NTZ                                                                             AS VEHICLE_LOADING_END_TMSP
    ,TO_DATE(sps.VEHICLE_LOADING_END_TMSP)                                                                                                                      AS VEHICLE_LOADING_END_DATE
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.VEHICLE_HUB_LOADING_START_TMSP)::TIMESTAMP_NTZ                                                                       AS TRUCK_UNLOADING_START_AT_HUB_TMSP
    ,DATE(sps.VEHICLE_HUB_LOADING_START_TMSP)                                                                                                                   AS TRUCK_UNLOADING_START_AT_HUB_DATE
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.VEHICLE_HUB_LOADING_END_TMSP)::TIMESTAMP_NTZ                                                                         AS TRUCK_UNLOADING_STOP_AT_HUB_TMSP
    ,DATE(sps.VEHICLE_HUB_LOADING_END_TMSP)                                                                                                                     AS TRUCK_UNLOADING_STOP_AT_HUB_DATE
    ,sps.VEHICLE_HUB_LOADING_DUR_HR                                                                                                                             AS DURATION_OF_UNLOADING_AT_HUB_IN_H                           
    ,sps.VEHICLE_HUB_LOADING_PCT                                                                                                                                AS TRUCK_UNLOADING_STOP_AT_HUB_TMSP_PERCENTRANK_SELECTED_GROUP 
    ,sps.IS_GHOST_PACK_FG                                                                                                                                       AS IS_GHOST_PACK_FG                                            
    ,sps.IS_GHOST_PACK_RETURN_FG                                                                                                                                AS IS_GHOST_PACK_RETURN_FG                                     
    ,sps.IS_LOST_PACK_FG                                                                                                                                        AS IS_LOST_PACK_FG                
    ,CONVERT_TIMEZONE('Europe/Berlin', sps.PACK_RETURN_TMSP)::TIMESTAMP_NTZ                                                                                     AS PACK_RETURN_TMSP                                            
    ,DATE(sps.PACK_RETURN_TMSP)                                                                                                                                 AS PACK_RETURN_DATE 
    ,sps.GHOST_PACK_RETURN_DURATION_DAYS_CNT                                                                                                                    AS GHOST_PACK_RETURN_DURATION_DAYS_CNT                         
    ,sps.FIRST_HUB_LOC_DESCR                                                                                                                                    AS FIRST_HUB_LOC_DESCR
    ,sps.SECOND_HUB_LOC_DESCR                                                                                                                                   AS SECOND_HUB_LOC_DESCR
    ,REL_OP.PACK_POS_NR                                                                                                                                         AS PACK_POS_NR
    ,REL_OP.PROD_VARIANT_SID                                                                                                                                    AS PROD_VARIANT_SID
    ,COALESCE(REL_OP.CUST_ORDER_NR,'-1')                                                                                                                        AS CUST_ORDER_NR
    ,REL_OP.CUST_ORDER_POS_NR                                                                                                                                   AS CUST_ORDER_POS_NR
    ,COALESCE(REL_OP.IC_ORDER_NR,'-1')                                                                                                                          AS IC_ORDER_NR
    ,REL_OP.IC_ORDER_POS_NR                                                                                                                                     AS IC_ORDER_POS_NR
    ,REL_OP.DELIVERY_LABEL_FOR_RECYCLING_FG                                                                                                                     AS DELIVERY_LABEL_FOR_RECYCLING_FG        
    ,REL_OP.DELIVERY_TO_POINT_OF_USE_FG                                                                                                                         AS DELIVERY_TO_POINT_OF_USE_FG                 
    ,REL_OP.DELIVERY_PICK_UP_FOR_RECYCLING_FG                                                                                                                   AS DELIVERY_PICK_UP_FOR_RECYCLING_FG           
    ,REL_OP.DELIV_PROD_QTY                                                                                                                                      AS DELIV_PROD_QTY
    ,CONVERT_TIMEZONE('Europe/Berlin', FACT_COL.CUST_ORDER_CREATE_TMSP)::TIMESTAMP_NTZ                                                                          AS CUST_ORDER_CREATE_TMSP
    ,DATE(FACT_COL.CUST_ORDER_CREATE_TMSP)                                                                                                                      AS CUST_ORDER_CREATE_DATE
    ,CONVERT_TIMEZONE('Europe/Berlin', FACT_ICOL.IC_ORDER_CREATE_TMSP)::TIMESTAMP_NTZ                                                                           AS IC_ORDER_CREATE_TMSP
    ,DATE(FACT_ICOL.IC_ORDER_CREATE_TMSP)                                                                                                                       AS IC_ORDER_CREATE_DATE
    ,FACT_COL.CUST_ORDER_DT                                                                                                                                     AS CUST_ORDER_DT
    ,FACT_ICOL.IC_ORDER_DT                                                                                                                                      AS IC_ORDER_DT
    ,COALESCE(FACT_COL.CUST_ORDER_TYPE_CD,FACT_ICOL.CUST_ORDER_TYPE_CD)                                                                                         AS CUST_ORDER_TYPE_CD
    ,COALESCE(FACT_COL.CUST_PAYM_METHOD_CD,'-1')                                                                                                                AS CUST_PAYM_METHOD_CD      
FROM 
lec_share.v_rel_order_packaging_2 rel_op
LEFT OUTER JOIN
lec_share.v_fact_sales_package_shipment_2 sps
    ON rel_op.pack_sid = sps.pack_sid
LEFT OUTER JOIN
       lec_share.v_fact_customer_order_line_2 FACT_COL
            ON FACT_COL.CUST_ORDER_SID = REL_OP.CUST_ORDER_SID
               AND FACT_COL.CUST_ORDER_POS_NR = REL_OP.CUST_ORDER_POS_NR
LEFT OUTER JOIN                                                                            -- PARKSIDE
      lec_share.v_fact_intercompany_order_line_2  FACT_ICOL
            ON FACT_ICOL.IC_ORDER_SID = REL_OP.IC_ORDER_SID
               AND FACT_ICOL.IC_ORDER_POS_NR = REL_OP.IC_ORDER_POS_NR    
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT_2 UOM_PACK_HEIGHT ON UOM_PACK_HEIGHT.UOM_SID = IFNULL(SPS.PACK_HEIGHT_UOM_SID, '-1') 
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT_2 UOM_PACK_WIDTH ON UOM_PACK_WIDTH.UOM_SID = IFNULL(SPS.PACK_WIDTH_UOM_SID, '-1') 
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT_2 UOM_PACK_LENGTH ON UOM_PACK_LENGTH.UOM_SID = IFNULL(SPS.PACK_LENGTH_UOM_SID, '-1') 
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT_2 UOM_PACK_GIRTH ON UOM_PACK_GIRTH.UOM_SID = IFNULL(SPS.PACK_GIRTH_UOM_SID, '-1') 
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT_2 UOM_PACK_WEIGHT ON UOM_PACK_WEIGHT.UOM_SID = IFNULL(SPS.PACK_WEIGHT_UOM_SID, '-1') 
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT_2 UOM_PACK_VOLUME ON UOM_PACK_VOLUME.UOM_SID = IFNULL(SPS.PACK_VOLUME_UOM_SID, '-1') 

;