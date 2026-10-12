--==============================================================
-- Table: kampagne_nachricht_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_nachricht_1
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KAMPAGNE_NACHRICHT_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH.',
   nachricht_workflow_id               VARCHAR(100)     NOT NULL COMMENT 'ID des Workflows, der die Interaktionen zum Kunde in einer Kampagne_1 verarbeitet.',
   nachricht_vorlage_id                VARCHAR(100)     NOT NULL COMMENT 'Eindeutige Kennung der verwendeten Nachrichtenvorlage.',
   kommunikationskanal_id              NUMBER(38,0)     NOT NULL COMMENT 'Kennung des Kommunikationskanals, über den die Nachricht versendet wurde, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.',
   kampagne_id                         VARCHAR(100)     NOT NULL COMMENT 'Eindeutige Kennung der Kampagne_1, innerhalb derer die personalisierte Nachricht gesendet wird.',
   kampagne_kunde_id                   VARCHAR(100)     NOT NULL DEFAULT '-1' COMMENT 'Eindeutige Kennung des Kunden, an den die Nachricht gesendet wurde. Nicht alle Quelltabellen enthalten diese Information und müssen aus anderen Quelltabellen gefüllt werden, daher bedeutet ''-1'', dass kein passender Kunde gefunden wurde.',
   nachricht_subvorlage_id_liste_txt   VARCHAR(1000)    COMMENT 'Enthält die Reihenfolge und IDs der verwendeten E-Mail-Subvorlagevarianten, z. B. "2-null-2-2", "2-3".',
   nachricht_subvorlage_name_liste_txt VARCHAR(4000)    COMMENT 'Enthält die Reihenfolge und Namen zu den IDs der verwendeten E-Mail-Subvorlagevarianten, z. B. für "2-null-2-3" in nachricht_subvorlage_id_liste_txt könnte hier stehen "Obst-default-Obst-Gemüse".',
   email_domain_name                   VARCHAR(100)     COMMENT 'Domain der E-Mail-Adresse des Empfängers.',
   betriebssystem_name                 VARCHAR(100)     COMMENT 'Betriebssystem des Mobilgeräts. Nur für Push-Benachrichtigungen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KAMPAGNE_NACHRICHT PRIMARY KEY (mandant_id, nachricht_workflow_id, nachricht_vorlage_id, kommunikationskanal_id) NOT ENFORCED
)  COMMENT = 'Diese Tabelle enthält Details zu den gesendeten/blockierenden Nachrichten innerhalb einer Kampagne. Sie dient als Kopftabelle für alle gesendeten/blockierenden Nachrichten.';
