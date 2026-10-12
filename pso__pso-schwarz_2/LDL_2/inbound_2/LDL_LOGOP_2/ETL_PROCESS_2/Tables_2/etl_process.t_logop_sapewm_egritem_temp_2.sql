/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          etl_process
DB table/view:      t_logop_sapewm_egritem_temp_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-03      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_logop_sapewm_egritem_temp_2 for SAP EWM expected goods receipt items
----------------------------------------------------------------------------------------------------
*/
CREATE TABLE etl_process.t_logop_sapewm_egritem_temp_2 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_2 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_2 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	doc_nr VARCHAR(35) COMMENT 'Document Number - Technical name: DOCNO - Component Type: /SCDL/DL_DOCNO_INT',
	item_nr NUMBER(38,0) COMMENT 'Item_2 Number - Technical name: ITEMNO - Component Type: /SCWM/DE_ITEMNO',
	product_nr VARCHAR(40) COMMENT 'Product - Technical name: PRODUCTNO - Component Type: /SCDL/DL_PRODUCTNO',
	stock_type VARCHAR(2) COMMENT 'Stock Type - Technical name: STOCK_CATEGORY - Component Type: /SCDL/DL_STOCK_CATEGORY',
	quantity NUMBER(38,3) COMMENT 'Quantity - Technical name: QUANTITY - Component Type: /SCWM/DE_UI_QUAN',
	uom VARCHAR(3) COMMENT 'Unit_2 of Measure - Technical name: UOM - Component Type: /SCDL/DL_UOM',
	crtd_by VARCHAR(12) COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/SP_CREUSR',
	crtd_on_dt DATE COMMENT 'Created On - Technical name: CREATED_ON - Component Type: /SCWM/SP_CREDAT',
	crtd_at_tm TIME(0) COMMENT 'Created At - Technical name: CREATED_AT - Component Type: /SCWM/SP_CRETIM',
	ref_code VARCHAR(21) COMMENT 'Administrative Reference Code - Technical name: ZZ_ARC - Component Type: ZEWM_E_ARC',
	extraction_ts TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Extraction timestamp',
	extraction_dt DATE NOT NULL COMMENT 'Extraction date',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	update_mode VARCHAR(2) NOT NULL COMMENT 'update_mode',
	avro_file_name VARCHAR(1000) NOT NULL COMMENT 'Name of avro file',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	is_active_fg BOOLEAN NOT NULL COMMENT 'Flag indicating active record',
	PRIMARY KEY (wh_nr, doc_nr, product_nr)
) COMMENT = 'Expected Goods Receipt Item_2 Data for BI Reporting'
;
