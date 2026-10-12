/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_goodsin_lanedoorutil_kpi_1
Description		|	SAP EWM Goods In - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_goodsin_lanedoorutil_kpi_1 (
	client_id COMMENT 'Client id (PK)'
	, lidl_ctry COMMENT 'Country_1 code'
	, wh_id COMMENT 'Warehouse ID (PK)'
	, wh_task_nr COMMENT 'Warehouse Task (PK)'
	, wh_task_item COMMENT 'Warehouse Task Item_1 (PK)'
	, conf_dt COMMENT 'Confirmation date'
	, conf_tm COMMENT 'Confirmation time'
	, wh_proc_cat COMMENT 'Warehouse Process Category'
	, wh_task_stat COMMENT 'Warehouse Task Status_1'
	, prod_nr COMMENT 'Product number'
	, prod_desc COMMENT 'Product description'
	, doc_nr COMMENT 'Document number (PK)'
	, doc_cat COMMENT 'Document Category for Document-Related Stocks'
	, dest_hu COMMENT 'Destination handling unit_1'
	, dest_strg_bin COMMENT 'Destination storage bin'
	, dest_strg_type COMMENT 'Destination storage type'
	, dwh_created COMMENT 'Record created at'
	, dwh_updated COMMENT 'Record updated at'
	, rev_conf_dt COMMENT 'Confirmation date of reversal'
	, rev_conf_tm COMMENT 'Confirmation time of reversal'
	, rev_doc_nr COMMENT 'Document number of reversal'
	, rev_src_hu COMMENT 'Source Handling Unit_1 of reversal'
	, wh_door_nr COMMENT 'Warehouse door number'
	, plnd_dlv_dt COMMENT 'Planned delivery date'
	) 
	COMMENT = 'SAP EWM Goods In - view with final KPIs for FE (PK client_id, wh_id, wh_task_nr, wh_task_item, doc_nr)' 
AS
SELECT
	client_id
	, lidl_ctry
	, wh_id
	, wh_task_nr
	, wh_task_item
	, conf_dt
	, conf_tm
	, wh_proc_cat
	, wh_task_stat
	, prod_nr
	, prod_desc
	, doc_nr
	, doc_cat
	, dest_hu
	, dest_strg_bin
	, dest_strg_type
	, dwh_created
	, dwh_updated
	, rev_conf_dt
	, rev_conf_tm
	, rev_doc_nr
	, rev_src_hu
	, wh_door_nr
	, plnd_dlv_dt
FROM fe_mstr_logop.v_sapewm_goodsin_lanedoorutil_add_1
;
