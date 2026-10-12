--==============================================================
-- Table: haus_kategorie_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: haus_kategorie_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:47 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HAUS_KATEGORIE_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   haus_kategorie_id                   VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Hauskategorie aus house_cat',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   haus_kategorie_bez                  VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Hauskategorie aus house_cat_txt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_HAUS_KATEGORIE_SPR_ZU PRIMARY KEY (mandant_id, haus_kategorie_id, spr_id) NOT ENFORCED
)  COMMENT = 'SHR - Sprachabhängige Bezeichnung der Hauskategorie aus zhrhousecat';
