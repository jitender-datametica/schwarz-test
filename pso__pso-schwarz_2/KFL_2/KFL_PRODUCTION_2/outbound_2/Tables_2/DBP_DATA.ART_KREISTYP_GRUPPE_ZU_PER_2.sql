--==============================================================
-- Table: art_kreistyp_gruppe_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_kreistyp_gruppe_zu_per_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_kreistyp_gruppe_zu_per_2 (
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2 - Id'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode'),
kreistyp_gruppe_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Region_2 / Gruppierung Kreistypen'),
kreistyp_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kreistyp'),
dat_bis DATE NOT NULL OPTIONS(description='Endedatum der Gültigkeit, bei aktuellen Sätzen = 31.12.9999'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, dat_von) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Zeitabhängige Zuordnung der Artikel_2 zu Kreistyp und Kreistypgruppe');