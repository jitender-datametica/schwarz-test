/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_mfs_totalperformance_kpi
Description		|	SAP EWM MFS - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_MFS_TOTALPERFORMANCE_KPI(
	CLIENT_ID COMMENT 'Client ID'
	,LIDL_CTRY COMMENT 'Country code'
	,WH_ID COMMENT 'Warehouse ID'
	,WH_TASK_NR COMMENT 'Warehouse Task'
	,WH_TASK_ITEM COMMENT 'Warehouse Task Item'
	,WH_TASK_STAT COMMENT 'Warehouse Task Status'
	,WH_PROC_TYPE COMMENT 'Warehouse Process Type'
	,WH_PROC_CAT COMMENT 'Warehouse Process Category'
	,DOC_NR COMMENT 'Document'
	,DOC_CAT COMMENT 'Document Category for Document-Related Stocks'
	,HU_TASK_TYPE COMMENT 'Handling Unit Type'
	,UNIT_SWITCH COMMENT 'Switches between Pallets and EPA amounts' 
	,CONF_DT COMMENT 'Confirmation date'
	,CONF_TM COMMENT 'Confirmation time'
	,CONF_HR COMMENT 'Confirmation hour'
	,QUEUE COMMENT 'Queue'
	,SRC_STRG_BIN COMMENT 'Source Storage Bin'
	,SRC_HU COMMENT 'Source Handling Unit'
	,SRC_STRG_TYPE COMMENT 'Source Storage Type'
	,SRC_RSRC COMMENT 'Source Resource (Means of Transport or User)'
	,DEST_STRG_BIN COMMENT 'Destination Storage Bin'
	,DEST_HU COMMENT 'Destination Handling Unit'
	,DEST_STRG_TYPE COMMENT 'Destination Storage Type'
	,DEST_RSRC COMMENT 'Destination Resource (Means of Transport or User)'
	,DWH_CREATED COMMENT 'DWH creation timestamp'
	,DWH_UPDATED COMMENT 'DWH update timestamp'
	,BIN_GRP COMMENT 'Storage bin group'
	,WH_TASK_TYPE COMMENT 'Warehouse task type'
	,SRM_TYPE COMMENT 'Type of storage and retrieval machine (SRM / Regalbediengeraet)'
	,MIN_CONF_TM COMMENT 'Earliest confirmation time per hour'
	,MAX_CONF_TM COMMENT 'Latest confirmation time per hour'
	,CNT_TASK_PH COMMENT 'Amount of tasks per hour which is shown once for the first row of the hour'
	,CNT_TASK_PH_PRE COMMENT 'Amount of tasks per hour from the preceding hour group (0 for the first hour per day because there are no previous tasks)'
	,CNT_TASK_PH_SUC COMMENT 'Amount of tasks per hour from the succeding hour group (0 for the last hour per day because there are no following tasks)'
	,PROD_TM_SEC COMMENT 'Productive time in seconds calculated based on number of tasks per hour'
) COMMENT='SAP EWM MFS - view with final KPIs for FE (PK client_id, wh_id, wh_task_nr, wh_task_item)'
 AS
SELECT
	client_id
	,lidl_ctry
	,wh_id
	,wh_task_nr
	,wh_task_item
	,wh_task_stat
	,wh_proc_type
	,wh_proc_cat
	,doc_nr
	,doc_cat
	,hu_task_type
	,unit_switch
	,conf_dt
	,conf_tm
	,conf_hr
	,QUEUE
	,src_strg_bin
	,src_hu
	,src_strg_type
	,src_rsrc
	,dest_strg_bin
	,dest_hu
	,dest_strg_type
	,dest_rsrc
	,dwh_created
	,dwh_updated
	,bin_grp
	,wh_task_type
	,srm_type
	,min_conf_tm
	,max_conf_tm
	,cnt_task_ph
	,cnt_task_ph_pre
	,cnt_task_ph_suc
	,prod_tm_sec
FROM fe_mstr_logop.v_sapewm_mfs_totalperformance_add
;
