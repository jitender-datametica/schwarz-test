--==============================================================
-- Table: geku_abschlussgrund_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_abschlussgrund_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_ABSCHLUSSGRUND_SPR_ZU_2 (
   abschlussgrund_id                   NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID des Abschlussgrunds aus finish_reason_uid',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   abschlussgrund_bez                  VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Abschlussgrunds, z.Bsp. SPAM',
   quelle_spr_id                       NUMBER(38,0)     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_ABSCHLUSSGRUND_SPR_ZU PRIMARY KEY (abschlussgrund_id, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen der Abschlussgründe';

