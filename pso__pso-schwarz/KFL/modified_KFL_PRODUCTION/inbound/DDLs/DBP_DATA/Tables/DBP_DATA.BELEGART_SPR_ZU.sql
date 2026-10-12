--==============================================================
-- Table: belegart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belegart_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELEGART_SPR_ZU (
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.',
   belegart_id                         VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Schluessel fuer die Belegarten bei den Eingangsrechnungen (z. B. Rechnung, Gutschrit, Bela, Rbela, usw.). Referenz zu der Tabelle l_belegart;',
   belegart_bez                        VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhaengige Bezeichnung fuer die Belegarten. Fuer jede DWH Sprache wird ein Eintrag angelegt. Detaultwert ist die deutsche Bezeichnung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELEGART_SPR_ZU PRIMARY KEY (system_id, mandant_id, spr_id, belegart_id) NOT ENFORCED
)  COMMENT = 'RPW - Sprachabhaengige Kurzbezeichnungen der Belegarten. Fuer jede DWH Sprache wird eine Eintrag angelegt. Standard ist die deutsche Bezeichnung. Quelle fuer diese Daten ist die SAP Tabelle T003T.';

