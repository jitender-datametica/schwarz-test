--==============================================================
-- Table: geku_prioritaet_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_prioritaet_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_PRIORITAET_SPR_ZU (
   geku_prioritaet_id                  INTEGER     NOT NULL COMMENT 'Eindeutige ID der Priorität., z.Bsp. 1148722 aus priority_uid',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   geku_prioritaet_bez                 VARCHAR(255)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Priorität, z.Bsp. Personenschaden aus text_out',
   quelle_spr_id                       INTEGER     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_PRIORITAET_SPR_ZU PRIMARY KEY (geku_prioritaet_id, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen der GEKU Priorität';
