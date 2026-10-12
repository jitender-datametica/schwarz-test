--==============================================================
-- Table: l_food_nonfood_kategorie
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_food_nonfood_kategorie
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 13:32:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_food_nonfood_kategorie (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
food_nonfood_kategorie_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Food / Non Food Kategorie. '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, food_nonfood_kategorie_id) NOT ENFORCED
) OPTIONS(description='Kategorisiert alle unteren Ebenen der Hierarchien in Food und Non Food Bereiche.');