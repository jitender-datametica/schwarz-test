/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          etl_process
DB table/view:      t_logop_sapewm_missingitems_temp_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-03      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_logop_sapewm_missingitems_temp_2 for SAP EWM missing items
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_logop_sapewm_missingitems_temp_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
item_nr STRING(10) OPTIONS(description='Missing item_2 number - Technical name: ZZ_MI_NO - Component Type: ZEWM_E_MI_NO'),
item_status_desc STRING(60)
OPTIONS(description='Description of missing article status_2 - Technical name: ZZ_MI_STATUS_T - Component Type: ZEWM_E_MI_STATUS_T'),
product_nr STRING(40) NOT NULL OPTIONS(description='Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'),
item_desc STRING(40) OPTIONS(description='Description - Technical name: PRODUCT_TEXT - Component Type: /SCDL/DL_TEXT'),
party_entitled_dispose STRING(10)
OPTIONS(description='Party Entitled to Dispose - Technical name: ENTITLED - Component Type: /SCWM/DE_ENTITLED'),
item_status STRING(1)
OPTIONS(description='Missing item_2 status_2 - Technical name: ZZ_MI_STATUS - Component Type: ZEWM_E_MI_STATUS'),
crtd_on_dt DATE NOT NULL
OPTIONS(description='Date on which record was created - Technical name: ZZERDAT - Component Type: ZEWM_E_MI_ERDAT'),
crtd_at_tm TIME NOT NULL OPTIONS(description='Entry Time - Technical name: ZZERZET - Component Type: ZEWM_E_MI_ERZET'),
changed_on_dt DATE OPTIONS(description='Changed On - Technical name: ZZAEDAT - Component Type: ZEWM_E_MI_AEDAT'),
changed_at_tm TIME
OPTIONS(description='Time last change was made - Technical name: ZZAEZET - Component Type: ZEWM_E_MI_AEZET'),
extraction_ts DATETIME NOT NULL OPTIONS(description='Extraction timestamp'),
extraction_dt DATE NOT NULL OPTIONS(description='Extraction date'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
update_mode STRING(2) NOT NULL OPTIONS(description='update_mode'),
avro_file_name STRING(1000) NOT NULL OPTIONS(description='Name of avro file'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (wh_nr, product_nr, crtd_on_dt, crtd_at_tm) NOT ENFORCED
) OPTIONS(description='Structure - Missing Items - BI Reporting');