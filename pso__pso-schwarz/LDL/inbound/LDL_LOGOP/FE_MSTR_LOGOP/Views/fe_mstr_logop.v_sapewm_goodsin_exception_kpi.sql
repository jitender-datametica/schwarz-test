/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_goodsin_exception_kpi
Description		|	SAP EWM Goods In - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_goodsin_exception_kpi ( 
	client_id COMMENT 'Client ID (PK)'
	, lidl_ctry COMMENT 'Country code'
	, wh_id COMMENT 'Warehouse ID (PK)'
	, wh_task_nr COMMENT 'Warehouse task number (PK)'
	, wh_task_item COMMENT 'Warehouse Task Item (PK)'
	, conf_dt COMMENT 'Confirmation date'
	, conf_tm COMMENT 'Confirmation time'
	, wh_proc_cat COMMENT 'Warehouse process category'
	, wh_task_stat COMMENT 'Warehouse Task Status'
	, prod_nr COMMENT 'Product number'
	, prod_desc COMMENT 'Product short description'
	, doc_nr COMMENT 'Document number'
	, doc_cat COMMENT 'Document category for document-related stocks'
	, src_hu COMMENT 'Source handling unit'
	, src_strg_bin COMMENT 'Source storage bin'
	, src_strg_type COMMENT 'Source storage type'
	, dest_hu COMMENT 'Destination handling unit'
	, dest_strg_bin COMMENT 'Destination storage bin'
	, dest_strg_type COMMENT 'Destination storage type'
	, QUEUE COMMENT 'Queue'
	, act_area COMMENT 'Activity area'
	, act_type COMMENT 'Activity type'
	, exc_cd COMMENT 'Exception code'
	, dwh_created COMMENT 'Record created at'
	, dwh_updated COMMENT 'Record updated at'
	, receipt_fg COMMENT 'Flag for original receipt record'
	, dest_strg_bin_clrg COMMENT 'Destination storage bin of clearing'
	, clrg_area COMMENT 'Area of clearing'
	, rejected_area COMMENT 'Area of rejection'
	, clearing_cnt COMMENT 'Clearing count'
	, reversal_cnt COMMENT 'Reversal count'
	, underdeliv_cnt COMMENT 'Underdelivery if delivered quantity is smaller than ordered quantity'
	, clearing_amount COMMENT 'Amount of clearing without underdelivery'
	) 
	COMMENT = 'SAP EWM Goods In - view with final KPIs for FE (PK client_id, wh_id, wh_task_nr, wh_task_item)' 
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
	, src_hu
	, src_strg_bin
	, src_strg_type
	, dest_hu
	, dest_strg_bin
	, dest_strg_type
	, QUEUE
	, act_area
	, act_type
	, exc_cd
	, dwh_created
	, dwh_updated
	, receipt_fg
	, dest_strg_bin_clrg
	, clrg_area
	, rejected_area
	, clearing_cnt
	, reversal_cnt
	, underdeliv_cnt
	, clearing_amount
FROM fe_mstr_logop.v_sapewm_goodsin_exception_add
;