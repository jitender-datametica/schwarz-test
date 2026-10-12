--==============================================================
-- Table: l_mgg_gruppe
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_mgg_gruppe
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 13:50:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_mgg_gruppe (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
mgg_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der MGG (Mengengerüst) Gruppierung. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.'),
mgg_abteilung_id BIGNUMERIC(38,0)
OPTIONS(description='ID der MGG (Mengengerüst) Abteilung. Fasst mehrere MGG Gruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, mgg_gruppe_id) NOT ENFORCED
)
OPTIONS(description='Wird zur Ermittlung Abweichungsgrad MGG benötigt. Ebene der Flächenhierarchie in VIS SOK. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Gruppe zusammen. Wird manuell in VIS SOK gepflegt.');