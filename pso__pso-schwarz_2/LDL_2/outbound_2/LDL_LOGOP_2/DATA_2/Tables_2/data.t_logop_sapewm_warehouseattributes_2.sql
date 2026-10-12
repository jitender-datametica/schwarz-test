/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_warehouseattributes_2
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_logop_sapewm_warehouseattributes_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
product_nr STRING(40) NOT NULL OPTIONS(description='Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'),
product_desc STRING(40)
OPTIONS(description='Product Description - Technical name: MAKTX - Component Type: /SCMB/MDL_PRODUCT_TEXT'),
party_entitled_dispose STRING(10)
OPTIONS(description='Party Entitled to Dispose - Technical name: ENTITLED - Component Type: /SCWM/DE_ENTITLED'),
buom STRING(3) OPTIONS(description='Base Unit_2 of Measure - Technical name: MEINS - Component Type: /SAPAPO/MEINS'),
mat_grp STRING(9) OPTIONS(description='Material Group - Technical name: MATKL - Component Type: /SAPAPO/MATKL'),
transp_grp STRING(4) OPTIONS(description='Transportation Group - Technical name: TRAGR - Component Type: /SAPAPO/TRAGR'),
strg_sec STRING(4)
OPTIONS(description='Storage Section Indicator - Technical name: LGBKZ - Component Type: /SCWM/LVS_LGBKZ'),
paci STRING(4) OPTIONS(description='Putaway Control - Technical name: PUT_STRA - Component Type: /SCWM/DE_PUT_STRA'),
srci STRING(4)
OPTIONS(description='Stock Removal Control - Technical name: REM_STRA - Component Type: /SCWM/DE_REM_STRA'),
staging_area STRING(4)
OPTIONS(description='Staging Area/Door Determination Group - Technical name: DRDETGR - Component Type: /SCWM/DE_DRDETGR'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, product_nr, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='Structure - WH Attributes - BI reporting');