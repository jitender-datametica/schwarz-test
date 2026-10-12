--==============================================================
-- Table: buch_grund_int_gruppe_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: buch_grund_int_gruppe_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BUCH_GRUND_INT_GRUPPE_SPR_ZU (
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   buch_grund_int_gruppe_id            INTEGER     NOT NULL COMMENT 'Gruppierungsmerkmal über interne Buchungsgründe',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   buch_grund_int_gruppe_bez           VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Gruppierung über interne Buchungsgründe',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BUCH_GRUND_INT_GRUPPE_SPR_ZU PRIMARY KEY (system_id, mandant_id, buch_grund_int_gruppe_id, spr_id) NOT ENFORCED
)  COMMENT = 'RPW - DATA - Sprachtabhängige Bezeichnungen für die Gruppierung des internen Buchungsgrundes
             ';

