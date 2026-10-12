--==============================================================
-- Table: ginfo_bauform_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ginfo_bauform_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GINFO_BAUFORM_SPR_ZU_2 (
   ginfo_bauform_id                    INTEGER     NOT NULL COMMENT 'enthält Werte von 0 bis 4',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.',
   ginfo_bauform_bez                   VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Bauform, z. Bsp Tiefgarage',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GINFO_BAUFORM_SPR_ZU PRIMARY KEY (ginfo_bauform_id, spr_id) NOT ENFORCED
)  COMMENT = 'IOS - sprachabhängige Bezeichnungen der Bauformen aus dem System GINFO';
