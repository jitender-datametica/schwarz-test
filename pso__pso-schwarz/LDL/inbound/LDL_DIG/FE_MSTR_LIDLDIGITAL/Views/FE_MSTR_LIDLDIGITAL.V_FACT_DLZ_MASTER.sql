CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_FACT_DLZ_MASTER(
	PACK_SID
	,PACK_POS_NR
	,DELIVERY_ORDER_SID
	,DELIVERY_ORDER_POS_NR
	,PROD_VARIANT_SID
	,DELIVERY_ORDER_NR
	,CUST_ORDER_SID
	,CUST_ORDER_POS_NR
	,IC_ORDER_SID
	,IC_ORDER_POS_NR
    ,DELIVERY_TO_POINT_OF_USE_FG
	,DELIVERY_PICK_UP_FOR_RECYCLING_FG
	,DELIVERY_LABEL_FOR_RECYCLING_FG
	,DELIV_PROD_QTY
	,DELIV_PROD_PRICE
	,DELIV_PROD_VAL
	,WSHOP_CD
	,DIST_CHANNEL_CD
	,PACK_TRACKING_NR
	,EWM_PACK_NR
	,PACK_TRACKING_URL
	,PACK_ORDER_NR
	,PACK_ORDER_TGT_CREATE_TMSP
	,PACK_ORDER_ACTUAL_CREATE_TMSP
	,PACK_ORDER_ACTUAL_CREATE_DATE
	,PACK_ORDER_ACTUAL_CREATE_TM
    ,PACK_ORDER_ORIGINAL_CREATE_TMSP
	,PACK_ORDER_ORIGINAL_CREATE_DATE
	,PACK_ORDER_ORIGINAL_CREATE_TM
	,CUST_DELIVERY_TGT_DT
	,CUST_DELIVERY_TGT_HAULER_TMSP
	,FIRST_ATTEMPT_DELIVERY_TMSP
	,CUST_DELIVERY_ACTUAL_TMSP
	,WH_SID
	,WH_LEAVE_TGT_TMSP
	,WH_LEAVE_ACTUAL_TMSP
	,FIRST_HUB_SCAN_ACTUAL_TMSP
	,FIRST_HUB_SCAN_TGT_TMSP
	,IS_DAMAGED_FG
	,PACK_SIZE_TYPE_CD
	,DELIVERY_TYPE_CD
	,DELIVERY_ADDR_SID
	,DELIVERY_ZIP_SHORT_CD
	,HAULER_SID
	,PACK_HEIGHT_MEAS
	,PACK_HEIGHT_STR
	,PACK_HEIGHT_MEAS_STANDARD_UOM_CD
	,PACK_WIDTH_MEAS
	,PACK_WIDTH_STR
	,PACK_WIDTH_MEAS_STANDARD_UOM_CD
	,PACK_LENGTH_MEAS
	,PACK_LONGEST_LENGTH_MEAS
	,PACK_LENGTH_STR
	,PACK_LONGEST_LENGTH_STR
	,PACK_LENGTH_MEAS_STANDARD_UOM_CD
	,PACK_GIRTH_WEST_MEAS
	,PACK_GIRTH_EAST_MEAS
	,PACK_GIRTH_WEST_STR
	,PACK_GIRTH_EAST_STR
	,PACK_WEIGHT_MEAS
	,PACK_WEIGHT_STR
	,PACK_WEIGHT_MEAS_STANDARD_UOM_CD
	,PACK_VOLUMETRIC_WEIGHT_GROSS
	,PACK_VOLUME_MEAS
	,PACK_VOLUME_STR
	,PACK_VOLUME_MEAS_STANDARD_UOM_CD
	,WEIGHT_CLASS_CD
	,VOLUME_CLASS_CD
	,PACK_MATERIAL_NR
	,WAREHOUSE_PUNCTUALITY
	,SERVICE_PROVIDER_PUNCTUALITY
    ,SERVICE_PROVIDER_PUNCTUALITY_LEGACY_DE
	,CUSTOMER_PUNCTUALITY_SHIPMENT_LEVEL
	,EWM_ORDER_PUNCTUALITY
    ,EWM_SYSTEM_PUNCTUALITY
	,WH_LEAVE_TGT_DATE
	,WH_LEAVE_ACTUAL_DATE
	,CUST_DELIVERY_TGT_HAULER_DATE
	,FIRST_ATTEMPT_DELIVERY_DATE
	,CUST_DELIVERY_ACTUAL_DATE
	,WAREHOUSE_DELAY_IN_HOURS
	,WAREHOUSE_DELAY_IN_DAYS
	,SERVICE_PROVIDER_DELAY_IN_HOURS
	,SERVICE_PROVIDER_DELAY_IN_DAYS
	,CUSTOMER_SHIPMENT_LEVEL_DELAY_IN_DAYS
	,EWM_ORDER_DELAY_IN_HOURS
	,EWM_ORDER_DELAY_IN_DAYS
    ,EWM_SYSTEM_DELAY_IN_HOURS
    ,EWM_SYSTEM_DELAY_IN_DAYS
	,CUST_ORDER_CREATE_TMSP
	,CUST_ORDER_DT
	,CUST_ORDER_NR
	,IC_ORDER_CREATE_TMSP
	,IC_ORDER_DT
	,IC_ORDER_NR
	,CUST_PAYM_METHOD_CD
	,CUST_ORDER_TYPE_CD
	,WH_CD
	,STOCK_PLACEMENT_CD
	,STOCK_REMOVAL_CD
	,FIRST_HUB_SCAN_ACTUAL_DATE
	,VEHICLE_INTERNAL_NR
	,VEHICLE_LICENSE_PLATE_NR
	,VEHICLE_DEPARTURE_TMSP
	,VEHICLE_DEPARTURE_DT
	,VEHICLE_LOADING_START_TMSP
	,VEHICLE_LOADING_END_TMSP
	,TRUCK_UNLOADING_START_AT_HUB_TMSP
	,TRUCK_UNLOADING_STOP_AT_HUB_TMSP
	,DURATION_OF_UNLOADING_AT_HUB_IN_H
	,TRUCK_UNLOADING_STOP_AT_HUB_TMSP_PERCENTRANK_SELECTED_GROUP
    ,IS_GHOST_PACK_FG
    ,IS_GHOST_PACK_RETURN_FG
    ,PACK_RETURN_TMSP
    ,GHOST_PACK_RETURN_DURATION_DAYS_CNT
    ,FIRST_HUB_LOC_DESCR
    ,SECOND_HUB_LOC_DESCR
) AS
WITH FACT_COL AS
(
            SELECT
                  COL_FACT.CUST_ORDER_SID                                                           AS CUST_ORDER_SID                 --pk                                                                          
                 ,COL_FACT.CUST_ORDER_POS_NR                                                        AS CUST_ORDER_POS_NR              --pk
                 ,CONVERT_TIMEZONE('Europe/Berlin', COL_FACT.CUST_ORDER_CREATE_TMSP)::TIMESTAMP_NTZ AS CUST_ORDER_CREATE_TMSP
                 ,COL_FACT.CUST_ORDER_DT                                                            AS CUST_ORDER_DT
                 ,IFNULL(COL_FACT.CUST_ORDER_NR, '-1')                                              AS CUST_ORDER_NR
                 ,IFNULL(COL_FACT.CUST_ORDER_TYPE_CD, '-1')                                         AS CUST_ORDER_TYPE_CD
                 ,IFNULL(COL_FACT.CUST_PAYM_METHOD_CD, '-1')                                        AS CUST_PAYM_METHOD_CD
                 --,COL_FACT.IS_BLOCKED_DELIVERY_FG                                                   AS IS_BLOCKED_DELIVERY_FG
                 --,COL_FACT.IS_ORDER_CANCEL_FG                                                       AS IS_ORDER_CANCEL_FG
                 --,IFNULL(COL_FACT.ORDER_CANCEL_REASON_CD, '-1')                                     AS ORDER_CANCEL_REASON_CD
                 ,COL_FACT.WH_SID                                                                   AS WH_SID
                 ,COL_FACT.WH_CD                                                                    AS WH_CD
                 ,COL_FACT.WSHOP_CD                                                                 AS WSHOP_CD
                 ,COL_FACT.DELIVERY_ADDR_SID                                                        AS DELIVERY_ADDR_SID
            
            FROM 
                 lec_share.v_fact_customer_order_line COL_FACT
            INNER JOIN
                 lec_share.v_dim_cal_day CAL_DIM
                    ON CAL_DIM.CAL_DT = COL_FACT.CUST_ORDER_DT
            WHERE
                 CAL_DIM.BUS_YEAR_OFFSET IN ( '0' , '-1' , '-2' ) 
)
,FACT_ICOL AS
(

            SELECT
                 
                  ICOL_FACT.IC_ORDER_SID                                                                      AS IC_ORDER_SID                    --pk
                 ,ICOL_FACT.IC_ORDER_POS_NR                                                                   AS IC_ORDER_POS_NR                 --pk
                 ,CONVERT_TIMEZONE('Europe/Berlin', ICOL_FACT.IC_ORDER_CREATE_TMSP)::TIMESTAMP_NTZ            AS IC_ORDER_CREATE_TMSP
                 ,ICOL_FACT.DIST_CHANNEL_CD                                                                   AS DIST_CHANNEL_CD
                 ,ICOL_FACT.WH_SID                                                                            AS WH_SID
                 ,ICOL_FACT.WH_CD                                                                             AS WH_CD
                 ,ICOL_FACT.IC_ORDER_DT                                                                       AS IC_ORDER_DT
                 --,IC_ORDER_TM                                                                          IC_ORDER_TM
                 --,IC_ORDER_CREATE_TIME                                                                 IC_ORDER_CREATE_TIME
                 --,IC_ORDER_CREATE_DATE                                                                 IC_ORDER_CREATE_DATE
                 ,ICOL_FACT.IC_ORDER_NR                                                                       AS IC_ORDER_NR
                 --,IS_ORDER_CANCEL_FG                                                                   IS_ORDER_CANCEL_FG
                 --,CUST_ORDER_PERFORM_DT                                                                CUST_ORDER_PERFORM_DT
                 ,ICOL_FACT.DELIVERY_ADDR_SID                                                                 AS DELIVERY_ADDR_SID
                 ,ICOL_FACT.CUST_ORDER_TYPE_CD                                                                AS CUST_ORDER_TYPE_CD
            FROM                                                     
                 lec_share.v_fact_intercompany_order_line ICOL_FACT
            INNER JOIN
                 lec_share.v_dim_cal_day CAL_DIM
                    ON CAL_DIM.CAL_DT = ICOL_FACT.IC_ORDER_DT
            WHERE
                 CAL_DIM.BUS_YEAR_OFFSET IN ( '0' , '-1' , '-2' ) 
)
,FACT_SPS_CTE AS
(
            SELECT                                                                                                                                                                
                 FACT_SPS.PACK_SID                                                                                                                                           AS PACK_SID                                --pk
                ,IFNULL(FACT_SPS.DELIVERY_ORDER_SID, -1)                                                                                                                     AS DELIVERY_ORDER_SID
                ,FACT_SPS.DELIVERY_ORDER_NR                                                                                                                                  AS DELIVERY_ORDER_NR
                ,IFNULL(FACT_SPS.WSHOP_CD,'-1')                                                                                                                              AS WSHOP_CD
                ,FACT_SPS.DIST_CHANNEL_CD                                                                                                                                    AS DIST_CHANNEL_CD
                ,FACT_SPS.PACK_TRACKING_NR                                                                                                                                   AS PACK_TRACKING_NR
                ,FACT_SPS.EWM_PACK_NR                                                                                                                                        AS EWM_PACK_NR 
                ,FACT_SPS.PACK_TRACKING_URL                                                                                                                                  AS PACK_TRACKING_URL
                ,FACT_SPS.PACK_ORDER_NR                                                                                                                                      AS PACK_ORDER_NR
                ,CONVERT_TIMEZONE('Europe/Berlin', FACT_SPS.PACK_ORDER_TGT_CREATE_TMSP)::TIMESTAMP_NTZ                                                                       AS PACK_ORDER_TGT_CREATE_TMSP
                ,CONVERT_TIMEZONE('Europe/Berlin', FACT_SPS.PACK_ORDER_ACTUAL_CREATE_TMSP)::TIMESTAMP_NTZ                                                                    AS PACK_ORDER_ACTUAL_CREATE_TMSP
                ,DATE(FACT_SPS.PACK_ORDER_ACTUAL_CREATE_TMSP)                                                                                                                AS PACK_ORDER_ACTUAL_CREATE_DATE
                ,TO_TIME(FACT_SPS.PACK_ORDER_ACTUAL_CREATE_TMSP)                                                                                                             AS PACK_ORDER_ACTUAL_CREATE_TM
                ,CONVERT_TIMEZONE('Europe/Berlin', COALESCE(FACT_SPS.PACK_ORDER_ORIG_CREATE_TMSP, FACT_SPS.PACK_ORDER_ACTUAL_CREATE_TMSP))::TIMESTAMP_NTZ					 AS PACK_ORDER_ORIGINAL_CREATE_TMSP
				,DATE(PACK_ORDER_ORIGINAL_CREATE_TMSP) 																														 AS PACK_ORDER_ORIGINAL_CREATE_DATE
				,TO_TIME(PACK_ORDER_ORIGINAL_CREATE_TMSP) 																													 AS PACK_ORDER_ORIGINAL_CREATE_TM
                ,FACT_SPS.CUST_DELIVERY_TGT_DT                                                                                                                               AS CUST_DELIVERY_TGT_DT
                ,CONVERT_TIMEZONE('Europe/Berlin', FACT_SPS.CUST_DELIVERY_TGT_HAULER_TMSP)::TIMESTAMP_NTZ                                                                    AS CUST_DELIVERY_TGT_HAULER_TMSP
                ,CONVERT_TIMEZONE('Europe/Berlin', FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP)::TIMESTAMP_NTZ                                                                      AS FIRST_ATTEMPT_DELIVERY_TMSP
                ,CONVERT_TIMEZONE('Europe/Berlin', FACT_SPS.CUST_DELIVERY_ACTUAL_TMSP)::TIMESTAMP_NTZ                                                                        AS CUST_DELIVERY_ACTUAL_TMSP
                ,IFNULL(FACT_SPS.WH_SID, -1)                                                                                                                                 AS WH_SID
                ,CONVERT_TIMEZONE('Europe/Berlin', FACT_SPS.WH_LEAVE_TGT_TMSP)::TIMESTAMP_NTZ                                                                                AS WH_LEAVE_TGT_TMSP
                ,CONVERT_TIMEZONE('Europe/Berlin', FACT_SPS.WH_LEAVE_ACTUAL_TMSP)::TIMESTAMP_NTZ                                                                             AS WH_LEAVE_ACTUAL_TMSP
                ,CONVERT_TIMEZONE('Europe/Berlin',FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP)::TIMESTAMP_NTZ                                                                        AS FIRST_HUB_SCAN_ACTUAL_TMSP
                ,NULL                                                                                                                                                        AS FIRST_HUB_SCAN_TGT_TMSP
                ,FACT_SPS.IS_DAMAGED_FG                                                                                                                                      AS IS_DAMAGED_FG
                ,CASE WHEN FACT_SPS.PACK_SIZE_TYPE_CD = '' THEN '-1' ELSE IFNULL(FACT_SPS.PACK_SIZE_TYPE_CD, '-1') END                                                       AS PACK_SIZE_TYPE_CD
                ,CASE WHEN FACT_SPS.DELIVERY_TYPE_CD = '' THEN '-1' ELSE IFNULL(FACT_SPS.DELIVERY_TYPE_CD, '-1') END                                                         AS DELIVERY_TYPE_CD
                ,IFNULL(FACT_SPS.DELIVERY_ADDR_SID, -1)                                                                                                                      AS DELIVERY_ADDR_SID
                ,CASE WHEN FACT_SPS.DELIVERY_ZIP_SHORT_CD = '' THEN '-1' ELSE IFNULL(FACT_SPS.DELIVERY_ZIP_SHORT_CD, '-1') END                                               AS DELIVERY_ZIP_SHORT_CD
                ,IFNULL(FACT_SPS.HAULER_SID, -1)                                                                                                                             AS HAULER_SID
                ,FACT_SPS.PACK_HEIGHT_MEAS                                                                                                                                   AS PACK_HEIGHT_MEAS
                ,LEFT(FACT_SPS.PACK_HEIGHT_MEAS || ' ' || UOM_PACK_HEIGHT.UOM_CD, 20)::VARCHAR(20)                                                                           AS PACK_HEIGHT_STR
                ,IFNULL(UOM_PACK_HEIGHT.UOM_STANDARD_CD, '-1')                                                                                                               AS PACK_HEIGHT_MEAS_STANDARD_UOM_CD
                ,FACT_SPS.PACK_WIDTH_MEAS                                                                                                                                    AS PACK_WIDTH_MEAS
                ,LEFT(FACT_SPS.PACK_WIDTH_MEAS || ' ' || UOM_PACK_WIDTH.UOM_CD, 20)::VARCHAR(20)                                                                             AS PACK_WIDTH_STR
                ,IFNULL(UOM_PACK_WIDTH.UOM_STANDARD_CD, '-1')                                                                                                                AS PACK_WIDTH_MEAS_STANDARD_UOM_CD
                ,FACT_SPS.PACK_LENGTH_MEAS                                                                                                                                   AS PACK_LENGTH_MEAS
                ,FACT_SPS.PACK_LONGEST_LENGTH_MEAS                                                                                                                           AS PACK_LONGEST_LENGTH_MEAS
                ,LEFT(FACT_SPS.PACK_LENGTH_MEAS || ' ' || UOM_PACK_LENGTH.UOM_CD, 20)::VARCHAR(20)                                                                           AS PACK_LENGTH_STR
                ,LEFT(FACT_SPS.PACK_LONGEST_LENGTH_MEAS || ' ' || UOM_PACK_LENGTH.UOM_CD, 20)::VARCHAR(20)                                                                   AS PACK_LONGEST_LENGTH_STR
                ,IFNULL(UOM_PACK_LENGTH.UOM_STANDARD_CD, '-1')                                                                                                               AS PACK_LENGTH_MEAS_STANDARD_UOM_CD
                ,FACT_SPS.PACK_GIRTH_WEST_MEAS                                                                                                                               AS PACK_GIRTH_WEST_MEAS
                ,FACT_SPS.PACK_GIRTH_EAST_MEAS                                                                                                                               AS PACK_GIRTH_EAST_MEAS
                ,LEFT(FACT_SPS.PACK_GIRTH_WEST_MEAS || ' ' || UOM_PACK_GIRTH.UOM_CD, 20)::VARCHAR(20)                                                                        AS PACK_GIRTH_WEST_STR
                ,LEFT(FACT_SPS.PACK_GIRTH_EAST_MEAS || ' ' || UOM_PACK_GIRTH.UOM_CD, 20)::VARCHAR(20)                                                                        AS PACK_GIRTH_EAST_STR
                ,FACT_SPS.PACK_WEIGHT_MEAS                                                                                                                                   AS PACK_WEIGHT_MEAS
                ,LEFT(FACT_SPS.PACK_WEIGHT_MEAS || ' ' || UOM_PACK_WEIGHT.UOM_CD, 20)::VARCHAR(20)                                                                           AS PACK_WEIGHT_STR
                ,IFNULL(UOM_PACK_WEIGHT.UOM_STANDARD_CD, '-1')                                                                                                               AS PACK_WEIGHT_MEAS_STANDARD_UOM_CD
                ,FACT_SPS.PACK_VOLUME_MEAS                                                                                                                                   AS PACK_VOLUME_MEAS
                ,LEFT(FACT_SPS.PACK_VOLUME_MEAS || ' ' || UOM_PACK_VOLUME.UOM_CD, 20)::VARCHAR(20)                                                                           AS PACK_VOLUME_STR
                ,IFNULL(UOM_PACK_VOLUME.UOM_STANDARD_CD, '-1')                                                                                                               AS PACK_VOLUME_MEAS_STANDARD_UOM_CD
                ,CASE WHEN FACT_SPS.WEIGHT_CLASS_CD = '' THEN '-1' ELSE IFNULL(FACT_SPS.WEIGHT_CLASS_CD, '-1') END                                                           AS WEIGHT_CLASS_CD
                ,CASE WHEN FACT_SPS.VOLUME_CLASS_CD = '' THEN '-1' ELSE IFNULL(FACT_SPS.VOLUME_CLASS_CD, '-1') END                                                           AS VOLUME_CLASS_CD
                ,FACT_SPS.PACK_MATERIAL_NR                                                                                                                                   AS PACK_MATERIAL_NR
                ,CASE WHEN TIMESTAMPDIFF(SECOND, FACT_SPS.WH_LEAVE_TGT_TMSP, FACT_SPS.WH_LEAVE_ACTUAL_TMSP) <= 0 THEN 'pünktlich'
                      WHEN TIMESTAMPDIFF(SECOND, FACT_SPS.WH_LEAVE_TGT_TMSP, FACT_SPS.WH_LEAVE_ACTUAL_TMSP) > 0  THEN 'zu spät'
                      ELSE 'WA ausstehend'
                      END                                                                                                                                                    AS WAREHOUSE_PUNCTUALITY
                ,CASE WHEN (DATEDIFF(DAY, FACT_SPS.CUST_DELIVERY_TGT_HAULER_TMSP, FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP) - FE_MSTR_LIDLDIGITAL.F_COUNT_HOLIDAYS_AND_SUNDAYS_AND_SATURDAYS(DIST_CH.DIST_COUNTRY_CD, DATE(FACT_SPS.CUST_DELIVERY_TGT_HAULER_TMSP), DATE(FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP)) <= 0) THEN 'pünktlich'
                      WHEN (DATEDIFF(DAY, FACT_SPS.CUST_DELIVERY_TGT_HAULER_TMSP, FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP) - FE_MSTR_LIDLDIGITAL.F_COUNT_HOLIDAYS_AND_SUNDAYS_AND_SATURDAYS(DIST_CH.DIST_COUNTRY_CD, DATE(FACT_SPS.CUST_DELIVERY_TGT_HAULER_TMSP), DATE(FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP))  > 0) THEN 'zu spät'
                      WHEN FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP IS NOT NULL AND FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP IS NULL THEN 'Sendung offen'
                      ELSE 'WE Scan ausstehend'
                      END                                                                                                                                                    AS SERVICE_PROVIDER_PUNCTUALITY
                ,CASE WHEN (DIST_CH.DIST_COUNTRY_CD = 'DE' AND TO_TIME(FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP) <= '18:00:00' AND DATEDIFF(DAY, FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP, FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP) - FE_MSTR_LIDLDIGITAL.F_COUNT_HOLIDAYS_AND_SUNDAYS_AND_SATURDAYS(DIST_CH.DIST_COUNTRY_CD, DATE(FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP), DATE(FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP)) <= 1) THEN 'pünktlich'
                      WHEN (DIST_CH.DIST_COUNTRY_CD = 'DE' AND TO_TIME(FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP) >  '18:00:00' AND DATEDIFF(DAY, FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP, FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP) - FE_MSTR_LIDLDIGITAL.F_COUNT_HOLIDAYS_AND_SUNDAYS_AND_SATURDAYS(DIST_CH.DIST_COUNTRY_CD, DATE(FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP), DATE(FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP)) <= 2) THEN 'pünktlich' 
                      WHEN (DIST_CH.DIST_COUNTRY_CD = 'DE' AND TO_TIME(FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP) <= '18:00:00' AND DATEDIFF(DAY, FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP, FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP) - FE_MSTR_LIDLDIGITAL.F_COUNT_HOLIDAYS_AND_SUNDAYS_AND_SATURDAYS(DIST_CH.DIST_COUNTRY_CD, DATE(FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP), DATE(FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP))  > 1) THEN 'zu spät'
                      WHEN (DIST_CH.DIST_COUNTRY_CD = 'DE' AND TO_TIME(FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP) >  '18:00:00' AND DATEDIFF(DAY, FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP, FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP) - FE_MSTR_LIDLDIGITAL.F_COUNT_HOLIDAYS_AND_SUNDAYS_AND_SATURDAYS(DIST_CH.DIST_COUNTRY_CD, DATE(FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP), DATE(FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP))  > 2) THEN 'zu spät'       
                      WHEN (DATEDIFF(DAY, FACT_SPS.CUST_DELIVERY_TGT_HAULER_TMSP, FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP) - FE_MSTR_LIDLDIGITAL.F_COUNT_HOLIDAYS_AND_SUNDAYS_AND_SATURDAYS(DIST_CH.DIST_COUNTRY_CD, DATE(FACT_SPS.CUST_DELIVERY_TGT_HAULER_TMSP), DATE(FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP)) <= 0) THEN 'pünktlich'
                      WHEN (DATEDIFF(DAY, FACT_SPS.CUST_DELIVERY_TGT_HAULER_TMSP, FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP) - FE_MSTR_LIDLDIGITAL.F_COUNT_HOLIDAYS_AND_SUNDAYS_AND_SATURDAYS(DIST_CH.DIST_COUNTRY_CD, DATE(FACT_SPS.CUST_DELIVERY_TGT_HAULER_TMSP), DATE(FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP))  > 0) THEN 'zu spät'
                      WHEN FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP IS NOT NULL AND FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP IS NULL THEN 'Sendung offen'
                      ELSE 'WE Scan ausstehend'
                      END                                                                                                                                                    AS SERVICE_PROVIDER_PUNCTUALITY_LEGACY_DE
                ,CASE WHEN (FACT_SPS.DELIVERY_POSTPONED_TGT_TMSP IS NOT NULL AND FACT_SPS.WSHOP_CD = 'DE')     
                           OR DATEDIFF(DAY, FACT_SPS.CUST_DELIVERY_TGT_DT, FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP) <= 0 THEN 'pünktlich'
                      WHEN DATEDIFF(DAY, FACT_SPS.CUST_DELIVERY_TGT_DT, FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP) > 0  THEN 'zu spät'
                      ELSE 'Zustellung nicht bestätigt'
                      END                                                                                                                                                    AS CUSTOMER_PUNCTUALITY_SHIPMENT_LEVEL
                ,CASE WHEN (PACK_ORDER_ORIGINAL_CREATE_DATE = DATE(FACT_SPS.WH_LEAVE_TGT_TMSP) AND PACK_ORDER_ORIGINAL_CREATE_TM <= '02:00:00') OR (PACK_ORDER_ORIGINAL_CREATE_DATE < DATE(FACT_SPS.WH_LEAVE_TGT_TMSP)) THEN 'pünktlich'
                      WHEN (PACK_ORDER_ORIGINAL_CREATE_DATE = DATE(FACT_SPS.WH_LEAVE_TGT_TMSP) AND PACK_ORDER_ORIGINAL_CREATE_TM > '02:00:00') OR (PACK_ORDER_ORIGINAL_CREATE_DATE > DATE(FACT_SPS.WH_LEAVE_TGT_TMSP)) THEN 'zu spät'
                      ELSE 'NA'
                      END                                                                                                                                                    AS EWM_ORDER_PUNCTUALITY
                ,CASE WHEN TIMESTAMPDIFF(SECOND, FACT_SPS.PACK_ORDER_TGT_CREATE_TMSP, PACK_ORDER_ORIGINAL_CREATE_TMSP) <= 0 THEN 'pünktlich'
                      WHEN TIMESTAMPDIFF(SECOND, FACT_SPS.PACK_ORDER_TGT_CREATE_TMSP, PACK_ORDER_ORIGINAL_CREATE_TMSP) > 0  THEN 'zu spät'
                      ELSE 'NA'
                      END                                                                                                                                                    AS EWM_SYSTEM_PUNCTUALITY
                ,DATE(FACT_SPS.WH_LEAVE_TGT_TMSP)                                                                                                                            AS WH_LEAVE_TGT_DATE
                ,DATE(FACT_SPS.WH_LEAVE_ACTUAL_TMSP)                                                                                                                         AS WH_LEAVE_ACTUAL_DATE
                ,DATE(FACT_SPS.CUST_DELIVERY_TGT_HAULER_TMSP)                                                                                                                AS CUST_DELIVERY_TGT_HAULER_DATE
                ,DATE(FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP)                                                                                                                  AS FIRST_ATTEMPT_DELIVERY_DATE
                ,DATE(FACT_SPS.CUST_DELIVERY_ACTUAL_TMSP)                                                                                                                    AS CUST_DELIVERY_ACTUAL_DATE
                ,CASE WHEN WAREHOUSE_PUNCTUALITY = 'zu spät'   THEN (DATEDIFF(SECOND, FACT_SPS.WH_LEAVE_TGT_TMSP, FACT_SPS.WH_LEAVE_ACTUAL_TMSP) - FE_MSTR_LIDLDIGITAL.F_COUNT_HOLIDAYS_AND_SUNDAYS_AND_SATURDAYS(FACT_SPS.WSHOP_CD, DATE(FACT_SPS.WH_LEAVE_TGT_TMSP), DATE(FACT_SPS.WH_LEAVE_ACTUAL_TMSP)) * 86400) / 3600 
                      WHEN WAREHOUSE_PUNCTUALITY = 'pünktlich' THEN 0 
                      ELSE NULL 
                      END                                                                                                                                                    AS WAREHOUSE_DELAY_IN_HOURS
                ,CEIL(WAREHOUSE_DELAY_IN_HOURS / 24)                                                                                                                         AS WAREHOUSE_DELAY_IN_DAYS
                ,CASE WHEN SERVICE_PROVIDER_PUNCTUALITY = 'zu spät'   THEN (DATEDIFF(SECOND, FACT_SPS.CUST_DELIVERY_TGT_HAULER_TMSP, FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP) - FE_MSTR_LIDLDIGITAL.F_COUNT_HOLIDAYS_AND_SUNDAYS_AND_SATURDAYS(DIST_CH.DIST_COUNTRY_CD, DATE(FACT_SPS.CUST_DELIVERY_TGT_HAULER_TMSP), DATE(FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP))  * 86400 ) / 3600
                      WHEN SERVICE_PROVIDER_PUNCTUALITY = 'pünktlich' THEN 0 
                      ELSE NULL 
                      END                                                                                                                                                    AS SERVICE_PROVIDER_DELAY_IN_HOURS
                ,CEIL(SERVICE_PROVIDER_DELAY_IN_HOURS / 24)                                                                                                                  AS SERVICE_PROVIDER_DELAY_IN_DAYS
                ,CASE WHEN CUSTOMER_PUNCTUALITY_SHIPMENT_LEVEL = 'zu spät'   THEN DATEDIFF(DAY, FACT_SPS.CUST_DELIVERY_TGT_DT, FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP) 
                      WHEN CUSTOMER_PUNCTUALITY_SHIPMENT_LEVEL = 'pünktlich' THEN 0 
                      ELSE NULL 
                      END                                                                                                                                                    AS CUSTOMER_SHIPMENT_LEVEL_DELAY_IN_DAYS
                ,CASE WHEN (PACK_ORDER_ORIGINAL_CREATE_DATE = DATE(FACT_SPS.WH_LEAVE_TGT_TMSP) AND PACK_ORDER_ORIGINAL_CREATE_TM > '02:00:00') THEN 0
                      WHEN EWM_ORDER_PUNCTUALITY = 'zu spät' THEN (DATEDIFF(SECOND, FACT_SPS.WH_LEAVE_TGT_TMSP, PACK_ORDER_ORIGINAL_CREATE_TMSP) - FE_MSTR_LIDLDIGITAL.F_COUNT_HOLIDAYS_AND_SUNDAYS_AND_SATURDAYS(FACT_SPS.WSHOP_CD, DATE(FACT_SPS.WH_LEAVE_TGT_TMSP), DATE(PACK_ORDER_ORIGINAL_CREATE_TMSP)) * 86400) / 3600
                      WHEN EWM_ORDER_PUNCTUALITY = 'pünktlich' THEN 0
                      ELSE NULL
                      END                                                                                                                                                    AS EWM_ORDER_DELAY_IN_HOURS
                ,CEIL(EWM_ORDER_DELAY_IN_HOURS / 24)                                                                                                                         AS EWM_ORDER_DELAY_IN_DAYS
                ,CASE WHEN EWM_SYSTEM_PUNCTUALITY = 'zu spät'   THEN (DATEDIFF(SECOND, FACT_SPS.PACK_ORDER_TGT_CREATE_TMSP, PACK_ORDER_ORIGINAL_CREATE_TMSP) - FE_MSTR_LIDLDIGITAL.F_COUNT_HOLIDAYS_AND_SUNDAYS_AND_SATURDAYS(FACT_SPS.WSHOP_CD, DATE(FACT_SPS.PACK_ORDER_TGT_CREATE_TMSP), DATE(PACK_ORDER_ORIGINAL_CREATE_TMSP)) * 86400) / 3600 
                      WHEN EWM_SYSTEM_PUNCTUALITY = 'pünktlich' THEN 0 
                      ELSE NULL 
                      END                                                                                                                                                    AS EWM_SYSTEM_DELAY_IN_HOURS
                ,CEIL(EWM_SYSTEM_DELAY_IN_HOURS / 24)                                                                                                                        AS EWM_SYSTEM_DELAY_IN_DAYS
                ,FACT_SPS.VEHICLE_INTERNAL_NR                                                                                                                                AS VEHICLE_INTERNAL_NR
                ,FACT_SPS.VEHICLE_LICENSE_PLATE_NR                                                                                                                           AS VEHICLE_LICENSE_PLATE_NR
                ,CONVERT_TIMEZONE('Europe/Berlin', FACT_SPS.VEHICLE_DEPARTURE_TMSP)::TIMESTAMP_NTZ                                                                           AS VEHICLE_DEPARTURE_TMSP
                ,TO_DATE(FACT_SPS.VEHICLE_DEPARTURE_TMSP)                                                                                                                    AS VEHICLE_DEPARTURE_DT
                ,CONVERT_TIMEZONE('Europe/Berlin', FACT_SPS.VEHICLE_LOADING_START_TMSP)::TIMESTAMP_NTZ                                                                       AS VEHICLE_LOADING_START_TMSP
                ,CONVERT_TIMEZONE('Europe/Berlin', FACT_SPS.VEHICLE_LOADING_END_TMSP)::TIMESTAMP_NTZ                                                                         AS VEHICLE_LOADING_END_TMSP
                ,MIN(CONVERT_TIMEZONE('Europe/Berlin',FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP)::TIMESTAMP_NTZ) OVER (PARTITION BY VEHICLE_LICENSE_PLATE_NR,VEHICLE_DEPARTURE_TMSP)                                                           AS TRUCK_UNLOADING_START_AT_HUB_TMSP                                         
                ,IFF(
				         TRUNC(PERCENT_RANK() OVER (PARTITION BY VEHICLE_LICENSE_PLATE_NR, VEHICLE_DEPARTURE_TMSP ORDER BY FIRST_HUB_SCAN_ACTUAL_TMSP NULLS FIRST)*100)< 95
				        ,0
				        ,TRUNC(PERCENT_RANK() OVER (PARTITION BY VEHICLE_LICENSE_PLATE_NR, VEHICLE_DEPARTURE_TMSP ORDER BY FIRST_HUB_SCAN_ACTUAL_TMSP NULLS FIRST)*100)
                    )::INTEGER                                                                                                                                               AS TRUCK_UNLOADING_STOP_AT_HUB_TMSP_PERCENTRANK_SELECTED_GROUP
                ,IS_GHOST_PACK_FG AS  IS_GHOST_PACK_FG
                ,IS_GHOST_PACK_RETURN_FG AS IS_GHOST_PACK_RETURN_FG
                ,PACK_RETURN_TMSP AS PACK_RETURN_TMSP
                ,GHOST_PACK_RETURN_DURATION_DAYS_CNT AS GHOST_PACK_RETURN_DURATION_DAYS_CNT
                ,FIRST_HUB_LOC_DESCR AS FIRST_HUB_LOC_DESCR
                ,SECOND_HUB_LOC_DESCR AS SECOND_HUB_LOC_DESCR
            FROM 
                lec_share.v_fact_sales_package_shipment FACT_SPS
            INNER JOIN
               FE_MSTR_LIDLDIGITAL.V_DIM_CAL_DAY CALDAY
                   ON FACT_SPS.CUST_DELIVERY_TGT_DT = CALDAY.CAL_DT
            LEFT JOIN
                FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT UOM_PACK_HEIGHT 
                    ON UOM_PACK_HEIGHT.UOM_SID = IFNULL(FACT_SPS.PACK_HEIGHT_UOM_SID, '-1') 
            LEFT JOIN
                FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT UOM_PACK_WIDTH 
                    ON UOM_PACK_WIDTH.UOM_SID = IFNULL(FACT_SPS.PACK_WIDTH_UOM_SID, '-1') 
            LEFT JOIN
                FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT UOM_PACK_LENGTH 
                    ON UOM_PACK_LENGTH.UOM_SID = IFNULL(FACT_SPS.PACK_LENGTH_UOM_SID, '-1') 
            LEFT JOIN
                FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT UOM_PACK_GIRTH 
                    ON UOM_PACK_GIRTH.UOM_SID = IFNULL(FACT_SPS.PACK_GIRTH_UOM_SID, '-1') 
            LEFT JOIN
                FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT UOM_PACK_WEIGHT 
                    ON UOM_PACK_WEIGHT.UOM_SID = IFNULL(FACT_SPS.PACK_WEIGHT_UOM_SID, '-1') 
            LEFT JOIN
                FE_MSTR_LIDLDIGITAL.V_DIM_UNIT_OF_MEASUREMENT UOM_PACK_VOLUME 
                    ON UOM_PACK_VOLUME.UOM_SID = IFNULL(FACT_SPS.PACK_VOLUME_UOM_SID, '-1') 
            LEFT JOIN
				FE_MSTR_LIDLDIGITAL.V_DIM_DISTRIBUTION_CHANNEL DIST_CH
					ON FACT_SPS.DIST_CHANNEL_CD = DIST_CH.DIST_CHANNEL_CD
            WHERE
                CALDAY.CY_WEEK_OFFSET >= -13
)

