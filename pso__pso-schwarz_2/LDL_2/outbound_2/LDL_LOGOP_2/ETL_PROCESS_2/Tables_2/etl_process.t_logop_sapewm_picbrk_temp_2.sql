/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          etl_process
DB table/view:      t_logop_sapewm_picbrk_temp_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-03      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_logop_sapewm_picbrk_temp_2 for SAP EWM picking break
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_logop_sapewm_picbrk_temp_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
crtd_by STRING(12) NOT NULL
OPTIONS(description='Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATED_BY'),
start_dt DATE NOT NULL
OPTIONS(description='Start Date - Technical name: START_DATE - Component Type: /SCWM/DE_STARTED_DATE'),
start_tm TIME NOT NULL
OPTIONS(description='Start Time - Technical name: START_TIME - Component Type: /SCWM/DE_STARTED_TIME'),
end_dt DATE OPTIONS(description='End Date - Technical name: END_DATE - Component Type: /SCWM/DE_ENDED_DATE'),
end_tm TIME OPTIONS(description='End Time - Technical name: END_TIME - Component Type: /SCWM/DE_ENDED_TIME'),
who_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warehouse Order Number - Technical name: WHO - Component Type: /SCWM/DE_WHO'),
extraction_ts DATETIME NOT NULL OPTIONS(description='Extraction timestamp'),
extraction_dt DATE NOT NULL OPTIONS(description='Extraction date'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
update_mode STRING(2) NOT NULL OPTIONS(description='update_mode'),
avro_file_name STRING(1000) NOT NULL OPTIONS(description='Name of avro file'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (wh_nr, crtd_by, start_dt, start_tm, who_nr) NOT ENFORCED
) OPTIONS(description='Picking Break in RF for the BI Reporting');