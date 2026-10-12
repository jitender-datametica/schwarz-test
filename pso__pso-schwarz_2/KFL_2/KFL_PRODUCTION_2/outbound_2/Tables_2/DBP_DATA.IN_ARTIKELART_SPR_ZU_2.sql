--==============================================================
-- Table: in_artikelart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_artikelart_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_artikelart_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
artikelart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Ordnet das Material einer Gruppe_2 zu. Z.Bsp. HAWA, ZERL. Quelle ist mara.mtart'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache im DWH'),
artikelart_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='BIS - Sprachabhängige Bezeichnungen der Artikelarten aus dem Industriesystem, Quelle ist t134t');