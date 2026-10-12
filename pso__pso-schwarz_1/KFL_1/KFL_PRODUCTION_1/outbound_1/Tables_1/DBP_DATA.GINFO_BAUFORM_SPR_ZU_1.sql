--==============================================================
-- Table: ginfo_bauform_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ginfo_bauform_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ginfo_bauform_spr_zu_1 (
ginfo_bauform_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='enthält Werte von 0 bis 4'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.'),
ginfo_bauform_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Bauform, z. Bsp Tiefgarage'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ginfo_bauform_id, spr_id) NOT ENFORCED
) OPTIONS(description='IOS - sprachabhängige Bezeichnungen der Bauformen aus dem System GINFO');