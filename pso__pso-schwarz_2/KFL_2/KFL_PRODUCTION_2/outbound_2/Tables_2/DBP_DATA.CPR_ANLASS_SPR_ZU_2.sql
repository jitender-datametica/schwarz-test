--==============================================================
-- Table: cpr_anlass_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_anlass_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cpr_anlass_spr_zu_2 (
projekt_anlass_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Projektanlasses oder Veranlassers, z.Bsp. Vertrieb. Quelle ist cpr_cause'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.'),
projekt_anlass_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Beschreibung des Projektanlasses, z.Bsp. Auftrag von Vertrieb. Quelle ist txtmd'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id) NOT ENFORCED
) OPTIONS(description='IOS - sprachabhängige Bezeichnung des Projektanlasses aus der Quelltabelle cause');