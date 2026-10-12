/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          etl_process
DB table/view:      t_logop_sapewm_niohistory_temp_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-03      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_logop_sapewm_niohistory_temp_1 for SAP EWM NIO history
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_logop_sapewm_niohistory_temp_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
hu_ident STRING(20) NOT NULL
OPTIONS(description='Handling Unit_1 Identification - Technical name: HUIDENT - Component Type: /SCWM/DE_HUIDENT'),
log_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Log Sequence - Technical name: LOG_SEQ - Component Type: /SCWM/DE_LOG_SEQ'),
com_point STRING(18)
OPTIONS(description='Communication_1 Point for Conveyor Technique - Technical name: CP - Component Type: /SCWM/DE_MFSCP'),
hu_status STRING(5) OPTIONS(description='Object Status_1 - Technical name: HU_STATUS - Component Type: CRM_J_STATUS'),
crtd_on_dt DATE OPTIONS(description='Created On - Technical name: CREATED_ON - Component Type: /SCWM/SP_CREDAT'),
crtd_at_tm TIME OPTIONS(description='Created At - Technical name: CREATED_AT - Component Type: /SCWM/SP_CRETIM'),
hu_status_short STRING(4)
OPTIONS(description='Individual status_1 of an object (short form) - Technical name: HU_STATUS_SHORT - Component Type: J_TXT04'),
extraction_ts DATETIME NOT NULL OPTIONS(description='Extraction timestamp'),
extraction_dt DATE NOT NULL OPTIONS(description='Extraction date'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
update_mode STRING(2) NOT NULL OPTIONS(description='update_mode'),
avro_file_name STRING(1000) NOT NULL OPTIONS(description='Name of avro file'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (wh_nr, log_seq, hu_ident) NOT ENFORCED
) OPTIONS(description='Structure - NIO History - BI Reporting');