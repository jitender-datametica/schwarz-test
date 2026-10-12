/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_niohistory_2
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_logop_sapewm_niohistory_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
hu_ident STRING(20) NOT NULL
OPTIONS(description='Handling Unit_2 Identification - Technical name: HUIDENT - Component Type: /SCWM/DE_HUIDENT'),
log_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Log Sequence - Technical name: LOG_SEQ - Component Type: /SCWM/DE_LOG_SEQ'),
com_point STRING(18)
OPTIONS(description='Communication_2 Point for Conveyor Technique - Technical name: CP - Component Type: /SCWM/DE_MFSCP'),
hu_status STRING(5) OPTIONS(description='Object Status_2 - Technical name: HU_STATUS - Component Type: CRM_J_STATUS'),
crtd_on_dt DATE OPTIONS(description='Created On - Technical name: CREATED_ON - Component Type: /SCWM/SP_CREDAT'),
crtd_at_tm TIME OPTIONS(description='Created At - Technical name: CREATED_AT - Component Type: /SCWM/SP_CRETIM'),
hu_status_short STRING(4)
OPTIONS(description='Individual status_2 of an object (short form) - Technical name: HU_STATUS_SHORT - Component Type: J_TXT04'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (wh_nr, log_seq, hu_ident) NOT ENFORCED
) OPTIONS(description='Structure - NIO History - BI Reporting');