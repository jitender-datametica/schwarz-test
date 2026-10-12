--==============================================================
-- Table: kampagne_kampagne_nachricht_vorlage_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_kampagne_nachricht_vorlage_zu_2
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KAMPAGNE_KAMPAGNE_NACHRICHT_VORLAGE_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   kampagne_id                         VARCHAR(100)     NOT NULL COMMENT 'Eindeutige Kennung der Kampagne_2, innerhalb derer die personalisierte Nachricht gesendet wird.',
   nachricht_vorlage_id                VARCHAR(100)     NOT NULL COMMENT 'Vom Quellsystem generierte ID der Nachrichtenvorlage (GUID).',
   kommunikationskanal_id              INTEGER     NOT NULL COMMENT 'Kennung des Kommunikationskanals, für den die Nachrichtenvorlage bestimmt ist, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KAMPAGNE_KAMPAGNE_NACHRICHT_VORLAGE_ZU PRIMARY KEY (mandant_id, kampagne_id, nachricht_vorlage_id, kommunikationskanal_id) NOT ENFORCED
)  COMMENT = 'Zuordnung von Nachrichtenvorlagen zu Kampagnen. Darüber lässt sich sehen welche Vorlagen für welche Kampagnen verwendet werden.';