SELECT
     IFNULL(REL_OP.PACK_SID, '-1') AS PACK_SID
    ,IFNULL(REL_OP.PACK_POS_NR, '-1') AS PACK_POS_NR
    ,COALESCE(REL_OP.DELIVERY_ORDER_SID, FACT_SPS.DELIVERY_ORDER_SID) AS DELIVERY_ORDER_SID
    ,IFNULL(REL_OP.DELIVERY_ORDER_POS_NR, -1) AS DELIVERY_ORDER_POS_NR
    ,IFNULL(REL_OP.PROD_VARIANT_SID, '-1') AS PROD_VARIANT_SID
    ,COALESCE(REL_OP.DELIVERY_ORDER_NR, FACT_SPS.DELIVERY_ORDER_NR)::VARCHAR(20) AS DELIVERY_ORDER_NR -- converting to varchar due different data types in base tables
    ,IFNULL(REL_OP.CUST_ORDER_SID, '-1') AS CUST_ORDER_SID
    ,IFNULL(REL_OP.CUST_ORDER_POS_NR, '-1') AS CUST_ORDER_POS_NR
    ,IFNULL(REL_OP.IC_ORDER_SID,'-1') AS IC_ORDER_SID                                                                                    --PARKSIDE
    ,IFNULL(REL_OP.IC_ORDER_POS_NR,'-1') AS IC_ORDER_POS_NR                                                                              --PARKSIDE
    ,REL_OP.DELIVERY_TO_POINT_OF_USE_FG AS DELIVERY_TO_POINT_OF_USE_FG
    ,REL_OP.DELIVERY_PICK_UP_FOR_RECYCLING_FG AS DELIVERY_PICK_UP_FOR_RECYCLING_FG
    ,REL_OP.DELIVERY_LABEL_FOR_RECYCLING_FG AS DELIVERY_LABEL_FOR_RECYCLING_FG
    ,REL_OP.DELIV_PROD_QTY AS DELIV_PROD_QTY
    ,REL_OP.DELIV_PROD_PRICE AS DELIV_PROD_PRICE
    ,REL_OP.DELIV_PROD_VAL AS DELIV_PROD_VAL  
    ,COALESCE(FACT_SPS.WSHOP_CD, FACT_COL.WSHOP_CD,'-1') AS WSHOP_CD                                                                      --PARKSIDE: no webshop code in FACT_ICOL!!!
    ,FACT_SPS.DIST_CHANNEL_CD AS DIST_CHANNEL_CD                                                                                          --PARKSIDE
    --,COALESCE(FACT_CPS.CUST_SID, FACT_COL.CUST_SID,FACT_ICOL.CUST_SID) AS CUST_SID                                                        --PARKSIDE: FACT_ICOL!!!
    ,FACT_SPS.PACK_TRACKING_NR AS PACK_TRACKING_NR
    ,FACT_SPS.EWM_PACK_NR AS EWM_PACK_NR
    ,FACT_SPS.PACK_TRACKING_URL AS PACK_TRACKING_URL
    ,FACT_SPS.PACK_ORDER_NR AS PACK_ORDER_NR
    ,FACT_SPS.PACK_ORDER_TGT_CREATE_TMSP AS PACK_ORDER_TGT_CREATE_TMSP -- timestamps are converted to Berlin time so that they are properly displayed in MSTR (see NBI-5080)
    ,FACT_SPS.PACK_ORDER_ACTUAL_CREATE_TMSP AS PACK_ORDER_ACTUAL_CREATE_TMSP
    ,FACT_SPS.PACK_ORDER_ACTUAL_CREATE_DATE AS PACK_ORDER_ACTUAL_CREATE_DATE
    ,FACT_SPS.PACK_ORDER_ACTUAL_CREATE_TM AS PACK_ORDER_ACTUAL_CREATE_TM
    ,FACT_SPS.PACK_ORDER_ORIGINAL_CREATE_TMSP AS PACK_ORDER_ORIGINAL_CREATE_TMSP
    ,FACT_SPS.PACK_ORDER_ORIGINAL_CREATE_DATE AS PACK_ORDER_ORIGINAL_CREATE_DATE
    ,FACT_SPS.PACK_ORDER_ORIGINAL_CREATE_TM AS PACK_ORDER_ORIGINAL_CREATE_TM
    ,FACT_SPS.CUST_DELIVERY_TGT_DT AS CUST_DELIVERY_TGT_DT                                       --PARKSIDE: FACT_ICOL!!!
    ,FACT_SPS.CUST_DELIVERY_TGT_HAULER_TMSP AS CUST_DELIVERY_TGT_HAULER_TMSP
    ,FACT_SPS.FIRST_ATTEMPT_DELIVERY_TMSP AS FIRST_ATTEMPT_DELIVERY_TMSP
    ,FACT_SPS.CUST_DELIVERY_ACTUAL_TMSP AS CUST_DELIVERY_ACTUAL_TMSP
    ,COALESCE(FACT_SPS.WH_SID, FACT_COL.WH_SID,FACT_ICOL.WH_SID) AS WH_SID                                                                --PARKSIDE: FACT_ICOL!!!
    ,FACT_SPS.WH_LEAVE_TGT_TMSP AS WH_LEAVE_TGT_TMSP
    ,FACT_SPS.WH_LEAVE_ACTUAL_TMSP AS WH_LEAVE_ACTUAL_TMSP
    --,IFNULL(FACT_CPS.FIRST_HUB_CD, '-1') AS FIRST_HUB_CD
    ,FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP AS FIRST_HUB_SCAN_ACTUAL_TMSP
    ,FACT_SPS.FIRST_HUB_SCAN_TGT_TMSP AS FIRST_HUB_SCAN_TGT_TMSP
    --,CONVERT_TIMEZONE('Europe/Berlin', FACT_CPS.GATE_DEPART_TMSP)::TIMESTAMP_NTZ AS GATE_DEPART_TMSP
    --,CONVERT_TIMEZONE('Europe/Berlin', FACT_CPS.GATE_ARRIVAL_TMSP)::TIMESTAMP_NTZ AS GATE_ARRIVAL_TMSP
    --,IFNULL(FACT_CPS.LAST_HUB_CD, '-1') AS LAST_HUB_CD
    --,FACT_CPS.IS_REPLACEMENT_DELIVERY_FG AS IS_REPLACEMENT_DELIVERY_FG
    ,FACT_SPS.IS_DAMAGED_FG AS IS_DAMAGED_FG
    ,IFNULL(FACT_SPS.PACK_SIZE_TYPE_CD, '-1') AS PACK_SIZE_TYPE_CD
    --,IFNULL(FACT_CPS.HAULER_PAYM_CLASS_CD, '-1') AS HAULER_PAYM_CLASS_CD
    ,IFNULL(FACT_SPS.DELIVERY_TYPE_CD, '-1') AS DELIVERY_TYPE_CD
    --,FACT_CPS.IS_PRODUCTSIZE_USED_FG AS IS_PRODUCTSIZE_USED_FG
    ,COALESCE(FACT_SPS.DELIVERY_ADDR_SID, FACT_COL.DELIVERY_ADDR_SID, FACT_ICOL.DELIVERY_ADDR_SID) AS DELIVERY_ADDR_SID                    --PARKSIDE: FACT_ICOL!!!
    ,IFNULL(FACT_SPS.DELIVERY_ZIP_SHORT_CD, '-1') AS DELIVERY_ZIP_SHORT_CD
    ,IFNULL(FACT_SPS.HAULER_SID, '-1') AS HAULER_SID
    ,FACT_SPS.PACK_HEIGHT_MEAS AS PACK_HEIGHT_MEAS
    --,IFNULL(FACT_CPS.PACK_HEIGHT_UOM_SID, '-1') AS PACK_HEIGHT_UOM_SID
    ,FACT_SPS.PACK_HEIGHT_STR AS PACK_HEIGHT_STR
    --,FACT_CPS.PACK_HEIGHT_MEAS_STANDARD AS PACK_HEIGHT_MEAS_STANDARD
    ,IFNULL(FACT_SPS.PACK_HEIGHT_MEAS_STANDARD_UOM_CD, '-1') AS PACK_HEIGHT_MEAS_STANDARD_UOM_CD
    ,FACT_SPS.PACK_WIDTH_MEAS AS PACK_WIDTH_MEAS
    --,IFNULL(FACT_CPS.PACK_WIDTH_UOM_SID, '-1') AS PACK_WIDTH_UOM_SID
    ,FACT_SPS.PACK_WIDTH_STR AS PACK_WIDTH_STR
    --,FACT_CPS.PACK_WIDTH_MEAS_STANDARD AS PACK_WIDTH_MEAS_STANDARD
    ,IFNULL(FACT_SPS.PACK_WIDTH_MEAS_STANDARD_UOM_CD, '-1') AS PACK_WIDTH_MEAS_STANDARD_UOM_CD
    ,FACT_SPS.PACK_LENGTH_MEAS AS PACK_LENGTH_MEAS
    --,FACT_CPS.PACK_MEAN_LENGTH_MEAS AS PACK_MEAN_LENGTH_MEAS
    --,FACT_CPS.PACK_SHORTEST_LENGTH_MEAS AS PACK_SHORTEST_LENGTH_MEAS
    ,FACT_SPS.PACK_LONGEST_LENGTH_MEAS AS PACK_LONGEST_LENGTH_MEAS
    --,IFNULL(FACT_CPS.PACK_LENGTH_UOM_SID, '-1') AS PACK_LENGTH_UOM_SID
    ,FACT_SPS.PACK_LENGTH_STR AS PACK_LENGTH_STR
    --,FACT_CPS.PACK_LENGTH_MEAS_STANDARD AS PACK_LENGTH_MEAS_STANDARD
    --,FACT_CPS.PACK_MEAN_LENGTH_STR AS PACK_MEAN_LENGTH_STR
    --,FACT_CPS.PACK_MEAN_LENGTH_MEAS_STANDARD AS PACK_MEAN_LENGTH_MEAS_STANDARD
    --,FACT_CPS.PACK_SHORTEST_LENGTH_STR AS PACK_SHORTEST_LENGTH_STR
    --,FACT_CPS.PACK_SHORTEST_LENGTH_MEAS_STANDARD AS PACK_SHORTEST_LENGTH_MEAS_STANDARD
    ,FACT_SPS.PACK_LONGEST_LENGTH_STR AS PACK_LONGEST_LENGTH_STR
    --,FACT_CPS.PACK_LONGEST_LENGTH_MEAS_STANDARD AS PACK_LONGEST_LENGTH_MEAS_STANDARD
    ,IFNULL(FACT_SPS.PACK_LENGTH_MEAS_STANDARD_UOM_CD, '-1') AS PACK_LENGTH_MEAS_STANDARD_UOM_CD
    ,FACT_SPS.PACK_GIRTH_WEST_MEAS AS PACK_GIRTH_WEST_MEAS
    ,FACT_SPS.PACK_GIRTH_EAST_MEAS AS PACK_GIRTH_EAST_MEAS
    --,IFNULL(FACT_CPS.PACK_GIRTH_UOM_SID, '-1') AS PACK_GIRTH_UOM_SID
    ,FACT_SPS.PACK_GIRTH_WEST_STR AS PACK_GIRTH_WEST_STR
    --,FACT_CPS.PACK_GIRTH_WEST_MEAS_STANDARD AS PACK_GIRTH_WEST_MEAS_STANDARD
    ,FACT_SPS.PACK_GIRTH_EAST_STR AS PACK_GIRTH_EAST_STR
    --,FACT_CPS.PACK_GIRTH_EAST_MEAS_STANDARD AS PACK_GIRTH_EAST_MEAS_STANDARD
    --,IFNULL(FACT_CPS.PACK_GIRTH_MEAS_STANDARD_UOM_CD, '-1') AS PACK_GIRTH_MEAS_STANDARD_UOM_CD
    ,FACT_SPS.PACK_WEIGHT_MEAS AS PACK_WEIGHT_MEAS
    --,IFNULL(FACT_CPS.PACK_WEIGHT_UOM_SID, '-1') AS PACK_WEIGHT_UOM_SID
    ,FACT_SPS.PACK_WEIGHT_STR AS PACK_WEIGHT_STR
    --,FACT_CPS.PACK_WEIGHT_MEAS_STANDARD AS PACK_WEIGHT_MEAS_STANDARD
    ,IFNULL(FACT_SPS.PACK_WEIGHT_MEAS_STANDARD_UOM_CD, '-1') AS PACK_WEIGHT_MEAS_STANDARD_UOM_CD
    ,IFF(DIM_HAU.HAULER_NAME = 'PL_DPD', (FACT_SPS.PACK_LENGTH_MEAS * FACT_SPS.PACK_WIDTH_MEAS * FACT_SPS.PACK_HEIGHT_MEAS)/0.006, NULL) AS PACK_VOLUMETRIC_WEIGHT_GROSS
    ,FACT_SPS.PACK_VOLUME_MEAS AS PACK_VOLUME_MEAS
    --,IFNULL(FACT_CPS.PACK_VOLUME_UOM_SID, '-1') AS PACK_VOLUME_UOM_SID
    ,FACT_SPS.PACK_VOLUME_STR AS PACK_VOLUME_STR
    --,FACT_CPS.PACK_VOLUME_MEAS_STANDARD AS PACK_VOLUME_MEAS_STANDARD
    ,IFNULL(FACT_SPS.PACK_VOLUME_MEAS_STANDARD_UOM_CD, '-1') AS PACK_VOLUME_MEAS_STANDARD_UOM_CD
    ,IFNULL(FACT_SPS.WEIGHT_CLASS_CD, '-1') AS WEIGHT_CLASS_CD
    ,IFNULL(FACT_SPS.VOLUME_CLASS_CD, '-1') AS VOLUME_CLASS_CD
    ,IFNULL(FACT_SPS.PACK_MATERIAL_NR, '-1') AS PACK_MATERIAL_NR
    ,FACT_SPS.WAREHOUSE_PUNCTUALITY AS WAREHOUSE_PUNCTUALITY
    ,FACT_SPS.SERVICE_PROVIDER_PUNCTUALITY AS SERVICE_PROVIDER_PUNCTUALITY
    ,FACT_SPS.SERVICE_PROVIDER_PUNCTUALITY_LEGACY_DE AS SERVICE_PROVIDER_PUNCTUALITY_LEGACY_DE
    ,FACT_SPS.CUSTOMER_PUNCTUALITY_SHIPMENT_LEVEL AS CUSTOMER_PUNCTUALITY_SHIPMENT_LEVEL
    ,FACT_SPS.EWM_ORDER_PUNCTUALITY AS EWM_ORDER_PUNCTUALITY
    ,FACT_SPS.EWM_SYSTEM_PUNCTUALITY AS EWM_SYSTEM_PUNCTUALITY
    ,FACT_SPS.WH_LEAVE_TGT_DATE AS WH_LEAVE_TGT_DATE
    ,FACT_SPS.WH_LEAVE_ACTUAL_DATE AS WH_LEAVE_ACTUAL_DATE
    ,FACT_SPS.CUST_DELIVERY_TGT_HAULER_DATE AS CUST_DELIVERY_TGT_HAULER_DATE
    ,FACT_SPS.FIRST_ATTEMPT_DELIVERY_DATE AS FIRST_ATTEMPT_DELIVERY_DATE
    ,FACT_SPS.CUST_DELIVERY_ACTUAL_DATE AS CUST_DELIVERY_ACTUAL_DATE
    ,FACT_SPS.WAREHOUSE_DELAY_IN_HOURS AS WAREHOUSE_DELAY_IN_HOURS
    ,FACT_SPS.WAREHOUSE_DELAY_IN_DAYS AS WAREHOUSE_DELAY_IN_DAYS
    ,FACT_SPS.SERVICE_PROVIDER_DELAY_IN_HOURS AS SERVICE_PROVIDER_DELAY_IN_HOURS
    ,FACT_SPS.SERVICE_PROVIDER_DELAY_IN_DAYS AS SERVICE_PROVIDER_DELAY_IN_DAYS
    ,FACT_SPS.CUSTOMER_SHIPMENT_LEVEL_DELAY_IN_DAYS AS CUSTOMER_SHIPMENT_LEVEL_DELAY_IN_DAYS
    ,FACT_SPS.EWM_ORDER_DELAY_IN_HOURS AS EWM_ORDER_DELAY_IN_HOURS
    ,FACT_SPS.EWM_ORDER_DELAY_IN_DAYS AS EWM_ORDER_DELAY_IN_DAYS
    ,FACT_SPS.EWM_SYSTEM_DELAY_IN_HOURS AS EWM_SYSTEM_DELAY_IN_HOURS
    ,FACT_SPS.EWM_SYSTEM_DELAY_IN_DAYS AS EWM_SYSTEM_DELAY_IN_DAYS
    ,FACT_COL.CUST_ORDER_CREATE_TMSP AS CUST_ORDER_CREATE_TMSP
    ,FACT_COL.CUST_ORDER_DT AS CUST_ORDER_DT                                                                                                          --PARKSIDE: FACT_ICOL!!!
    --,FACT_COL.CUST_ORDER_TM AS CUST_ORDER_TM                                                                                                          --PARKSIDE: FACT_ICOL!!!
    --,FACT_COL.CUST_ORDER_CREATE_TIME AS CUST_ORDER_CREATE_TIME                                                                                        --PARKSIDE: FACT_ICOL!!!
    --,FACT_COL.CUST_ORDER_CREATE_DATE AS CUST_ORDER_CREATE_DATE                                                                                        --PARKSIDE: FACT_ICOL!!!
    --,COALESCE(FACT_COL.PROD_SID,FACT_ICOL.PROD_SID,'-1') AS PROD_SID                                                                                  --PARKSIDE: FACT_ICOL!!!
    --,FACT_COL.ARTICLE_SET AS ARTICLE_SET                                                                                                              --PARKSIDE: base columns dont seem to exist in FACT_ICOL!!!
    ,COALESCE(FACT_COL.CUST_ORDER_NR,'-1') AS CUST_ORDER_NR
    --,COALESCE(FACT_COL.PROD_QTY,FACT_ICOL.PROD_QTY) AS PROD_QTY                                                                                       --PARKSIDE: FACT_ICOL!!!
    --,FACT_COL.IS_BUNDLE_HEADER_FG AS IS_BUNDLE_HEADER_FG                                                                                              --PARKSIDE: base columns dont seem to exist in FACT_ICOL!!!
    --,FACT_COL.BUNDLE_HEADER_POS_NR AS BUNDLE_HEADER_POS_NR                                                                                            --PARKSIDE: base columns dont seem to exist in FACT_ICOL!!!
    ,FACT_ICOL.IC_ORDER_CREATE_TMSP AS IC_ORDER_CREATE_TMSP                                                         --PARKSIDE
    ,FACT_ICOL.IC_ORDER_DT AS IC_ORDER_DT                                                                                                             --PARKSIDE
    --,FACT_ICOL.IC_ORDER_TM AS IC_ORDER_TM                                                                                                             --PARKSIDE
    --,FACT_ICOL.IC_ORDER_CREATE_TIME AS IC_ORDER_CREATE_TIME                                                                                           --PARKSIDE
    --,FACT_ICOL.IC_ORDER_CREATE_DATE AS IC_ORDER_CREATE_DATE                                                                                           --PARKSIDE
    ,FACT_ICOL.IC_ORDER_NR AS IC_ORDER_NR                                                                                                             --PARKSIDE                                                                         --PARKSIDE: FACT_ICOL!!!
    --,FACT_COL.DELIVERY_CUST_SID AS DELIVERY_CUST_SID                                                                                                  --PARKSIDE: column not in base table FACT_ICOL!!!
    --,FACT_COL.IS_BLOCKED_DELIVERY_FG AS IS_BLOCKED_DELIVERY_FG                                                                                        --PARKSIDE: column not in base table FACT_ICOL!!!
    --,COALESCE(FACT_COL.DELIVERY_BLOCKED_REASON_CD, '-1') AS DELIVERY_BLOCKED_REASON_CD                                                                --PARKSIDE: column not in base table FACT_ICOL!!!
    --,COALESCE(FACT_COL.IS_ORDER_CANCEL_FG,FACT_ICOL.IS_ORDER_CANCEL_FG) AS IS_ORDER_CANCEL_FG                                                         --PARKSIDE: FACT_ICOL!!!
    ,COALESCE(FACT_COL.CUST_PAYM_METHOD_CD,'-1') AS CUST_PAYM_METHOD_CD                                                                               --PARKSIDE: column not in base table FACT_ICOL!!!
    --,COALESCE(FACT_COL.SALES_CHANNEL_TYPE_CD,'-1') AS SALES_CHANNEL_TYPE_CD                                                                           --PARKSIDE: column not in base table FACT_ICOL!!!
    --,COALESCE(FACT_COL.ORDER_CANCEL_REASON_CD,'-1') AS ORDER_CANCEL_REASON_CD                                                                         --PARKSIDE: FACT_ICOL!!!
    ,COALESCE(FACT_COL.CUST_ORDER_TYPE_CD, FACT_ICOL.CUST_ORDER_TYPE_CD, '-1') AS CUST_ORDER_TYPE_CD                                                                                --PARKSIDE: column not in base table FACT_ICOL!!!
    --,COALESCE(FACT_COL.CUST_ORDER_PERFORM_DT,FACT_ICOL.CUST_ORDER_PERFORM_DT) AS CUST_ORDER_PERFORM_DT                                                 --PARKSIDE: FACT_ICOL!!!
    --,FACT_COL.CUST_DELIVERY_TGT_DT AS CUST_DELIVERY_TGT_DT_2                                                 
    ,COALESCE(FACT_COL.WH_CD, FACT_ICOL.WH_CD, '-1') AS WH_CD                                                                                         --PARKSIDE: FACT_ICOL!!!
    --,IFF(DIM_PV.EINLAGER_KZ = 'Wein', DIM_PV.EINLAGER_KZ , DIM_WH.WH_STORAGE_TYPE_CD) AS WH_STORAGE_TYPE_DESC_ALT
    --,COALESCE(FACT_COL.PRODUCT_ASSORTIMENT_TYPE_CD,'-1') AS PRODUCT_ASSORTIMENT_TYPE_CD                                                               --PARKSIDE: column not in base table FACT_ICOL!!!
    --,FACT_COL.DROPSHIPMENT_ORDER_FG AS DROPSHIPMENT_ORDER_FG                                                                                           --PARKSIDE: column not in base table FACT_ICOL!!!
    --,FACT_COL.IS_PART_OF_BUNDLE_HEADER_CNT_FG AS IS_PART_OF_BUNDLE_HEADER_CNT_FG                                                                      --PARKSIDE: column not in base table FACT_ICOL!!!
    --,FACT_COL.IS_PART_OF_BUNDLE_POS_CNT_FG AS IS_PART_OF_BUNDLE_POS_CNT_FG                                                                            --PARKSIDE: column not in base table FACT_ICOL!!!
    --,'GC' GC_LC_CD -- NBI-5325, NBI-5077

    ,FACT_GM.STOCK_PLACEMENT_CD AS STOCK_PLACEMENT_CD
    ,FACT_GM.STOCK_REMOVAL_CD AS STOCK_REMOVAL_CD
    --,TO_DATE(GATE_DEPART_TMSP) AS GATE_DEPART_DATE
    --,TO_DATE(GATE_ARRIVAL_TMSP) AS GATE_ARRIVAL_DATE
    ,TO_DATE(FACT_SPS.FIRST_HUB_SCAN_ACTUAL_TMSP) AS FIRST_HUB_SCAN_ACTUAL_DATE
    ,FACT_SPS.VEHICLE_INTERNAL_NR AS VEHICLE_INTERNAL_NR
	,FACT_SPS.VEHICLE_LICENSE_PLATE_NR AS VEHICLE_LICENSE_PLATE_NR
    ,FACT_SPS.VEHICLE_DEPARTURE_TMSP AS VEHICLE_DEPARTURE_TMSP
    --,TO_TIME(CONVERT_TIMEZONE('Europe/Berlin', FACT_CPS.VEHICLE_DEPARTURE_TMSP)::TIMESTAMP_NTZ) AS VEHICLE_DEPARTURE_TM
    ,FACT_SPS.VEHICLE_DEPARTURE_DT AS VEHICLE_DEPARTURE_DT
    ,FACT_SPS.VEHICLE_LOADING_START_TMSP AS VEHICLE_LOADING_START_TMSP
    --,TO_TIME(CONVERT_TIMEZONE('Europe/Berlin', FACT_CPS.VEHICLE_LOADING_START_TMSP)::TIMESTAMP_NTZ) AS VEHICLE_LOADING_START_TM
    --,TO_DATE(CONVERT_TIMEZONE('Europe/Berlin', FACT_CPS.VEHICLE_LOADING_START_TMSP)::TIMESTAMP_NTZ) AS VEHICLE_LOADING_START_DT
    ,FACT_SPS.VEHICLE_LOADING_END_TMSP AS VEHICLE_LOADING_END_TMSP
    --,TO_TIME(CONVERT_TIMEZONE('Europe/Berlin', FACT_CPS.VEHICLE_LOADING_END_TMSP)::TIMESTAMP_NTZ) AS VEHICLE_LOADING_END_TM
    --,TO_DATE(CONVERT_TIMEZONE('Europe/Berlin', FACT_CPS.VEHICLE_LOADING_END_TMSP)::TIMESTAMP_NTZ) AS VEHICLE_LOADING_END_DT
	,FACT_SPS.TRUCK_UNLOADING_START_AT_HUB_TMSP AS TRUCK_UNLOADING_START_AT_HUB_TMSP
	,FACT_SPS.TRUCK_UNLOADING_STOP_AT_HUB_TMSP AS TRUCK_UNLOADING_STOP_AT_HUB_TMSP
    ,FACT_SPS.DURATION_OF_UNLOADING_AT_HUB_IN_H AS DURATION_OF_UNLOADING_AT_HUB_IN_H
    --,FACT_CPS.TRUCK_UNLOADING_STOP_AT_HUB_TMSP_PERCENTRANK_GROUP AS TRUCK_UNLOADING_STOP_AT_HUB_TMSP_PERCENTRANK_GROUP
    --,FACT_CPS.TRUCK_UNLOADING_STOP_AT_HUB_TMSP_PERCENTRANK AS TRUCK_UNLOADING_STOP_AT_HUB_TMSP_PERCENTRANK
    ,FACT_SPS.TRUCK_UNLOADING_STOP_AT_HUB_TMSP_PERCENTRANK_SELECTED_GROUP AS TRUCK_UNLOADING_STOP_AT_HUB_TMSP_PERCENTRANK_SELECTED_GROUP
    ,FACT_SPS.IS_GHOST_PACK_FG AS IS_GHOST_PACK_FG
    ,FACT_SPS.IS_GHOST_PACK_RETURN_FG AS IS_GHOST_PACK_RETURN_FG
    ,FACT_SPS.PACK_RETURN_TMSP AS PACK_RETURN_TMSP
    ,FACT_SPS.GHOST_PACK_RETURN_DURATION_DAYS_CNT AS GHOST_PACK_RETURN_DURATION_DAYS_CNT
    ,FACT_SPS.FIRST_HUB_LOC_DESCR AS FIRST_HUB_LOC_DESCR
    ,FACT_SPS.SECOND_HUB_LOC_DESCR AS SECOND_HUB_LOC_DESCR
