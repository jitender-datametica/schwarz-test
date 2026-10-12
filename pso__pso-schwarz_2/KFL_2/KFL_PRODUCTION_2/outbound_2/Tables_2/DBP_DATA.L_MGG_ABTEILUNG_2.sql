--==============================================================
-- Table: l_mgg_abteilung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_mgg_abteilung_2
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 14:36:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_mgg_abteilung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
mgg_abteilung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der MGG (Mengengerüst) Gruppierung. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.'),
food_nonfood_kategorie_id BIGNUMERIC(38,0) OPTIONS(description='ID der Food / Non Food Kategorie. '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, mgg_abteilung_id) NOT ENFORCED
)
OPTIONS(description='Wird zur Ermittlung Abweichungsgrad MGG (Mengengerüst) benötigt. Ebene der Flächenhierarchie in VIS SOK. Fasst mehrere MGG Gruppen zu einer übergeordneten Hierarchie-Ebene zusammen. Wird manuell in VIS SOK gepflegt.');