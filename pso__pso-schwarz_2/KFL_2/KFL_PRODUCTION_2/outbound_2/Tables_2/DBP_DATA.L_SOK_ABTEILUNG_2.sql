--==============================================================
-- Table: l_sok_abteilung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_sok_abteilung_2
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 12:12:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_sok_abteilung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
sok_abteilung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der SOK Abteilung. Fasst die SOK Fima Bausteine zu einer übergeordneten Hierarchie-Ebene zusammen.'),
food_nonfood_kategorie_id BIGNUMERIC(38,0) OPTIONS(description='ID der Food / Non Food Kategorie. '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, sok_abteilung_id) NOT ENFORCED
)
OPTIONS(description='Ebene der SOK Berichtsstruktur. Die SOK Abteilung fasst die SOK FIMA Bausteine zu einer übergeordneten Hierarchie Ebene für die entscheidungsrelevante Bereiche Ultra-Frische, Food und Non-Food zusammen. Wird manuell in VIS SOK gepflegt.');