FROM
    FE_MSTR_LIDLDIGITAL.V_REL_ORDER_PACKAGING AS REL_OP
LEFT OUTER JOIN
    (
    SELECT
         FACT_SPS_CTE.*          
        ,MIN(FIRST_HUB_SCAN_ACTUAL_TMSP) OVER (PARTITION BY VEHICLE_LICENSE_PLATE_NR,VEHICLE_DEPARTURE_TMSP,TRUCK_UNLOADING_STOP_AT_HUB_TMSP_PERCENTRANK_SELECTED_GROUP)  AS TRUCK_UNLOADING_STOP_AT_HUB_TMSP
        ,(DATEDIFF(SECOND,TRUCK_UNLOADING_START_AT_HUB_TMSP,TRUCK_UNLOADING_STOP_AT_HUB_TMSP)/ 3600)                                                                    AS DURATION_OF_UNLOADING_AT_HUB_IN_H
    FROM 
        FACT_SPS_CTE
    
    ) AS FACT_SPS
    ON
        FACT_SPS.PACK_SID = REL_OP.PACK_SID
LEFT OUTER JOIN
       FACT_COL
            ON FACT_COL.CUST_ORDER_SID = REL_OP.CUST_ORDER_SID
               AND FACT_COL.CUST_ORDER_POS_NR = REL_OP.CUST_ORDER_POS_NR
LEFT OUTER JOIN                                                                            -- PARKSIDE
      FACT_ICOL
            ON FACT_ICOL.IC_ORDER_SID = REL_OP.IC_ORDER_SID
               AND FACT_ICOL.IC_ORDER_POS_NR = REL_OP.IC_ORDER_POS_NR
LEFT OUTER JOIN
    FE_MSTR_LIDLDIGITAL.V_FACT_GOODS_MOVEMENT FACT_GM
            ON FACT_GM.DELIVERY_ORDER_SID = REL_OP.DELIVERY_ORDER_SID
               AND FACT_GM.DELIVERY_ORDER_POS_NR = REL_OP.DELIVERY_ORDER_POS_NR
LEFT OUTER JOIN 
    FE_MSTR_LIDLDIGITAL.V_DIM_HAULER AS DIM_HAU
            ON FACT_SPS.HAULER_SID = DIM_HAU.HAULER_SID

;