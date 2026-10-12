--==============================================================
-- Table: back_aufbereitung_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: back_aufbereitung_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.back_aufbereitung_spr_zu (
back_aufbereitung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='eindeutige ID der Back-Aufbereitung aus dem Quellfeld ID, z.Bsp. 1'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
back_aufbereitung_bez STRING(255) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Aufbereitung aus dem Quellfeld bake_refining, z.Bsp. "Mit Salz bestreuen"'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (back_aufbereitung_id, spr_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='VIS Backshop - Sprachabhängige Bezeichnungen zur Back-Aufbereitung aus der SAP Z-Tabelle zek_bake_refin');