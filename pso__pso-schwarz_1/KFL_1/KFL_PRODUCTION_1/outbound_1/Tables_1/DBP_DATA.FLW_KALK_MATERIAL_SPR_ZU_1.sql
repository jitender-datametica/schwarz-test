--==============================================================
-- Table: flw_kalk_material_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_material_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kalk_material_spr_zu_1 (
materialwert_kalk_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID zur Materialwertkalkulation aus clcnr'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
material_kalk_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Materialwertkalkulation aus txt40'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (materialwert_kalk_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnungen zur Materialwertkalkulation aus clckt');