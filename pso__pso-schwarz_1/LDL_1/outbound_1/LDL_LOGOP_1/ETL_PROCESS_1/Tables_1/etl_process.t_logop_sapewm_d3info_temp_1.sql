/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          etl_process
DB table/view:      t_logop_sapewm_d3info_temp_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-03      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_logop_sapewm_d3info_temp_1 for SAP EWM D3 data 
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_logop_sapewm_d3info_temp_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5)
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
freight_unit_id STRING(20) OPTIONS(description='Freight Unit_1 ID - Technical name: FU_ID - Component Type: ZEWM_E_FUID'),
pshu_id STRING(20)
OPTIONS(description='Handling Unit_1 Identification - Technical name: PSHUIDENT - Component Type: /SCWM/DE_HUIDENT'),
hu_id STRING(20)
OPTIONS(description='Handling Unit_1 Identification - Technical name: HUIDENT - Component Type: /SCWM/DE_HUIDENT'),
tu_nr STRING(18)
OPTIONS(description='Internal Number of Transportation Unit_1 - Technical name: TU_NUM - Component Type: /SCWM/DE_TU_NUM'),
activity_area STRING(4) OPTIONS(description='Activity Area - Technical name: AAREA - Component Type: /SCWM/DE_AAREA'),
sub_activity_area STRING(4)
OPTIONS(description='cartonization: Sub Activity Area - Technical name: AAREA_SUB - Component Type: ZEWM_E_CAP_SUB_AAREA'),
bus_partner_nr STRING(10)
OPTIONS(description='Business Partner Number - Technical name: STORE - Component Type: /SCDL/DL_PARTYNO'),
wave BIGNUMERIC(38,0) OPTIONS(description='Wave - Technical name: WAVE - Component Type: /SCWM/DE_WAVE'),
guid_pshu_id STRING(50)
OPTIONS(description='Unique Internal Identification of a Handling Unit_1 - Technical name: GUID_PSHU - Component Type: /SCWM/GUID_HU'),
extraction_ts DATETIME NOT NULL OPTIONS(description='Extraction timestamp'),
extraction_dt DATE NOT NULL OPTIONS(description='Extraction date'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
update_mode STRING(2) NOT NULL OPTIONS(description='update_mode'),
avro_file_name STRING(1000) NOT NULL OPTIONS(description='Name of avro file'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at')
) OPTIONS(description='TOMS Interface - D3 Data for BI Reporting');