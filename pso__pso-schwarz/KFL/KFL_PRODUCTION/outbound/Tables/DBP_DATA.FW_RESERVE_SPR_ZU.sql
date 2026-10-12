--==============================================================
-- Table: fw_reserve_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fw_reserve_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fw_reserve_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
fw_reserve_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID für die Kennzeichnung Artikel  Fleischwerk Reserve  aus dem Quellfeld zfwbestvor'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
fw_reserve_bez STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung für das Artikelkennzeichen Fleischwerk reserve  aus dem Quellfeld Text, z.Bsp. keine'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='FLW - Sprachabhängige Bezeichnungen der Fleischwerk Reserve Artikelkennzeichen aus der Retail Tabelle  zfwprbeste');