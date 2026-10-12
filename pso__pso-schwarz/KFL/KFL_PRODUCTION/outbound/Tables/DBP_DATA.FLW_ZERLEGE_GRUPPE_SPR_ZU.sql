--==============================================================
-- Table: flw_zerlege_gruppe_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_zerlege_gruppe_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_zerlege_gruppe_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH. In der Regel länderbezogen'),
zerlege_gruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zerlegegruppe aus zgrup.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige Kennzeichnung der Sprache'),
zerlege_gruppe_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Zerlegegruppe aus txt40, z.Bsp. R-Bug'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, zerlege_gruppe_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnungen der Zerlege_Gruppen aus spmeat_tzgrpt');