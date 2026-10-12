/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          etl_process
DB table/view:      t_logop_sapewm_egritem_temp_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-03      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_logop_sapewm_egritem_temp_2 for SAP EWM expected goods receipt items
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_logop_sapewm_egritem_temp_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
doc_nr STRING(35) NOT NULL
OPTIONS(description='Document Number - Technical name: DOCNO - Component Type: /SCDL/DL_DOCNO_INT'),
item_nr BIGNUMERIC(38,0) OPTIONS(description='Item_2 Number - Technical name: ITEMNO - Component Type: /SCWM/DE_ITEMNO'),
product_nr STRING(40) NOT NULL
OPTIONS(description='Product - Technical name: PRODUCTNO - Component Type: /SCDL/DL_PRODUCTNO'),
stock_type STRING(2)
OPTIONS(description='Stock Type - Technical name: STOCK_CATEGORY - Component Type: /SCDL/DL_STOCK_CATEGORY'),
quantity BIGNUMERIC(38,3) OPTIONS(description='Quantity - Technical name: QUANTITY - Component Type: /SCWM/DE_UI_QUAN'),
uom STRING(3) OPTIONS(description='Unit_2 of Measure - Technical name: UOM - Component Type: /SCDL/DL_UOM'),
crtd_by STRING(12) OPTIONS(description='Created By - Technical name: CREATED_BY - Component Type: /SCWM/SP_CREUSR'),
crtd_on_dt DATE OPTIONS(description='Created On - Technical name: CREATED_ON - Component Type: /SCWM/SP_CREDAT'),
crtd_at_tm TIME OPTIONS(description='Created At - Technical name: CREATED_AT - Component Type: /SCWM/SP_CRETIM'),
ref_code STRING(21)
OPTIONS(description='Administrative Reference Code - Technical name: ZZ_ARC - Component Type: ZEWM_E_ARC'),
extraction_ts DATETIME NOT NULL OPTIONS(description='Extraction timestamp'),
extraction_dt DATE NOT NULL OPTIONS(description='Extraction date'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
update_mode STRING(2) NOT NULL OPTIONS(description='update_mode'),
avro_file_name STRING(1000) NOT NULL OPTIONS(description='Name of avro file'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
is_active_fg BOOL NOT NULL OPTIONS(description='Flag indicating active record'),
PRIMARY KEY (wh_nr, doc_nr, product_nr) NOT ENFORCED
) OPTIONS(description='Expected Goods Receipt Item_2 Data for BI Reporting');