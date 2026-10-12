/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_nf_add_1
Description		|	SAP EWM NF - add view with calculations for kpi view 
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_nf_add_1(
	SCAN_GUID COMMENT 'Unofficial PK',
	CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code',
	WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number',
	RETURN_NUM COMMENT 'Return number',
	PRODUCT_NUM COMMENT 'Product Number',
	DEFECT_FLAG COMMENT 'Flag: Is defect',
	ART_UNKN_FLAG COMMENT 'Flag: Is article unknown',
	IS_IN_RET_FLAG COMMENT 'Flag: Is in return',
	SALE_FLAG COMMENT 'Flag: Is Special Sales_1',
	IS_UNP_FLAG COMMENT 'Flag: Is Unpacked',
	NON_SORTABLE_FLAG COMMENT 'Flag: non sortable',
	QTY COMMENT 'Quantity per scan - always one',
	UNIT_1 COMMENT 'Unit_1 of Measure',
	STATION_ID COMMENT 'Id of Scan Station in NF counting process',
	CONF_DT COMMENT 'Created On',
	CREATED_TIME COMMENT 'Created At',
	CONF_DT_SHORT COMMENT 'Short time format',
	CREATED_TIME_CONV COMMENT 'Converted created_time for Time Filter',
	CREATED_BY COMMENT 'Created By',
	UNDO_FLAG COMMENT 'Undo flag',
	OFFLINE_FLAG COMMENT 'Offline Sorting',
	SHIFT_FLAG COMMENT 'What shift did scan occured on',
	NON_ADV_DEF_FLAG COMMENT 'Non advised defect scan',
	NR_2 COMMENT 'Flag: 2nd option for scan to be considered as Non Recall',
	NR_2_OK COMMENT 'Flag: Option for DEF',
	NR_3 COMMENT 'Flag: 3rd consideration for NR/DEF',
	NR_4_OK COMMENT 'Flag: 4th consideration for NR/DEF',
	NR_5_OK COMMENT 'Flag: 5th consideration for NR/DEF',
	TIME_SELECTOR COMMENT 'Assort data in hourly buckets',
	TIME_HOUR,
	TIME_DATE,
	TIME_MONTH,
	TIME_YEAR,
	TIME_MINUTE,
	TIME_WEEK,
	MULTI_BASE,
	MULTI_FLAG COMMENT 'Original Case/Multiplicator Quota Flag',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	OP_DT_PREV COMMENT 'Operation date of previous warehouse task',
	OP_TM_PREV COMMENT 'Operation time of previous warehouse task',
	PREV_OP_TM_DIFF_SEC COMMENT 'Time in seconds between last and current operation',
	EMP_WRK_SHIFT_START_FG COMMENT 'Flag for first operation of a working shift of an employee_1',
	WORK_TM_SEC COMMENT 'Recorded working time in seconds',
	WORK_TM_SEC_NET COMMENT 'Net working time in seconds without pauses and with standard time',
	EX_QUAN COMMENT 'Expected quantities from NFLIMOREPORT',
	REPEAT_QTY COMMENT 'Quantity for scans'
) COMMENT='View based on Employee_1 Performance'
 AS 
