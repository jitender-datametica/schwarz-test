/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          etl_process
DB table/view:      t_logop_sapewm_picbrk_temp
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-03      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_logop_sapewm_picbrk_temp for SAP EWM picking break
----------------------------------------------------------------------------------------------------
*/
CREATE TABLE etl_process.t_logop_sapewm_picbrk_temp (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	crtd_by VARCHAR(12) COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATED_BY',
	start_dt DATE COMMENT 'Start Date - Technical name: START_DATE - Component Type: /SCWM/DE_STARTED_DATE',
	start_tm TIME(0) COMMENT 'Start Time - Technical name: START_TIME - Component Type: /SCWM/DE_STARTED_TIME',
	end_dt DATE COMMENT 'End Date - Technical name: END_DATE - Component Type: /SCWM/DE_ENDED_DATE',
	end_tm TIME(0) COMMENT 'End Time - Technical name: END_TIME - Component Type: /SCWM/DE_ENDED_TIME',
	who_nr NUMBER(38,0) COMMENT 'Warehouse Order Number - Technical name: WHO - Component Type: /SCWM/DE_WHO',
	extraction_ts TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Extraction timestamp',
	extraction_dt DATE NOT NULL COMMENT 'Extraction date',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	update_mode VARCHAR(2) NOT NULL COMMENT 'update_mode',
	avro_file_name VARCHAR(1000) NOT NULL COMMENT 'Name of avro file',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	PRIMARY KEY (wh_nr, crtd_by, start_dt, start_tm, who_nr)
) COMMENT = 'Picking Break in RF for the BI Reporting'
;
