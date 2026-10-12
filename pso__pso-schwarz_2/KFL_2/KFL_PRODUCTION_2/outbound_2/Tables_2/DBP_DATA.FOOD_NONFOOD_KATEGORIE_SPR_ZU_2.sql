--==============================================================
-- Table: food_nonfood_kategorie_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: food_nonfood_kategorie_spr_zu_2
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 13:36:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.food_nonfood_kategorie_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
food_nonfood_kategorie_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Food / Non Food Kategorie. '),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
food_nonfood_kategorie_bez STRING(50) OPTIONS(description='Bezeichnung der Food / Non Food Kategorie.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, food_nonfood_kategorie_id, spr_id) NOT ENFORCED
) OPTIONS(description='Bezeichnungen der Food / Non Food Katgorie in unterschiedlichen Sprachen.');