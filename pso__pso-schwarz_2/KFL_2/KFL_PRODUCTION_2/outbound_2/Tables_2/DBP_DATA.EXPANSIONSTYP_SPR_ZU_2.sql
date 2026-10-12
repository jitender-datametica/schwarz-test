--==============================================================
-- Table: expansionstyp_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: expansionstyp_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.expansionstyp_spr_zu_2 (
expansionstyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Expansionstyp legt den Typ der Expansionssicht fest  (z.B. 1 bedeutet Expansion für EIS auf Tagesebene, 2 dasselbe auf Wochenebene).'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
expansionstyp_bez STRING(50) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Expansionstyps'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (expansionstyp_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS - Expansionstyp Sprachzuordnung');