--==============================================================
-- Table: flw_kalk_plan_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_plan_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kalk_plan_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
plan_kalk_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID der Plankalkulation aus clpnr'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
plan_kalk_bez STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Plankalkulation'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, plan_kalk_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnungen zur Planwertkalkulation aus clpkt');