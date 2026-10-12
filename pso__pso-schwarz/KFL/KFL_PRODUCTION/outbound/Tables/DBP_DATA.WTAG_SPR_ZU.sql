--==============================================================
-- Table: wtag_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wtag_spr_zu
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:32:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wtag_spr_zu (
wtag_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wochentag ID, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
wtag_bez STRING(20) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Wochentags in den DWH-Sprachen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wtag_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP1_MIS - Bezeichnung der Wochentage in den DWH-Sprachen');