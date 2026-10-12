/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          etl_process
DB table/view:      t_logop_sapewm_missingitems_temp_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-03      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_logop_sapewm_missingitems_temp_1 for SAP EWM missing items
----------------------------------------------------------------------------------------------------
*/
CREATE TABLE etl_process.t_logop_sapewm_missingitems_temp_1 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	item_nr VARCHAR(10) COMMENT 'Missing item_1 number - Technical name: ZZ_MI_NO - Component Type: ZEWM_E_MI_NO',
	item_status_desc VARCHAR(60) COMMENT 'Description of missing article status_1 - Technical name: ZZ_MI_STATUS_T - Component Type: ZEWM_E_MI_STATUS_T',
	product_nr VARCHAR(40) COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR',
	item_desc VARCHAR(40) COMMENT 'Description - Technical name: PRODUCT_TEXT - Component Type: /SCDL/DL_TEXT',
	party_entitled_dispose VARCHAR(10) COMMENT 'Party Entitled to Dispose - Technical name: ENTITLED - Component Type: /SCWM/DE_ENTITLED',
	item_status VARCHAR(1) COMMENT 'Missing item_1 status_1 - Technical name: ZZ_MI_STATUS - Component Type: ZEWM_E_MI_STATUS',
	crtd_on_dt DATE COMMENT 'Date on which record was created - Technical name: ZZERDAT - Component Type: ZEWM_E_MI_ERDAT',
	crtd_at_tm TIME(0) COMMENT 'Entry Time - Technical name: ZZERZET - Component Type: ZEWM_E_MI_ERZET',
	changed_on_dt DATE COMMENT 'Changed On - Technical name: ZZAEDAT - Component Type: ZEWM_E_MI_AEDAT',
	changed_at_tm TIME(0) COMMENT 'Time last change was made - Technical name: ZZAEZET - Component Type: ZEWM_E_MI_AEZET',
	extraction_ts TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Extraction timestamp',
	extraction_dt DATE NOT NULL COMMENT 'Extraction date',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	update_mode VARCHAR(2) NOT NULL COMMENT 'update_mode',
	avro_file_name VARCHAR(1000) NOT NULL COMMENT 'Name of avro file',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	PRIMARY KEY (wh_nr, product_nr, crtd_on_dt, crtd_at_tm)
) COMMENT = 'Structure - Missing Items - BI Reporting'
;
