/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          etl_process
DB table/view:      t_logop_sapewm_warehousetask_temp
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-03      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_logop_sapewm_warehousetask_temp for SAP EWM warehouse tasks
----------------------------------------------------------------------------------------------------
*/
CREATE TABLE etl_process.t_logop_sapewm_warehousetask_temp (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	wh_task_nr NUMBER(38,0) COMMENT 'Warehouse Task - Technical name: TANUM - Component Type: /SCWM/TANUM',
	wh_task_item NUMBER(38,0) COMMENT 'Warehouse Task Item - Technical name: TAPOS - Component Type: /SCWM/TAPOS',
	hu_flg BOOLEAN COMMENT 'Handling Unit Warehouse Task - Technical name: FLGHUTO - Component Type: /SCWM/FLGHUTO',
	wh_process_type VARCHAR(4) COMMENT 'Warehouse Process Type - Technical name: PROCTY - Component Type: /SCWM/DE_PROCTY',
	wh_process_cat VARCHAR(1) COMMENT 'Warehouse Process Category - Technical name: TRART - Component Type: /SCWM/LVS_TRART',
	activity_type VARCHAR(4) COMMENT 'Activity - Technical name: ACT_TYPE - Component Type: /SCWM/DE_ACTTY',
	product_nr VARCHAR(40) COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR',
	prod_desc VARCHAR(40) COMMENT 'Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX',
	crtd_by VARCHAR(12) COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATOR',
	crtd_on_dt DATE COMMENT 'Created On - Technical name: CREATED_DATE - Component Type: /SCWM/DE_CREATED_DATE',
	crtd_at_tm TIME(0) COMMENT 'Created At - Technical name: CREATED_TIME - Component Type: /SCWM/DE_CREATED_TIME',
	confirmed_by VARCHAR(12) COMMENT 'Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY',
	confirmed_dt DATE COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE',
	confirmed_tm TIME(0) COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME',
	wh_task_stat VARCHAR(1) COMMENT 'Warehouse Task Status - Technical name: TOSTAT - Component Type: /SCWM/DE_TOSTAT',
	who_nr NUMBER(38,0) COMMENT 'Warehouse Order Number - Technical name: WHO - Component Type: /SCWM/DE_WHO',
	QUEUE VARCHAR(10) COMMENT 'Queue - Technical name: QUEUE - Component Type: /SCWM/DE_QUEUE',
	src_tgt_qnty_buom NUMBER(38,3) COMMENT 'Source Target Quantity in Base Unit of Measure - Technical name: VSOLM - Component Type: /SCWM/DE_UI_VSOLM',
	dest_diff_qnty_buom NUMBER(38,3) COMMENT 'Destination Difference Quantity in Base Unit of Measure - Technical name: DMENG - Component Type: /SCWM/DE_UI_NDIFM',
	buom VARCHAR(12) COMMENT 'Base Unit of Measure - Technical name: MEINS - Component Type: MEINS',
	src_tgt_qnty_auom NUMBER(38,3) COMMENT 'Source Target Quantity in Alternate Unit of Measure - Technical name: VSOLA - Component Type: /SCWM/DE_UI_VSOLA',
	act_dest_qnty_auom NUMBER(38,3) COMMENT 'Actual Destination Quantity in Alternative Unit - Technical name: NISTA - Component Type: /SCWM/DE_UI_NISTA',
	dest_diff_qnty_auom NUMBER(38,3) COMMENT 'Destination Difference Qty in Alternative Unit - Technical name: DMENA - Component Type: /SCWM/DE_UI_NDIFA',
	exception_cd VARCHAR(4) COMMENT 'Exception Code - Technical name: EXCCODE - Component Type: /SCWM/DE_EXCCODE',
	src_strg_bin VARCHAR(18) COMMENT 'Source Storage Bin - Technical name: VLPLA - Component Type: /SCWM/LTAP_VLPLA',
	src_rsrc VARCHAR(18) COMMENT 'Source Resource (Means of Transport or User) - Technical name: SRSRC - Component Type: /SCWM/DE_SRSRC',
	src_hu VARCHAR(20) COMMENT 'Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	dest_strg_type VARCHAR(4) COMMENT 'Destination Storage Type - Technical name: NLTYP - Component Type: /SCWM/LTAP_NLTYP',
	dest_strg_bin VARCHAR(18) COMMENT 'Destination Storage Bin - Technical name: NLPLA - Component Type: /SCWM/LTAP_NLPLA',
	dest_rsrc VARCHAR(18) COMMENT 'Destination Resource (Means of Transport or User) - Technical name: DRSRC - Component Type: /SCWM/DE_DRSRC',
	dest_hu VARCHAR(20) COMMENT 'Destination Handling Unit - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR',
	src_strg_type VARCHAR(4) COMMENT 'Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP',
	ext_strg_procs_step VARCHAR(4) COMMENT 'External Storage Process Step - Technical name: PROCS - Component Type: /SCWM/DE_PROCS',
	wave NUMBER(38,0) COMMENT 'Wave - Technical name: WAVE - Component Type: /SCWM/DE_WAVE',
	start_dt DATE COMMENT 'Start Date - Technical name: STARTED_DATE - Component Type: /SCWM/DE_STARTED_DATE',
	start_tm TIME(0) COMMENT 'Start Time - Technical name: STARTED_TIME - Component Type: /SCWM/DE_STARTED_TIME',
	owner_id VARCHAR(10) COMMENT 'Owner - Technical name: OWNER - Component Type: /SCWM/DE_OWNER',
	doc_nr VARCHAR(35) COMMENT 'Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT',
	activity_area VARCHAR(4) COMMENT 'Activity Area - Technical name: AAREA - Component Type: /SCWM/DE_AAREA',
	who_seq NUMBER(38,6) COMMENT 'Internal Sequence of Warehouse Order - Technical name: WHOSEQ - Component Type: /SCWM/DE_WHOSEQ_UI',
	hu_type VARCHAR(4) COMMENT 'Handling Unit Type - Technical name: LETYP - Component Type: /SCWM/DE_HUTYP',
	shelf_life_exp_dt DATE COMMENT 'Shelf Life Expiration Date - Technical name: VFDAT - Component Type: /SCWM/SLED',
	goods_recpt_dt DATE COMMENT 'Goods Receipt Date - Technical name: GRDATE - Component Type: /SCWM/DE_GR_DATE',
	goods_recpt_procs_tm TIME(0) COMMENT 'Goods Receipt Processing Time - Technical name: GRTIME - Component Type: /SCWM/DE_GR_TIME',
	load_volume NUMBER(38,3) COMMENT 'Loading or Net Volume - Technical name: VOLUM - Component Type: /SCWM/DE_NVOLUME',
	vol_unit VARCHAR(3) COMMENT 'Volume Unit - Technical name: UNIT_V - Component Type: /SCWM/DE_VOL_UOM',
	load_weight NUMBER(38,3) COMMENT 'Loading or Net Weight - Technical name: WEIGHT - Component Type: /SCWM/DE_NWEIGHT',
	weight_unit VARCHAR(3) COMMENT 'Weight Unit - Technical name: UNIT_W - Component Type: /SCWM/DE_WGT_UOM',
	auom VARCHAR(3) COMMENT 'Alternative Unit of Measure for Stockkeeping Unit - Technical name: ALTME - Component Type: /SCWM/DE_AUNIT',
	act_qty_dest_buom NUMBER(38,3) COMMENT 'Destination Actual Quantity in Stockkeeping Unit - Technical name: NISTM - Component Type: /SCWM/DE_UI_NISTM',
	doc_cat VARCHAR(3) COMMENT 'Document Category for Document-Related Stocks - Technical name: QDOCCAT - Component Type: /SCWM/DE_UI_QDOCCAT',
	doc_nr_stock_ref VARCHAR(35) COMMENT 'Document Number for Stock Reference - Technical name: QDOCNO - Component Type: /SCWM/DE_QDOCNO_MON',
	extraction_ts TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Extraction timestamp',
	extraction_dt DATE NOT NULL COMMENT 'Extraction date',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	update_mode VARCHAR(2) NOT NULL COMMENT 'update_mode',
	avro_file_name VARCHAR(1000) NOT NULL COMMENT 'Name of avro file',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	PRIMARY KEY (wh_nr, wh_task_nr, wh_task_item)
) COMMENT = 'Warehouse tasks for the BI Reporting'
;
