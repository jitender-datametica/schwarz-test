--==============================================================
-- Table: beleg_alter_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: beleg_alter_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELEG_ALTER_SPR_ZU_1 (
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
   beleg_alter_id                      INTEGER     NOT NULL COMMENT 'Eindeutiger Schlüssel für die verschiedenen Kategorien des Alters eines Belegs.',
   beleg_alter_bez                     VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Kurzbezeichnung für die Kategorien des Belegalters. Für jede DWH Sprache = 1 wird ein Eintrag angelegt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELEG_ALTER_SPR_ZU PRIMARY KEY (system_id, mandant_id, spr_id, beleg_alter_id) NOT ENFORCED
)  COMMENT = 'RPW - Diese Tabelle enthält die sprachabhängigen Kurzbezeichnungen für die Kategorien des Belegalters. Für jede DWH Sprache = 1 wird ein Eintrag angelegt.';

