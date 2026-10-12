--==============================================================
-- Table: kampagne_nachricht_aktion_detail_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_nachricht_aktion_detail_2
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KAMPAGNE_NACHRICHT_AKTION_DETAIL_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   nachricht_workflow_id               VARCHAR(100)     NOT NULL COMMENT 'ID des Workflows, der die Interaktionen zum Kunde in einer Kampagne_2 verarbeitet.',
   nachricht_vorlage_id                VARCHAR(100)     NOT NULL COMMENT 'Eindeutige Kennung der verwendeten Nachrichtenvorlage.',
   kommunikationskanal_id              INTEGER     NOT NULL COMMENT 'Kennung des Kommunikationskanals, über den die Nachricht versendet wurde, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.',
   datzeit_nachricht_aktion            TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitpunkt, an dem der Empfänger die Aktion_2 ausgeführt hat.',
   nachricht_aktion_typ_id             INTEGER     NOT NULL COMMENT 'ID, die die Art_2 der ausgeführten Aktion_2 angibt, z. B. 1 = Link geklickt, 2 = Geöffnet, 3 = Feedback Loop.',
   personalisierte_url_name            VARCHAR(1000)    NOT NULL COMMENT 'Bezeichnung des Hyperlinks, auf den der Empfänger geklickt hat.',
   personalisierte_url_txt             VARCHAR(1000)    NOT NULL COMMENT 'Personalisierte URL des Hyperlinks, auf den der Empfänger geklickt hat.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KAMPAGNE_NACHRICHT_AKTION_DETAIL PRIMARY KEY (mandant_id, nachricht_workflow_id, nachricht_vorlage_id, kommunikationskanal_id, datzeit_nachricht_aktion, nachricht_aktion_typ_id, personalisierte_url_name, personalisierte_url_txt) NOT ENFORCED
)  COMMENT = 'Diese Tabelle dient zur Erfassung von Details zu Nachrichtenaktionen. Derzeit enthält sie nur geklickte personalisierte URLs in Nachrichten.';
