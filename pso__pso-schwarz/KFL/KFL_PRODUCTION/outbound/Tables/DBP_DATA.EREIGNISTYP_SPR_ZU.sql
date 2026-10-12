--==============================================================
-- Table: ereignistyp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ereignistyp_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ereignistyp_spr_zu (
ereignistyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ereignistyp ID. Ereignistypen sind lokale Feiertage, automatisch generierte Feiertage etc.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
ereignistyp_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Ereignistyp Bezeichnung, z.Bsp "Lokale Feiertage"'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ereignistyp_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='VIS - Bezeichnung eines Ereignistyps');