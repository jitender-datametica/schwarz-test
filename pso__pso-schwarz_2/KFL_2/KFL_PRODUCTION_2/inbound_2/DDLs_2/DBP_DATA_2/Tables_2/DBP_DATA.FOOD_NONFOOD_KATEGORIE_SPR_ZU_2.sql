--==============================================================
-- Table: food_nonfood_kategorie_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: food_nonfood_kategorie_spr_zu_2
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 13:36:09
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FOOD_NONFOOD_KATEGORIE_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH.',
   food_nonfood_kategorie_id           NUMBER(38,0)     NOT NULL COMMENT 'ID der Food / Non Food Kategorie. ',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   food_nonfood_kategorie_bez          VARCHAR(50)      COMMENT 'Bezeichnung der Food / Non Food Kategorie.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FOOD_NONFOOD_KATEGORIE_SPR_ZU PRIMARY KEY (mandant_id, food_nonfood_kategorie_id, spr_id) NOT ENFORCED
)  COMMENT = 'Bezeichnungen der Food / Non Food Katgorie in unterschiedlichen Sprachen.';
