/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_storagebinphystk_1
====================================================================================================
*/

CREATE TABLE DATA.t_logop_sapewm_storagebinphystk_1 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	log_pos VARCHAR(2) COMMENT 'Logical Position of Handling Unit_1 - Technical name: LOGPOS - Component Type: /SCWM/DE_LOGPOS',
	hu_ident VARCHAR(20) COMMENT 'Handling Unit_1 Identification - Technical name: HUIDENT - Component Type: /SCWM/DE_HUIDENT',
	product_nr VARCHAR(40) COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR',
	product_desc VARCHAR(40) COMMENT 'Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX',
	quantity NUMBER(38,3) COMMENT 'Quantity - Technical name: QUAN - Component Type: /SCWM/DE_UI_QUAN',
	buom VARCHAR(3) COMMENT 'Base Unit_1 of Measure - Technical name: UNIT_1 - Component Type: /SCWM/DE_BASE_UOM',
	packed_qnty_auom NUMBER(38,3) COMMENT 'Packed Quantity in Alternative Unit_1 of Measure - Technical name: QUANA - Component Type: /SCWM/DE_UI_QUAN_PACKED',
	stock_type VARCHAR(2) COMMENT 'Stock Type - Technical name: CAT - Component Type: /SCWM/DE_CAT',
	batch VARCHAR(10) COMMENT 'Batch - Technical name: CHARG - Component Type: /SCWM/DE_CHARG',
	shelf_life_exp_date DATE COMMENT 'Shelf Life Expiration Date - Technical name: VFDAT - Component Type: /SCWM/SLED',
	gr_dt DATE COMMENT 'Goods Receipt Date - Technical name: UI_WDATU - Component Type: /SCWM/DE_UI_WDATU',
	gr_tm TIME(0) COMMENT 'Goods Receipt Time - Technical name: UI_WDATT - Component Type: /SCWM/DE_UI_WDATT',
	doc_cat_doc_ref VARCHAR(3) COMMENT 'Doc. Category for Doc. Reference and Doc.-Related Stocks - Technical name: DOCCAT - Component Type: /SCWM/DE_DOCCAT',
	doc_nr VARCHAR(35) COMMENT 'Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT',
	strg_bin VARCHAR(18) COMMENT 'Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA',
	auom VARCHAR(3) COMMENT 'Alternative Unit_1 of Measure for Stockkeeping Unit_1 - Technical name: ALTME - Component Type: /SCWM/DE_AUNIT',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	dwh_valid_from DATE NOT NULL COMMENT 'Valid from date',
	dwh_valid_to DATE NOT NULL COMMENT 'Valid to date',
	deleted_fg BOOLEAN NOT NULL COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_nr, hu_ident, product_nr, gr_dt, gr_tm, batch, strg_bin, stock_type, doc_nr, dwh_valid_from)
	)
	COMMENT = 'Storage Bin Physical Stock - BI reporting'
;

