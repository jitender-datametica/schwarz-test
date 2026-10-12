--==============================================================
-- Table: belegklasse_gruppe_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belegklasse_gruppe_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELEGKLASSE_GRUPPE_SPR_ZU (
   belegklasse_gruppe_id               INTEGER     NOT NULL COMMENT 'ID der Belegklasse - Gruppe',
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   belegklasse_gruppe_bez              VARCHAR(40)      COLLATE 'en-ci' COMMENT 'sprachabhaengige Bezeichnung fuer die Belegklasse -Gruppe.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELEGKLASSE_GRUPPE_SPR_ZU PRIMARY KEY (belegklasse_gruppe_id, mandant_id, system_id, spr_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnung der Belegklassen Gruppierung';

