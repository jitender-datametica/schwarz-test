--==============================================================
-- Table: hr_massnahme_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hr_massnahme_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hr_massnahme_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK - Mandant_2 im DWH'),
hr_massnahme_grund_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Massnahmegrund'),
hr_massnahme_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Massnahme, z.Bsp. A0'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
hr_massnahme_grund_bez STRING(30) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Mitarbeiter-Massnahme-Grundes'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='SHR - Sprachabhängige Bezeichnung der Personal-Massnahmen-Gründe');