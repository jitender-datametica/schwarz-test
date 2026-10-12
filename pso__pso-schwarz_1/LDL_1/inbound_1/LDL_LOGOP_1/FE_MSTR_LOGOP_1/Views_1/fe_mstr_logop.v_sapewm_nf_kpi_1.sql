/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_nf_kpi_1
Description		|	SAP EWM NF - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_nf_kpi_1(
	SCAN_GUID COMMENT 'Unofficial PK',
	CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code',
	WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number',
	RETURN_NUM COMMENT 'Return number',
	PRODUCT_NUM COMMENT 'Product Number',
	DEFECT_FLAG COMMENT 'Flag: Is defect',
	DEFECT_FLAG_TEST COMMENT 'TEST_1',
	ART_UNKN_FLAG COMMENT 'Flag: Is article unknown',
	IS_IN_RET_FLAG COMMENT 'Flag: Is in return',
	SALE_FLAG COMMENT 'Flag: Is Special Sales_1',
	IS_UNP_FLAG COMMENT 'Flag: Is Unpacked',
	NON_SORTABLE_FLAG COMMENT 'Flag: Non sortable',
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
	MULTI_FLAG COMMENT 'Original Case/Multiplicator Quota Flag',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	OP_DT_PREV COMMENT 'Operation date of previous warehouse task',
	OP_TM_PREV COMMENT 'Operation time of previous warehouse task',
	PREV_OP_TM_DIFF_SEC COMMENT 'Time in seconds between last and current operation',
	EMP_WRK_SHIFT_START_FG COMMENT 'Flag for first operation of a working shift of an employee_1',
	WORK_TM_SEC COMMENT 'Recorded working time in seconds',
	WORK_TM_SEC_NET COMMENT 'Net working time in seconds without pauses and with standard time',
	EX_QUAN COMMENT 'Expected Quantities from NFLIMOREPORT',
	REPEAT_QTY COMMENT 'Quantity for scans'
) COMMENT='NF KPI View based on NF ADD View'
 AS 
SELECT
	SCAN_GUID
    ,CLIENT_ID
    ,WH_ID
    ,RETURN_NUM
    ,PRODUCT_NUM
    ,DEFECT_FLAG
    ,CASE WHEN DEFECT_FLAG = TRUE THEN 'X' ELSE 'N' END AS DEFECT_FLAG_TEST
    ,ART_UNKN_FLAG
    ,IS_IN_RET_FLAG
    ,SALE_FLAG
	,IS_UNP_FLAG
	,NON_SORTABLE_FLAG
    ,QTY
    ,UNIT_1
    ,STATION_ID
    ,CONF_DT
    ,CREATED_TIME
	,CONF_DT_SHORT
    ,CREATED_TIME_CONV
    ,CREATED_BY
    ,UNDO_FLAG
	,OFFLINE_FLAG
    ,SHIFT_FLAG
	,NON_ADV_DEF_FLAG
    ,NR_2
	,NR_2_OK
    ,NR_3
    ,NR_4_OK
	,NR_5_OK
    ,TIME_SELECTOR
    ,TIME_HOUR
    ,TIME_DATE
    ,TIME_MONTH
    ,TIME_YEAR
    ,TIME_MINUTE
    ,TIME_WEEK
    ,MULTI_FLAG
    ,DWH_CREATED
    ,DWH_UPDATED
	,OP_DT_PREV
	,OP_TM_PREV
	,PREV_OP_TM_DIFF_SEC
	,EMP_WRK_SHIFT_START_FG
	,WORK_TM_SEC
	,WORK_TM_SEC_NET
	,EX_QUAN
    ,REPEAT_QTY
FROM fe_mstr_logop.v_sapewm_nf_add_1
;