--==============================================================
-- Table: kampagne_kampagne_nachricht_vorlage_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_kampagne_nachricht_vorlage_zu_2
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kampagne_kampagne_nachricht_vorlage_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
kampagne_id STRING(100) NOT NULL
OPTIONS(description='Eindeutige Kennung der Kampagne_2, innerhalb derer die personalisierte Nachricht gesendet wird.'),
nachricht_vorlage_id STRING(100) NOT NULL
OPTIONS(description='Vom Quellsystem generierte ID der Nachrichtenvorlage (GUID).'),
kommunikationskanal_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennung des Kommunikationskanals, für den die Nachrichtenvorlage bestimmt ist, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kampagne_id, nachricht_vorlage_id, kommunikationskanal_id) NOT ENFORCED
)
OPTIONS(description='Zuordnung von Nachrichtenvorlagen zu Kampagnen. Darüber lässt sich sehen welche Vorlagen für welche Kampagnen verwendet werden.');