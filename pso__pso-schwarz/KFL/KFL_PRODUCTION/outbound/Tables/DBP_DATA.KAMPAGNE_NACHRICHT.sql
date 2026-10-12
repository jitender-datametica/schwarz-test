--==============================================================
-- Table: kampagne_nachricht
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_nachricht
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kampagne_nachricht (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
nachricht_workflow_id STRING(100) NOT NULL
OPTIONS(description='ID des Workflows, der die Interaktionen zum Kunde in einer Kampagne verarbeitet.'),
nachricht_vorlage_id STRING(100) NOT NULL OPTIONS(description='Eindeutige Kennung der verwendeten Nachrichtenvorlage.'),
kommunikationskanal_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennung des Kommunikationskanals, über den die Nachricht versendet wurde, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.'),
kampagne_id STRING(100) NOT NULL
OPTIONS(description='Eindeutige Kennung der Kampagne, innerhalb derer die personalisierte Nachricht gesendet wird.'),
kampagne_kunde_id STRING(100) DEFAULT '-1' NOT NULL
OPTIONS(description='Eindeutige Kennung des Kunden, an den die Nachricht gesendet wurde. Nicht alle Quelltabellen enthalten diese Information und müssen aus anderen Quelltabellen gefüllt werden, daher bedeutet\'-1\', dass kein passender Kunde gefunden wurde.'),
nachricht_subvorlage_id_liste_txt STRING(1000)
OPTIONS(description='Enthält die Reihenfolge und IDs der verwendeten E-Mail-Subvorlagevarianten, z. B. "2-null-2-2", "2-3".'),
nachricht_subvorlage_name_liste_txt STRING(4000)
OPTIONS(description='Enthält die Reihenfolge und Namen zu den IDs der verwendeten E-Mail-Subvorlagevarianten, z. B. für "2-null-2-3" in nachricht_subvorlage_id_liste_txt könnte hier stehen "Obst-default-Obst-Gemüse".'),
email_domain_name STRING(100) OPTIONS(description='Domain der E-Mail-Adresse des Empfängers.'),
betriebssystem_name STRING(100) OPTIONS(description='Betriebssystem des Mobilgeräts. Nur für Push-Benachrichtigungen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, nachricht_workflow_id, nachricht_vorlage_id, kommunikationskanal_id) NOT ENFORCED
)
OPTIONS(description='Diese Tabelle enthält Details zu den gesendeten/blockierenden Nachrichten innerhalb einer Kampagne. Sie dient als Kopftabelle für alle gesendeten/blockierenden Nachrichten.');