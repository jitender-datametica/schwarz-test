/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_mfs_nio_kpi_2
Description		|	SAP EWM MFS - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_MFS_NIO_KPI_2(
	CLIENT_ID COMMENT 'Client ID',
	LIDL_CTRY COMMENT 'Country_2 code',
	WH_ID COMMENT 'Warehouse ID',
	WH_TASK_NR COMMENT 'Warehouse Task',
	WH_TASK_ITEM COMMENT 'Warehouse Task Item_2',
	WH_TASK_STAT COMMENT 'Warehouse Task Status_2',
	WH_PROC_TYPE COMMENT 'Warehouse Process Type',
	WH_PROC_CAT COMMENT 'Warehouse Process Category',
	DOC_NR COMMENT 'Document',
	DOC_CAT COMMENT 'Document Category for Document-Related Stocks',
	CONF_DT COMMENT 'Confirmation date',
	CONF_TM COMMENT 'Confirmation time',
	QUEUE COMMENT 'Queue',
	EXC_CD COMMENT 'Exception Code',
	SRC_STRG_BIN COMMENT 'Source Storage Bin',
	SRC_HU COMMENT 'Source Handling Unit_2',
	SRC_STRG_TYPE COMMENT 'Source Storage Type',
	SRC_RSRC COMMENT 'Source Resource (Means of Transport or User)',
	DEST_STRG_BIN COMMENT 'Destination Storage Bin',
	DEST_HU COMMENT 'Destination Handling Unit_2',
	DEST_STRG_TYPE COMMENT 'Destination Storage Type',
	DEST_RSRC COMMENT 'Destination Resource (Means of Transport or User)',
	DWH_CREATED COMMENT 'DWH creation timestamp',
	DWH_UPDATED COMMENT 'DWH update timestamp',
	HU_IDENT COMMENT 'NIO History Handling Unit_2 Identification',
	LOG_SEQ COMMENT 'NIO History Log Sequence',
	CRTD_ON_DT COMMENT 'NIO History Created on',
	COM_POINT COMMENT 'NIO History Communication_2 Point for Conveyor Technique',
	HU_STAT_SHORT COMMENT 'NIO History Individual status_2 of an object in short form',
	ERR_CD COMMENT 'NIO History error code used to identify pallets with relevant errors',
	FIRST_LOG_SEQ COMMENT 'Indicator to identify the first record of Nio History per task group',
	HU_CHECKED COMMENT 'Pallet provided to conveyor',
	HU_PASSED COMMENT 'Pallet successfully checked',
	NIO_COUNT COMMENT 'Pallet with encountered error',
	NIO_SONSTIGE COMMENT 'Pallet manually moved to NIO Station',
	SEND_OUT COMMENT 'Pallet moved to clearing station',
	NIO_SEND_OUT COMMENT 'TAB Only: Pallet moved to clearing station',
	CONVEYOR_ID COMMENT 'ID for the FE lookup of conveyor and area (LU view v_lu_mfs_conveyor_2)'
) COMMENT='SAP EWM MFS - view with final KPIs for FE (PK client_id, wh_id, wh_task_nr, wh_task_item, hu_ident, log_seq)'
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
	,conf_dt
	,conf_tm
	,QUEUE
	,exc_cd
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
	,hu_ident
	,log_seq
	,crtd_on_dt
	,com_point
	,hu_stat_short
	,err_cd
	,first_log_seq
	,hu_checked
	,hu_passed
	,nio_count
	,nio_sonstige
	,send_out
	,nio_send_out
	,conveyor_id
FROM fe_mstr_logop.v_sapewm_mfs_nio_add_2
;
