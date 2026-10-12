--==============================================================
-- Table: back_hinweis_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: back_hinweis_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.back_hinweis_spr_zu (
back_hinweis_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='eindeutige ID für den Back-Hinweis aus dem Quellfeld ID'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
back_hinweis_bez STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung für den Back-Hinweis aus dem Quellfeld bake_info, z.Bsp. "Tiefgekühlt backen"'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (back_hinweis_id, spr_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='VIS Backshop - Sprachabhängige Bezeichnungen der Back-Hinweise aus der SAP Z-Tabelle zek_bake_info');