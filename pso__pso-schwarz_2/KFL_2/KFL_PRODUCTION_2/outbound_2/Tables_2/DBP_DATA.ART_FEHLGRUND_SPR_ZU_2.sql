--==============================================================
-- Table: art_fehlgrund_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_fehlgrund_spr_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_fehlgrund_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_fehlgrund_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='eindeutige ID für den Fehlgrund eines Artikels'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
art_fehlgrund_bez STRING(80) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung für den Fehlgrund eines Artikels'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_fehlgrund_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS MK - Sprachabhängige Bezeichnung der Fehlgründe');