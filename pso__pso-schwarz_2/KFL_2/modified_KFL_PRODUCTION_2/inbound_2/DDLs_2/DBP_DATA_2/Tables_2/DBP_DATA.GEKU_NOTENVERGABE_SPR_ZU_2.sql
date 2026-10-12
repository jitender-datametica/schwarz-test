--==============================================================
-- Table: geku_notenvergabe_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_notenvergabe_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_NOTENVERGABE_SPR_ZU_2 (
   geku_notenvergabe_durch_id          INTEGER     NOT NULL COMMENT 'ID der Notenvergeber',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   geku_notenvergabe_durch_bez         VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Notenvergebers, z.Bsp "MZK1 Überschrieben"',
   quelle_spr_id                       INTEGER     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_NOTENVERGABE_SPR_ZU PRIMARY KEY (geku_notenvergabe_durch_id, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen der Notenvergeber aus geku_text';
