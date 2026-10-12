--==============================================================
-- Table: geku_mzk_thema_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_mzk_thema_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_MZK_THEMA_SPR_ZU_1 (
   geku_mzk_thema_uid                  NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID des MZK-Themas. Ein MZK-Thema fasst mehrere MZK-Gründe zusammen',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   geku_mzk_thema_bez                  VARCHAR(255)     COLLATE 'en-ci' COMMENT 'Bezeichnung des MZK-Themas',
   quelle_spr_id                       NUMBER(38,0)     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_MZK_THEMA_SPR_ZU PRIMARY KEY (geku_mzk_thema_uid, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen der MZK - Themen';
