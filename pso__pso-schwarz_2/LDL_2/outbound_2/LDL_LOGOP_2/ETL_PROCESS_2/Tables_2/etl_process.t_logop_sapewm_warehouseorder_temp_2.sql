/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          etl_process
DB table/view:      t_logop_sapewm_warehouseorder_temp_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-03      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_logop_sapewm_warehouseorder_temp_2 for SAP EWM warehouse orders
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_logop_sapewm_warehouseorder_temp_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
who_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warehouse Order Number - Technical name: WHO - Component Type: /SCWM/DE_WHO'),
queue STRING(10) OPTIONS(description='Queue - Technical name: QUEUE - Component Type: /SCWM/DE_QUEUE'),
wave BIGNUMERIC(38,0) OPTIONS(description='Wave - Technical name: WAVE - Component Type: /SCWM/DE_WAVE'),
who_status STRING(1)
OPTIONS(description='Warehouse Order Status_2 - Technical name: STATUS_2 - Component Type: /SCWM/DE_WHOSTAT'),
who_activity_area STRING(4)
OPTIONS(description='Warehouse Order Activity Area - Technical name: AAREA - Component Type: /SCWM/DE_WHOAA'),
crtd_by STRING(12) OPTIONS(description='Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATOR'),
crtd_on_dt DATE OPTIONS(description='Created On - Technical name: CREATED_DATE - Component Type: /SCWM/DE_CREATED_DATE'),
crtd_at_tm TIME OPTIONS(description='Created At - Technical name: CREATED_TIME - Component Type: /SCWM/DE_CREATED_TIME'),
processor STRING(12) OPTIONS(description='Processor - Technical name: PROCESSOR - Component Type: /SCWM/DE_PROCESSOR'),
rsrc STRING(18)
OPTIONS(description='Resource (Means of Transportation or User) - Technical name: RSRC - Component Type: /SCWM/DE_RSRC'),
start_dt DATE OPTIONS(description='Start Date - Technical name: STARTED_DATE - Component Type: /SCWM/DE_STARTED_DATE'),
start_tm TIME OPTIONS(description='Start Time - Technical name: STARTED_TIME - Component Type: /SCWM/DE_STARTED_TIME'),
last_start_dt DATE OPTIONS(description='Latest Start Date - Technical name: LS_DATE - Component Type: /SCWM/DE_LS_DATE'),
last_start_tm TIME OPTIONS(description='Latest Start Time - Technical name: LS_TIME - Component Type: /SCWM/DE_LS_TIME'),
changed_by STRING(12) OPTIONS(description='Changed By - Technical name: CHANGED_BY - Component Type: /SCWM/DE_EDITOR'),
changed_on_dt DATE
OPTIONS(description='Changed On - Technical name: CHANGED_DATE - Component Type: /SCWM/DE_CHANGED_DATE'),
changed_at_tm TIME
OPTIONS(description='Changed At - Technical name: CHANGED_TIME - Component Type: /SCWM/DE_CHANGED_TIME'),
conf_by STRING(12)
OPTIONS(description='Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY'),
conf_dt DATE
OPTIONS(description='Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'),
conf_tm TIME
OPTIONS(description='Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'),
exec_tm_plan BIGNUMERIC(38,3)
OPTIONS(description='Planned Execution Time of Warehouse Order - Technical name: PLANDURA - Component Type: /SCWM/DE_WHOPLANDURA'),
exec_tm_act BIGNUMERIC(38,3)
OPTIONS(description='Actual Execution Time of Warehouse Order - Technical name: ACTDURA - Component Type: /SCWM/DE_WHOACTDURA'),
who_time_unit STRING(3)
OPTIONS(description='Warehouse Order: Time Unit_2 - Technical name: UNIT_T - Component Type: /SCWM/DE_WHOUNITT'),
nr_wt BIGNUMERIC(38,0) OPTIONS(description='Number of WTs - Technical name: COUNT_TO - Component Type: /SCWM/DE_NO_TO'),
who_contains_pi_doc BOOL
OPTIONS(description='WO Contains Physical Inventory Document - Technical name: FLGINV - Component Type: /SCWM/DE_FLGINV'),
who_contains_wt BOOL
OPTIONS(description='Warehouse Order Contains Warehouse Task - Technical name: FLGTO - Component Type: /SCWM/DE_FLGTO'),
total_processing_time BIGNUMERIC(38,3)
OPTIONS(description='Total Processing Time - Technical name: SUM_REACHTIME - Component Type: /SCWM/DE_REACHTT_SUM'),
time_unit STRING(3) OPTIONS(description='Time Unit_2 - Technical name: UNIT_RT - Component Type: /SCWM/LVS_ZEIEI'),
planned_compl_dt DATE
OPTIONS(description='Planned Completion Date - Technical name: PICK_COMP_DATE - Component Type: /SCWM/DE_TOCOMPL_DATE'),
planned_compl_tm TIME
OPTIONS(description='Planned Completion Time - Technical name: PICK_COMP_TIME - Component Type: /SCWM/DE_TOCOMPL_TIME'),
extraction_ts DATETIME NOT NULL OPTIONS(description='Extraction timestamp'),
extraction_dt DATE NOT NULL OPTIONS(description='Extraction date'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
update_mode STRING(2) NOT NULL OPTIONS(description='update_mode'),
avro_file_name STRING(1000) NOT NULL OPTIONS(description='Name of avro file'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (wh_nr, who_nr) NOT ENFORCED
) OPTIONS(description='Warehouse orders for BI Reporting');