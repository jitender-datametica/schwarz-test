--==============================================================
-- Table: in_l_leistungsart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_leistungsart
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_l_leistungsart (
co_leistungsart_id STRING(7) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der CO-Leistungsart aus der Quelle lstar'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='LIS - Lookup Tabelle der CO-Leistungsarten aus SAP Industrie cslt');