SELECT
    SCAN_GUID
	,T.CLIENT_ID
    ,T.WH_ID
    ,T.ZZ_REFBS AS RETURN_NUM
    ,T.PRODUCTNO AS PRODUCT_NUM
    ,T.DEFECT AS DEFECT_FLAG
    ,T.ART_UNKNOWN AS ART_UNKN_FLAG
    ,T.IS_IN_RET AS IS_IN_RET_FLAG
    ,T.SPS AS SALE_FLAG
    ,IFF(T.IS_UNPACKED = 'X', 1, 0) AS IS_UNP_FLAG
    ,T.SORT_REQ AS NON_SORTABLE_FLAG
    ,T.REPEAT_QTY AS QTY
    ,T.UOM AS UNIT_1
    ,T.STATION_ID
    ,T.CREATED_DATE AS CONF_DT
    ,T.CREATED_TIME
    ,SUBSTR(T.CREATED_TIME, 0,5) CONF_DT_SHORT
    , CASE 
        WHEN SUBSTRING(T.CREATED_TIME,4,2) BETWEEN '00' AND '14' THEN CONCAT(SUBSTR(T.CREATED_TIME, 1,2),':00')
        WHEN SUBSTRING(T.CREATED_TIME,4,2) BETWEEN '15' AND '44' THEN CONCAT(SUBSTR(T.CREATED_TIME, 1,2),':30')
        WHEN SUBSTRING(T.CREATED_TIME,4,2) BETWEEN '45' AND '59' THEN CONCAT(SUBSTR(DATEADD(HOUR, 1, T.CREATED_TIME),1,2),':00')
    END AS CREATED_TIME_CONV
    ,T.CREUSR AS CREATED_BY
    ,T.UNDO_SET AS UNDO_FLAG
    ,T.OFFLINE_SRT AS OFFLINE_FLAG
    ,CASE 
        WHEN T.CREATED_TIME BETWEEN '06:00:00' AND '14:00:00' THEN 1
        WHEN T.CREATED_TIME BETWEEN '14:00:01' AND '22:00:00' THEN 2
        ELSE 3
    END AS SHIFT_FLAG
    ,IFF(ART_UNKN_FLAG = TRUE AND DEFECT_FLAG = TRUE AND IS_IN_RET_FLAG = TRUE, TRUE, FALSE) AS NON_ADV_DEF_FLAG
    ,IFF(ART_UNKN_FLAG = TRUE AND DEFECT_FLAG = TRUE, TRUE, FALSE) AS NR_2
    ,IFF(DEFECT_FLAG = TRUE AND IS_IN_RET_FLAG = FALSE AND ART_UNKN_FLAG = FALSE,TRUE,FALSE) AS NR_2_OK
    ,IFF(DEFECT_FLAG = TRUE AND IS_IN_RET_FLAG = TRUE, TRUE, FALSE) AS NR_3
    ,IFF(ART_UNKN_FLAG = TRUE AND DEFECT_FLAG = TRUE AND IS_IN_RET_FLAG = FALSE, TRUE, FALSE) AS NR_4_OK
    ,IFF(ART_UNKN_FLAG = TRUE AND DEFECT_FLAG = FALSE AND IS_IN_RET_FLAG = FALSE, TRUE, FALSE) AS NR_5_OK
	,CAST(LEFT(CREATED_TIME,5) AS TIME(0)) AS TIME_SELECTOR
    ,HOUR(CREATED_TIME) AS TIME_HOUR
    ,DAY(CREATED_DATE) AS TIME_DATE
    ,MONTH(CREATED_DATE) AS TIME_MONTH
    ,YEAR(CREATED_DATE) AS TIME_YEAR
    ,MINUTE(CREATED_TIME) AS TIME_MINUTE
    ,T.ZZ_KW AS TIME_WEEK
    ,RANK() OVER(ORDER BY PRODUCT_NUM, STATION_ID, CONF_DT, CREATED_TIME) AS MULTI_BASE
    ,CASE 
        WHEN COUNT(*) OVER(PARTITION BY PRODUCT_NUM, STATION_ID, CONF_DT, CREATED_TIME) > 1 THEN TRUE
        ELSE FALSE
    END AS MULTI_FLAG
    ,T.DWH_CREATED
    ,T.DWH_UPDATED
	,LAG(CREATED_DATE) OVER (PARTITION BY T.CLIENT_ID, T.WH_ID, T.STATION_ID ORDER BY T.CREATED_DATE, T.CREATED_TIME) AS OP_DT_PREV
	,LAG(CREATED_TIME) OVER (PARTITION BY T.CLIENT_ID, T.WH_ID, T.STATION_ID ORDER BY T.CREATED_DATE, T.CREATED_TIME) AS OP_TM_PREV
	,TIMEDIFF(SECOND, OP_DT_PREV, CREATED_DATE) + TIMEDIFF(SECOND, OP_TM_PREV, CREATED_TIME) AS PREV_OP_TM_DIFF_SEC
	,IFF(OP_DT_PREV IS NULL -- When no previous records exist 
			OR PREV_OP_TM_DIFF_SEC > 28800 -- previous operation is at least 8 hours before  
		, 1
		, 0) AS EMP_WRK_SHIFT_START_FG -- To identify first task of a working shift of an employee_1 because he can also work during midnight 
	,IFF(EMP_WRK_SHIFT_START_FG <> 1, PREV_OP_TM_DIFF_SEC, NULL) AS WORK_TM_SEC
	,IFF(EMP_WRK_SHIFT_START_FG = 1 OR WORK_TM_SEC > 900, 0, WORK_TM_SEC) AS WORK_TM_SEC_NET -- Very first task within a working shift and also tasks with an working time of more than 15 mins are calculated with 0 seconds.
	,L.EX_QUAN
    ,T.REPEAT_QTY
FROM "DATA".T_SAPEWM_NFEMPLOYEEPERFORMANCE_1 T
LEFT JOIN "DATA".T_SAPEWM_NFLIMOREPORT_1 L ON T.CLIENT_ID = L.CLIENT_ID AND T.LGNUM = L.LGNUM AND T.ZZ_REFBS = L.ZZ_REFBS AND T.ZZ_KW = L.ZZ_KW AND TIME_YEAR = L.ZZ_YEAR
WHERE UNDO_SET = FALSE
    AND PRODUCT_NUM IS NOT NULL
    AND STATION_ID != 'SE_MAN'
    AND CREATED_DATE >= DATEADD(MONTH, -2, DATE(GETDATE()))
;