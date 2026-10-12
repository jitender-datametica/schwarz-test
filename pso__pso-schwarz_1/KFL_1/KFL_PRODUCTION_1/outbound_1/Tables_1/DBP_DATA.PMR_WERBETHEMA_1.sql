--==============================================================
-- Table: pmr_werbethema_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: pmr_werbethema_1
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:43:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pmr_werbethema_1 (
pmr_werbethema_id STRING(6) NOT NULL OPTIONS(description='Werbethema'),
pmr_werbethema_bez STRING(50) OPTIONS(description='Werbethemabezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='This table provides the name to the werbethema - means what is the topic of the promotion (Werbethema)          Example: Asia-Week, 1€, Backside');