/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_inbdlvhdr_1
====================================================================================================
*/

CREATE TABLE DATA.t_logop_sapewm_inbdlvhdr_1 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	doc_nr VARCHAR(35) COMMENT 'Document - Technical name: DOCNO_H - Component Type: /SCWM/SP_DOCNO_INT',
	ship_from_nr VARCHAR(28) COMMENT 'Ship-from - Technical name: SHIP_FROM_PARTY - Component Type: /SCWM/DE_SHIP_FROM',
	vehicle_nr VARCHAR(20) COMMENT 'Vehicle - Technical name: TRANSMEANS_ID - Component Type: /SCWM/DE_VEH_NUM_EXT',
	transport_unit VARCHAR(20) COMMENT 'Transportation Unit_1 - Technical name: TU - Component Type: /SCWM/DE_TU_NUM_EXT',
	adv_ship_notif VARCHAR(35) COMMENT 'Advanced Shipping Notification - Technical name: REFDOCNO_EXTASN - Component Type: /SCWM/SP_DOCNO_ASN',
	lia_nr VARCHAR(20) COMMENT 'LIA Number - Technical name: ZZ_EXREF - Component Type: ZEWM_E_EXREF',
	wh_door_nr VARCHAR(4) COMMENT 'Warehouse Door - Technical name: DOOR - Component Type: /SCWM/DE_DOOR',
	item_cnt NUMBER(38,0) COMMENT 'Number of Items - Technical name: NO_ITEM - Component Type: /SCWM/DE_WIP_WHRHEAD_NOITM',
	product_cnt NUMBER(38,0) COMMENT 'Number of Products - Technical name: NO_PRODUCT - Component Type: /SCWM/DE_WIP_WHRHEAD_NOPROD',
	planned_dlv_dt DATE COMMENT 'Delivery Date (Planned) - Technical name: DLV_DATE - Component Type: /SCWM/SP_DELDATE',
	planned_dlv_tm TIME(0) COMMENT 'Delivery Time (Planned) - Technical name: DLV_TIME - Component Type: /SCWM/SP_DELTIME',
	crtd_on_dt DATE COMMENT 'Created On - Technical name: TDELIVERY_CRE_DATE - Component Type: /SCWM/SP_CREDAT',
	crtd_at_tm TIME(0) COMMENT 'Created At - Technical name: TDELIVERY_CRE_TIME - Component Type: /SCWM/SP_CRETIM',
	purchase_order_nr VARCHAR(40) COMMENT 'Purchase Order - Technical name: PO_NUMBER - Component Type: /SCWM/DE_WIP_DOCNO_PO',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	PRIMARY KEY (wh_nr, doc_nr)
	)
	COMMENT = 'Inbound Delivery Header for BI Reporting'
;
