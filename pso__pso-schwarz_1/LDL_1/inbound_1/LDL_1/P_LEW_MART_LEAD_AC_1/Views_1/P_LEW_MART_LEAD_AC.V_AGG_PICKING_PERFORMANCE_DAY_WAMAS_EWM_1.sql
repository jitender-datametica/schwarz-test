create or replace view LDL_PRODUCTION.P_LEW_MART_LEAD_AC.V_AGG_PICKING_PERFORMANCE_DAY_WAMAS_EWM_1(
	CLIENT_ID,
	WH_ID,
	WH_LOC_SID,
	DAT_CALENDAR,
	CY_WEEK,
	CY_MONTH,
	PICKING_MAIN_AREA_NR_PP,
	PICKING_MAIN_AREA_DESC_PP,
	PICKING_AREA_NR_PP,
	PICKING_AREA_DESC_PP,
	PICKING_RECEIPT_NR,
	ORDER_NR,
	QTY_SUM_WORKING_TIME_SEC,
	MEANS_OF_TRANSPORT_ID,
	PICKED_CASES,
	PICKED_CASES_BY_PBV,
	PICKED_CASES_NOT_BY_PBV,
	PICKED_EP_PLACES,
	THM_1,
	THM_2,
	THM_3,
	THM_4,
	THM_5,
	THM_ELSE,
	THM_BB,
	THM_BD,
	THM_COHU,
	THM_DTOT,
	THM_EPOS,
	THM_ES,
	THM_GMA,
	THM_HG,
	THM_HS,
	THM_IP,
	THM_QG,
	THM_QP,
	THM_SG,
	THM_SP,
	THM_TB,
	THM_TOTE,
	FIRST_ENTRY_FG,
	WORK_PACKAGE_GRP_NR,
	WH_TASK_GRP_NR COMMENT 'Queue',
	DATENQUELLE
) as
SELECT
   client_id                 AS client_id
   ,wh_id                    AS wh_id
   ,wh_loc_sid                AS wh_loc_sid
   ,dwh_cal_dt                AS dat_calendar
   ,cy_week                   AS cy_week
   ,cy_month                  AS cy_month
   ,picking_main_area_nr_pp   AS picking_main_area_nr_pp
   ,picking_main_area_desc_pp AS picking_main_area_desc_pp
   ,picking_area_nr_pp        AS picking_area_nr_pp
   ,picking_area_desc_pp      AS picking_area_desc_pp
   ,picking_receipt_nr        AS picking_receipt_nr
   ,order_nr                  AS order_nr
   ,qty_sum_working_time_sec  AS qty_sum_working_time_sec
   ,means_of_transport_id     AS means_of_transport_id
   ,picked_cases              AS picked_cases
   ,picked_cases_by_pbv       AS picked_cases_by_pbv
   ,picked_cases_not_by_pbv   AS picked_cases_not_by_pbv
   ,picked_ep_places          AS picked_ep_places
   ,thm_1                     AS thm_1
   ,thm_2                     AS thm_2
   ,thm_3                     AS thm_3
   ,thm_4                     AS thm_4
   ,thm_5                     AS thm_5
   ,thm_else                  AS thm_else
   ,0                         AS THM_BB
   ,0                         AS THM_BD
   ,0                         AS THM_COHU
   ,0                         AS THM_DTOT
   ,0                         AS THM_EPOS
   ,0                         AS THM_ES
   ,0                         AS THM_GMA
   ,0                         AS THM_HG
   ,0                         AS THM_HS
   ,0                         AS THM_IP
   ,0                         AS THM_QG
   ,0                         AS THM_QP
   ,0                         AS THM_SG
   ,0                         AS THM_SP
   ,0                         AS THM_TB
   ,0                         AS THM_TOTE
   ,first_entry_fg            AS first_entry_fg
   ,'N/A'                     AS work_package_grp_nr
   ,'N/A'                     AS wh_task_grp_nr
   ,'WAMAS'					          AS Datenquelle
  FROM p_lew_mart_lead.T_AGG_PICKING_PERFORMANCE_DAY_1 
  UNION ALL  
  SELECT 
  	 client_id   
  	,wh_id
  	,wh_loc_sid
  	,wh_task_confirm_dt AS dat_calendar
  	,cy_week      
  	,cy_month        
  	,pick_main_area_nr AS picking_main_area_nr_pp
    ,pick_main_area_descr AS picking_main_area_desc_pp
    ,pick_area_nr AS picking_area_nr_pp
    ,pick_area_descr AS picking_area_desc_pp
    ,NULL       AS picking_receipt_nr
    ,NULL AS order_nr
    ,ZEROIFNULL(work_time_sec) - ZEROIFNULL(sum_break_sec)  AS qty_sum_working_time_sec
    ,NULL    AS means_of_transport_id
    , picked_case_qty             AS picked_cases
    ,0       AS picked_cases_by_pbv
    ,0   AS picked_cases_not_by_pbv
    ,pick_pallet_qty            AS picked_ep_places
    ,THM_1                      AS thm_1
    ,THM_2                      AS thm_2                   
    ,THM_3                      AS thm_3
    ,THM_4                      AS thm_4
    ,THM_5                      AS thm_5
    ,THM_ELSE                   AS thm_else
    ,THM_BB                     AS THM_BB
    ,THM_BD                     AS THM_BD
    ,THM_COHU                   AS THM_COHU
    ,THM_DTOT                   AS THM_DTOT
    ,THM_EPOS                   AS THM_EPOS
    ,THM_ES                     AS THM_ES
    ,THM_GMA                    AS THM_GMA
    ,THM_HG                     AS THM_HG
    ,THM_HS                     AS THM_HS
    ,THM_IP                     AS THM_IP
    ,THM_QG                     AS THM_QG
    ,THM_QP                     AS THM_QP
    ,THM_SG                     AS THM_SG
    ,THM_SP                     AS THM_SP
    ,THM_TB                     AS THM_TB
    ,THM_TOTE                   AS THM_TOTE
    ,CASE 
      WHEN ROW_NUMBER() OVER (PARTITION BY client_id, wh_id, pick_main_area_nr,pick_area_nr,work_package_nr ORDER BY pick_main_area_nr, pick_area_nr, work_package_nr) = 1
    	THEN 1
    	ELSE 0
    END
    AS first_entry_fg
    ,work_package_grp_nr
    ,wh_task_grp_nr
    ,'EWM'					 AS Datenquelle
  FROM P_LEW_MART_LEAD.V_EWM_PICKING_RATE_1;
