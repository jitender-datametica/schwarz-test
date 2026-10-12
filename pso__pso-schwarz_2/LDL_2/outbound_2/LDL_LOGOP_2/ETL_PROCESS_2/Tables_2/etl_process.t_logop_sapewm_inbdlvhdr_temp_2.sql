/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          etl_process
DB table/view:      t_logop_sapewm_inbdlvhdr_temp_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-03      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_logop_sapewm_inbdlvhdr_temp_2 for SAP EWM inbound delivery header
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_logop_sapewm_inbdlvhdr_temp_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
doc_nr STRING(35) NOT NULL
OPTIONS(description='Document - Technical name: DOCNO_H - Component Type: /SCWM/SP_DOCNO_INT'),
ship_from_nr STRING(28)
OPTIONS(description='Ship-from - Technical name: SHIP_FROM_PARTY - Component Type: /SCWM/DE_SHIP_FROM'),
vehicle_nr STRING(20)
OPTIONS(description='Vehicle - Technical name: TRANSMEANS_ID - Component Type: /SCWM/DE_VEH_NUM_EXT'),
transport_unit STRING(20)
OPTIONS(description='Transportation Unit_2 - Technical name: TU - Component Type: /SCWM/DE_TU_NUM_EXT'),
adv_ship_notif STRING(35)
OPTIONS(description='Advanced Shipping Notification - Technical name: REFDOCNO_EXTASN - Component Type: /SCWM/SP_DOCNO_ASN'),
lia_nr STRING(20) OPTIONS(description='LIA Number - Technical name: ZZ_EXREF - Component Type: ZEWM_E_EXREF'),
wh_door_nr STRING(4) OPTIONS(description='Warehouse Door - Technical name: DOOR - Component Type: /SCWM/DE_DOOR'),
item_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of Items - Technical name: NO_ITEM - Component Type: /SCWM/DE_WIP_WHRHEAD_NOITM'),
product_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of Products - Technical name: NO_PRODUCT - Component Type: /SCWM/DE_WIP_WHRHEAD_NOPROD'),
planned_dlv_dt DATE
OPTIONS(description='Delivery Date (Planned) - Technical name: DLV_DATE - Component Type: /SCWM/SP_DELDATE'),
planned_dlv_tm TIME
OPTIONS(description='Delivery Time (Planned) - Technical name: DLV_TIME - Component Type: /SCWM/SP_DELTIME'),
crtd_on_dt DATE OPTIONS(description='Created On - Technical name: TDELIVERY_CRE_DATE - Component Type: /SCWM/SP_CREDAT'),
crtd_at_tm TIME OPTIONS(description='Created At - Technical name: TDELIVERY_CRE_TIME - Component Type: /SCWM/SP_CRETIM'),
purchase_order_nr STRING(40)
OPTIONS(description='Purchase Order - Technical name: PO_NUMBER - Component Type: /SCWM/DE_WIP_DOCNO_PO'),
extraction_ts DATETIME NOT NULL OPTIONS(description='Extraction timestamp'),
extraction_dt DATE NOT NULL OPTIONS(description='Extraction date'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
update_mode STRING(2) NOT NULL OPTIONS(description='Update mode'),
avro_file_name STRING(1000) NOT NULL OPTIONS(description='Name of avro file in prepared zone'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (wh_nr, doc_nr) NOT ENFORCED
) OPTIONS(description='Inbound Delivery Header for BI Reporting');