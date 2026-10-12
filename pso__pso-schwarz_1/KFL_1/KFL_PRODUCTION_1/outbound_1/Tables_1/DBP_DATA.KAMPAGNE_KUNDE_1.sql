--==============================================================
-- Table: kampagne_kunde_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_kunde_1
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kampagne_kunde_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
kampagne_kunde_id STRING(100) NOT NULL
OPTIONS(description='Vom Quellsystem generierte ID des Kunden (GUID). Es ist der Empfänger der von Kampagnen gesendeten Nachrichten.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kampagne_kunde_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält die Nutzer, bzw. Kunden, an die im Zuge von Marketingkampagnen Nachrichten geschickt werden. Sie dient dazu, die Empfänger von verschiedenen Kommunikationspunkten wie E-Mails, Push-Benachrichtigungen und SMS zu definieren und zu verwalten.');