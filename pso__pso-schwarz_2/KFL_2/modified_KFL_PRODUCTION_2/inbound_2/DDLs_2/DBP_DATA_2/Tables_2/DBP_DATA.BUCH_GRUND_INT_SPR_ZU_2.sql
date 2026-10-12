--==============================================================
-- Table: buch_grund_int_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: buch_grund_int_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BUCH_GRUND_INT_SPR_ZU_2 (
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   buch_grund_int_id                   VARCHAR(3)       NOT NULL COMMENT 'Eindeutiger Schluessel fuer die internen Buchungsgründe der Rechnungen auf Kopf- und Positionsebene.',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.',
   buch_grund_int_bez                  VARCHAR(40)      COMMENT 'Sprachabhängige Kurzbezeichnungen der internen Buchungsgründe.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BUCH_GRUND_INT_SPR_ZU PRIMARY KEY (system_id, mandant_id, buch_grund_int_id, spr_id) NOT ENFORCED
)  COMMENT = 'RPW - Diese Tabelle enthält die sprachabhängigen Kurzbezeichnungen für die internen Buchungsgründe. Für jede DWH Sprache = 1 wird ein Eintrag angelegt.';

