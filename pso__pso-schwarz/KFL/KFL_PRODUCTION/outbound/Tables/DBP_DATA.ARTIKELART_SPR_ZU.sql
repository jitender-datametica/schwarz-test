--==============================================================
-- Table: artikelart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artikelart_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artikelart_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
artikelart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Die Artikelart ist ein SAP_internes Steuerungsfeld zur Gruppierung von Artikeln. Inhalt z.Bsp. HAWA, Z620                        '),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache            '),
artikelart_bez STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='sprachabhängige Bezeichnung der Artikelart, z.Bsp. Fahrradzubehoer, Gemuesekonserven'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP408_LVS - Sprachabhängige Bezeichnung der Artikelart');