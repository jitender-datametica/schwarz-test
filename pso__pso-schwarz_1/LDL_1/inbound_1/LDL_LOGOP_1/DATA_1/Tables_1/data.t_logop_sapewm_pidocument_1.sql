/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_pidocument_1
====================================================================================================
*/

CREATE TABLE DATA.t_logop_sapewm_pidocument_1 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	doc_nr NUMBER(38,0) COMMENT 'Number of Physical Inventory Document - Technical name: DOC_NUMBER - Component Type: /SCWM/DE_PI_DOC_NUMBER',
	item_nr NUMBER(38,0) COMMENT 'Item_1 - Technical name: ITEM_NO - Component Type: /LIME/LINE_ITEM_ID',
	doc_year NUMBER(38,0) COMMENT 'Document Year of Physical Inventory Document - Technical name: DOC_YEAR - Component Type: /LIME/PI_DOC_YEAR',
	doc_type VARCHAR(2) COMMENT 'Physical Inventory Procedure (Document Type of Phys. Inv.) - Technical name: DOC_TYPE - Component Type: /LIME/PI_DOCUMENT_TYPE',
	doc_status VARCHAR(4) COMMENT 'Physical Inventory Status_1 - Technical name: DOC_STATUS - Component Type: /LIME/PI_STATUS',
	activity_area VARCHAR(4) COMMENT 'Activity Area - Technical name: AAREA - Component Type: /SCWM/DE_AAREA',
	reason VARCHAR(4) COMMENT 'Reason - Technical name: REASON - Component Type: /SCWM/PI_REASON',
	reason_desc VARCHAR(40) COMMENT 'Reason Description - Technical name: REASON_TXT - Component Type: /SCWM/DE_REASON_TXT',
	prio NUMBER(38,0) COMMENT 'Priority - Technical name: PRIORITY - Component Type: /SCWM/PI_PRIORITY',
	prio_desc VARCHAR(12) COMMENT 'Priority Description - Technical name: PRIORITY_TXT - Component Type: /SCWM/PI_PRIORITY_TXT',
	crtd_on_dt DATE COMMENT 'Created On - Technical name: CREATE_DATE - Component Type: /SCWM/DE_CREATED_DATE',
	crtd_at_tm TIME(0) COMMENT 'Created At - Technical name: CREATE_TIME - Component Type: /SCWM/DE_CREATED_TIME',
	crtd_by VARCHAR(12) COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATOR',
	activ_dt DATE COMMENT 'Activation Date - Technical name: ACTI_DATE - Component Type: /SCWM/DE_ACTI_DATE',
	activ_tm TIME(0) COMMENT 'Activation Time - Technical name: ACTI_TIME - Component Type: /SCWM/DE_ACTI_TIME',
	cnt_dt DATE COMMENT 'Count Date - Technical name: COUNT_DATE - Component Type: /SCWM/DE_COUNT_DATE',
	cnt_tm TIME(0) COMMENT 'Count Time - Technical name: COUNT_TIME - Component Type: /SCWM/DE_COUNT_TIME',
	cnt_user VARCHAR(12) COMMENT 'Name of Counter - Technical name: COUNT_USER - Component Type: /SCWM/PI_DE_UI_COUNT_USER',
	post_dt DATE COMMENT 'Posting Date - Technical name: POST_DATE - Component Type: /SCWM/DE_POSTED_DATE',
	post_tm TIME(0) COMMENT 'Time of Posting - Technical name: POST_TIME - Component Type: /SCWM/DE_POSTED_TIME',
	last_changed_by VARCHAR(12) COMMENT 'Changed By - Technical name: LAST_CHANGED_BY - Component Type: /SCWM/DE_CHANGED_BY',
	strg_bin_empty VARCHAR(1) COMMENT 'Storage Bin Empty - Technical name: IND_BIN_EMPTY - Component Type: /SCWM/DE_IND_BIN_EMPTY',
	strg_type VARCHAR(4) COMMENT 'Storage Type - Technical name: LGTYP - Component Type: /SCWM/LGTYP',
	strg_sec VARCHAR(4) COMMENT 'Storage Section - Technical name: LGBER - Component Type: /SCWM/LGBER',
	strg_bin VARCHAR(18) COMMENT 'Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA',
	product_nr VARCHAR(40) COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR',
	product_desc VARCHAR(40) COMMENT 'Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX',
	batch VARCHAR(10) COMMENT 'Batch - Technical name: CHARG - Component Type: /SCWM/DE_CHARG',
	stock_type VARCHAR(2) COMMENT 'Stock Type - Technical name: CAT - Component Type: /SCWM/DE_CAT',
	stock_type_desc VARCHAR(30) COMMENT 'Description of Stock Type - Technical name: CAT_TEXT - Component Type: /SCWM/DE_UI_CAT_TEXT',
	party_entitled_dispose VARCHAR(10) COMMENT 'Party Entitled to Dispose - Technical name: ENTITLED - Component Type: /SCWM/DE_ENTITLED',
	partner_role_party_entitled_dispose VARCHAR(2) COMMENT 'Partner Role of Party Entitled to Dispose - Technical name: ENTITLED_ROLE - Component Type: /SCWM/DE_ENTITLED_ROLE',
	gr_dt DATE COMMENT 'Goods Receipt Date - Technical name: WDATU - Component Type: /SCWM/DE_WDATU',
	ui_gr_dt DATE COMMENT 'Goods Receipt Date - Technical name: UI_WDATU - Component Type: /SCWM/DE_UI_WDATU',
	ui_gr_tm TIME(0) COMMENT 'Goods Receipt Time - Technical name: UI_WDATT - Component Type: /SCWM/DE_UI_WDATT',
	shelf_life_exp_dt DATE COMMENT 'Shelf Life Expiration Date - Technical name: VFDAT - Component Type: /SCWM/SLED',
	who_nr NUMBER(38,0) COMMENT 'Warehouse Order Number - Technical name: WHO - Component Type: /SCWM/DE_WHO',
	quan_book NUMBER(38,3) COMMENT 'Book Inventory Balance Quantity (Physical Inventory) - Technical name: QUAN_BOOK - Component Type: /SCWM/DE_QUAN_BOOK',
	quan_count NUMBER(38,3) COMMENT 'Counted Quantity (Physical Inventory) - Technical name: QUAN_COUNT - Component Type: /SCWM/DE_QUAN_COUNT',
	quan_diff NUMBER(38,3) COMMENT 'Difference Quantity - Technical name: QUAN_DIFF - Component Type: /SCWM/DE_UI_QUAN_DIFF',
	quan_diff_abs NUMBER(38,3) COMMENT 'Absolute Difference Quantity - Technical name: QUAN_DIFF_ABS - Component Type: /SCWM/DE_QUAN_DIFF_ABS',
	buom VARCHAR(3) COMMENT 'Base Unit_1 of Measure - Technical name: UNIT_1 - Component Type: /SCWM/DE_BASE_UOM',
	value_diff NUMBER(38,2) COMMENT 'Difference Value - Technical name: VALUE_DIFF - Component Type: /SCWM/DE_VALUE_DIFF',
	value_diff_abs NUMBER(38,2) COMMENT 'Absolute Difference Value - Technical name: VALUE_DIFF_ABS - Component Type: /SCWM/DE_VALUE_DIFF_ABS',
	curr_key VARCHAR(5) COMMENT 'Currency Key - Technical name: WAERS - Component Type: WAERS',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at'
	)
	COMMENT = 'Physical Inventory documents for BI Reporting'
;
