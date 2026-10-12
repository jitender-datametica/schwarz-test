--==============================================================
-- Table: belegklasse_gruppe_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belegklasse_gruppe_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELEGKLASSE_GRUPPE_SPR_ZU_1 (
   belegklasse_gruppe_id               INTEGER     NOT NULL COMMENT 'ID der Belegklasse - Gruppe_1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   belegklasse_gruppe_bez              VARCHAR(40)      COLLATE 'en-ci' COMMENT 'sprachabhaengige Bezeichnung fuer die Belegklasse -Gruppe.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELEGKLASSE_GRUPPE_SPR_ZU PRIMARY KEY (belegklasse_gruppe_id, mandant_id, system_id, spr_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnung der Belegklassen Gruppierung';

