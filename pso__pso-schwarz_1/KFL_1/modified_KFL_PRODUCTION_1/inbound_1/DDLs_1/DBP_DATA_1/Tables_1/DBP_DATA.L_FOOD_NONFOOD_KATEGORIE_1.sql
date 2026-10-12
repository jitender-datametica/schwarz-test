--==============================================================
-- Table: l_food_nonfood_kategorie_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_food_nonfood_kategorie_1
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 13:32:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_FOOD_NONFOOD_KATEGORIE_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   food_nonfood_kategorie_id           INTEGER     NOT NULL COMMENT 'ID der Food / Non Food Kategorie. ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_FOOD_NONFOOD_KATEGORIE PRIMARY KEY (mandant_id, food_nonfood_kategorie_id) NOT ENFORCED
)  COMMENT = 'Kategorisiert alle unteren Ebenen der Hierarchien in Food und Non Food Bereiche.';
