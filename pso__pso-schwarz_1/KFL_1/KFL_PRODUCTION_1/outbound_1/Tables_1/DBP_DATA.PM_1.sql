--==============================================================
-- Table: pm_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: pm_1
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:27:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pm_1 (
pm_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Preismodul, Wert von 1 bis 10'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel'),
pm_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Preismodul Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pm_id, mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='Preismodul (bildet im DWH die Preiskategorie ab - es gibt 10 Preiskategorien)');