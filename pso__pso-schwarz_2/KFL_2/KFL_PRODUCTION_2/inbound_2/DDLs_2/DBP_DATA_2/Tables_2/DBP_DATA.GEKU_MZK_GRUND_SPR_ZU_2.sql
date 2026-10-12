--==============================================================
-- Table: geku_mzk_grund_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_mzk_grund_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_MZK_GRUND_SPR_ZU_2 (
   geku_mzk_grund_uid                  NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige Id für den Meldezettel-Grund',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   geku_mzk_grund_bez                  VARCHAR(255)     COLLATE 'en-ci' COMMENT 'Bezeichnung des MZK-Grundes',
   quelle_spr_id                       NUMBER(38,0)     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_MZK_GRUND_SPR_ZU PRIMARY KEY (geku_mzk_grund_uid, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen der MZK - Gründe';
