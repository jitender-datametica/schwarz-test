/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_egrheader
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_logop_sapewm_egrheader (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
doc_nr STRING(35) NOT NULL OPTIONS(description='Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT'),
blocked_status STRING(30)
OPTIONS(description='Blocked (Overall Status) - Technical name: STATUS_BLOCKED_OVERALL - Component Type: /SCWM/SP_OVERALL_BLOCK_STATUS'),
doc_type STRING(4) OPTIONS(description='Document Type - Technical name: DOCTYPE - Component Type: /SCDL/DL_DOCTYPE'),
doc_type_desc STRING(40)
OPTIONS(description='Document Type Description - Technical name: DOCTYPE_TXT - Component Type: /SCWM/SP_DOCTYPE_TXT'),
ship_from_nr STRING(10)
OPTIONS(description='Ship-from - Technical name: SHIP_FROM - Component Type: /SCWM/DE_SHIP_FROM'),
planned_dlv_dt DATE
OPTIONS(description='Delivery Date (Planned) - Technical name: TDELIVERY_DATE - Component Type: /SCWM/SP_DELDATE'),
planned_dlv_tm TIME
OPTIONS(description='Delivery Time (Planned) - Technical name: TDELIVERY_TIME - Component Type: /SCWM/SP_DELTIME'),
crtd_on_dt DATE OPTIONS(description='Created On - Technical name: CREATED_ON - Component Type: /SCWM/SP_CREDAT'),
crtd_at_tm TIME OPTIONS(description='Created At - Technical name: CREATED_AT - Component Type: /SCWM/SP_CRETIM'),
crtd_by STRING(12) OPTIONS(description='Created By - Technical name: CREATED_BY - Component Type: /SCWM/SP_CREUSR'),
lia_nr STRING(20) OPTIONS(description='LIA Number - Technical name: ZZ_EXREF - Component Type: ZEWM_E_EXREF'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
is_active_fg BOOL NOT NULL OPTIONS(description='Flag indicating active record'),
PRIMARY KEY (wh_nr, doc_nr) NOT ENFORCED
) OPTIONS(description='Expected Goods Receipt Header Data for BI Reporting');