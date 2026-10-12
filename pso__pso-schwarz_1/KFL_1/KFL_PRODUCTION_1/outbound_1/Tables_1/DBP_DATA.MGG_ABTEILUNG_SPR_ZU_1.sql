--==============================================================
-- Table: mgg_abteilung_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mgg_abteilung_spr_zu_1
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 14:41:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mgg_abteilung_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
mgg_abteilung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der MGG (Mengengerüst) Gruppierung. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
mgg_abteilung_bez STRING(100) OPTIONS(description='Bezeichnung der MGG Abteilung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, mgg_abteilung_id, spr_id) NOT ENFORCED
) OPTIONS(description='Bezeichnungen der MGG Abteilung in unterschiedliche Sprachen.');