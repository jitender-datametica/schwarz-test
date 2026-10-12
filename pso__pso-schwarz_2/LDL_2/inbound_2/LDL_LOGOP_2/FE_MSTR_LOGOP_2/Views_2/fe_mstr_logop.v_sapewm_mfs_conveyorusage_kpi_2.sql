/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_mfs_conveyorusage_kpi_2
Description		|	SAP EWM MFS - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_mfs_conveyorusage_kpi_2 (
	client_id COMMENT 'Client ID',
	lidl_ctry COMMENT 'Country_2 code',
	wh_id COMMENT 'Warehouse ID',
	wh_task_nr COMMENT 'Warehouse Task',
	wh_task_item COMMENT 'Warehouse Task Item_2',
	wh_task_stat COMMENT 'Warehouse Task Status_2',
	wh_proc_type COMMENT 'Warehouse Process Type',
	wh_proc_cat COMMENT 'Warehouse Process Category',
	doc_nr COMMENT 'Document',
	doc_cat COMMENT 'Document Category for Document-Related Stocks',
	conf_dt COMMENT 'Confirmation date',
	conf_tm COMMENT 'Confirmation time',
	conf_hr COMMENT 'Confirmation hour',
	QUEUE COMMENT 'Queue',
	exc_cd COMMENT 'Exception Code',
	src_strg_bin COMMENT 'Source Storage Bin',
	src_hu COMMENT 'Source Handling Unit_2',
	src_strg_type COMMENT 'Source Storage Type',
	src_rsrc COMMENT 'Source Resource (Means of Transport or User)',
	dest_strg_bin COMMENT 'Destination Storage Bin',
	dest_hu COMMENT 'Destination Handling Unit_2',
	dest_strg_type COMMENT 'Destination Storage Type',
	dest_rsrc COMMENT 'Destination Resource (Means of Transport or User)',
	dwh_created COMMENT 'DWH creation timestamp',
	dwh_updated COMMENT 'DWH update timestamp',
	ct_id COMMENT 'Conveyor type ID'
) COMMENT = 'SAP EWM MFS - view with final KPIs for FE (PK client_id, wh_id, wh_task_nr, wh_task_item, ct_id)'
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
	,conf_hr
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
	,ct_id
FROM fe_mstr_logop.v_sapewm_mfs_conveyorusage_add_2
;
