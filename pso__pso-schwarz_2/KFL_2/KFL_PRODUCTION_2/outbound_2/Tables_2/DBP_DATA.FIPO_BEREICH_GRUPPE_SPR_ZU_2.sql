--==============================================================
-- Table: fipo_bereich_gruppe_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_bereich_gruppe_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_bereich_gruppe_spr_zu_2 (
fipo_bereich_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID der FIPO-Bereichsgruppe aus dem Quellfeld bgr_id.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
fipo_bereich_gruppe_bez STRING(60) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung der Bereichsgruppe'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_bereich_gruppe_id, spr_id) NOT ENFORCED
) OPTIONS(description='FIPO - Sprachabhängige Bezeichnungen der FIPO-Bereichsgruppen');