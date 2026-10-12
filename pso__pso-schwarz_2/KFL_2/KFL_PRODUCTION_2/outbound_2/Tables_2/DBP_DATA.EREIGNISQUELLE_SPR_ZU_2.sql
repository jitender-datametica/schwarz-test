--==============================================================
-- Table: ereignisquelle_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ereignisquelle_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ereignisquelle_spr_zu_2 (
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer der Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ereignisquelle_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID der Rolle des Bearbeiters'),
ereignisquelle_bez STRING(30) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Rolle des Erzeugers des Satzes, z.Bsp card_activator'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, mandant_id, ereignisquelle_id) NOT ENFORCED
) OPTIONS(description='VIS - Bezeichnung der Ereignisquelle');