--==============================================================
-- Table: cpr_kategorie_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_kategorie_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_KATEGORIE_SPR_ZU_1 (
   cpr_kategorie_id                    VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Projektkategorie ID, z.Bsp. 1',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
   cpr_kategorie_bez                   VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Projektkategorie, z.Bsp Entwicklungsprojekt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_KATEGORIE_SPR_ZU PRIMARY KEY (cpr_kategorie_id, spr_id) NOT ENFORCED
)  COMMENT = 'IOS - Sprachabhängige Bezeichnung der Projektkategorie';

