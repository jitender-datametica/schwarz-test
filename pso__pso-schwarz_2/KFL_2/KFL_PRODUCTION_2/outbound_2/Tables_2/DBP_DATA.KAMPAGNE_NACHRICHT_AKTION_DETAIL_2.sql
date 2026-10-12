--==============================================================
-- Table: kampagne_nachricht_aktion_detail_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_nachricht_aktion_detail_2
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kampagne_nachricht_aktion_detail_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
nachricht_workflow_id STRING(100) NOT NULL
OPTIONS(description='ID des Workflows, der die Interaktionen zum Kunde in einer Kampagne_2 verarbeitet.'),
nachricht_vorlage_id STRING(100) NOT NULL OPTIONS(description='Eindeutige Kennung der verwendeten Nachrichtenvorlage.'),
kommunikationskanal_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennung des Kommunikationskanals, über den die Nachricht versendet wurde, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.'),
datzeit_nachricht_aktion TIMESTAMP NOT NULL
OPTIONS(description='Zeitpunkt, an dem der Empfänger die Aktion_2 ausgeführt hat.'),
nachricht_aktion_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID, die die Art_2 der ausgeführten Aktion_2 angibt, z. B. 1 = Link geklickt, 2 = Geöffnet, 3 = Feedback Loop.'),
personalisierte_url_name STRING(1000) NOT NULL
OPTIONS(description='Bezeichnung des Hyperlinks, auf den der Empfänger geklickt hat.'),
personalisierte_url_txt STRING(1000) NOT NULL
OPTIONS(description='Personalisierte URL des Hyperlinks, auf den der Empfänger geklickt hat.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, nachricht_workflow_id, nachricht_vorlage_id, kommunikationskanal_id, datzeit_nachricht_aktion,
 nachricht_aktion_typ_id, personalisierte_url_name, personalisierte_url_txt) NOT ENFORCED
)
OPTIONS(description='Diese Tabelle dient zur Erfassung von Details zu Nachrichtenaktionen. Derzeit enthält sie nur geklickte personalisierte URLs in Nachrichten.');