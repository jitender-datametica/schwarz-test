--==============================================================
-- Table: buch_grund_ext_gruppe_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: buch_grund_ext_gruppe_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BUCH_GRUND_EXT_GRUPPE_ZU_2 (
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   buch_grund_ext_id                   VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Schluessel fuer die externe Buchungsgründe der Rechnungen auf Kopf- und Positionsebene.',
   buch_grund_ext_gruppe_id            INTEGER     NOT NULL COMMENT 'Gruppierungsmerkmal über externe Buchungsgründe',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BUCH_GRUND_EXT_GRUPPE_ZU PRIMARY KEY (system_id, mandant_id, buch_grund_ext_id, buch_grund_ext_gruppe_id) NOT ENFORCED
)  COMMENT = 'RPW - DATA - Zuordnung der externen Buchungsgründe zur Buchungsgrundgruppe
             ';

