--==============================================================
-- Table: abschriftart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftart_spr_zu
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abschriftart_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
abschriftart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Abschriftenart  -  numerisch'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache ID'),
abschriftart_bez STRING(80) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Abschriftenart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, abschriftart_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Sprachabhängige Bezeichnungen der Abschriftenschlüssel');