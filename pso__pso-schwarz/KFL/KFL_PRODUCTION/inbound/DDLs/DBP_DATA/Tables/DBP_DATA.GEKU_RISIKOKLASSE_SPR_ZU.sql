--==============================================================
-- Table: geku_risikoklasse_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_risikoklasse_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_RISIKOKLASSE_SPR_ZU (
   geku_risikoklasse_id                NUMBER(38,0)     NOT NULL COMMENT 'ID der Risikoklasse',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   geku_risikoklasse_bez               VARCHAR(255)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Risikoklasse (z.Bsp. Risikoklasse 1)',
   quelle_spr_id                       NUMBER(38,0)     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_RISIKOKLASSE_SPR_ZU PRIMARY KEY (geku_risikoklasse_id, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen der GEKU Risikoklasse';
