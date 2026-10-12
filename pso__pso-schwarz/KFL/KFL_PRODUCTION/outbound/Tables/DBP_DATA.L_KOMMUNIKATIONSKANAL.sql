--==============================================================
-- Table: l_kommunikationskanal
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_kommunikationskanal
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_kommunikationskanal (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
kommunikationskanal_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige Kennung des Kommunikationskanals, z. B. 1 = E-Mail, 2 = Push Notification, 3 = SMS.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kommunikationskanal_id) NOT ENFORCED
) OPTIONS(description='Die Tabelle enthält die verfügbaren Kommunikationskanäle für Marketingkampagnen.');