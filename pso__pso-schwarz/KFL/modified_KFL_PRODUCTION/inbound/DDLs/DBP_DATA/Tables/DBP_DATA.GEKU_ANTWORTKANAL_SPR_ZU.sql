--==============================================================
-- Table: geku_antwortkanal_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_antwortkanal_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_ANTWORTKANAL_SPR_ZU (
   geku_antwortkanal_id                INTEGER     NOT NULL COMMENT 'ID des Antwortkanals, z.Bsp. 100661 aus answer_channel_uid',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   geku_antwortkanal_bez               VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Antwortkanals, z.Bsp. E-Mail',
   quelle_spr_id                       INTEGER     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_ANTWORTKANAL_SPR_ZU PRIMARY KEY (geku_antwortkanal_id, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen der Antwortkanäle';

