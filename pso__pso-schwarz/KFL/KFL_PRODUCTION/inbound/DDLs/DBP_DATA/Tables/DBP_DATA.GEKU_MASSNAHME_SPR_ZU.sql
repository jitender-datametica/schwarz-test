--==============================================================
-- Table: geku_massnahme_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_massnahme_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_MASSNAHME_SPR_ZU (
   geku_massnahme_uid                  NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID einer GeKu-Massnahme aus measure_uid',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   geku_massnahme_bez                  VARCHAR(250)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Massnahme aus code_name',
   quelle_spr_id                       NUMBER(38,0)     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_MASSNAHME_SPR_ZU PRIMARY KEY (geku_massnahme_uid, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Bezeichnung der Massnahmen aus s1_dwh_text_out';

