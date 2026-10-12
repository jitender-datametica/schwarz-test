--==============================================================
-- Table: griffzone_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: griffzone_typ_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.griffzone_typ_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
griffzone_typ_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Gruppierungsmekmal über Griffzonen.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
griffzone_typ_bez STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung für den Griffzonen Typ'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP408_LVS - Hier sind die Bezeichnungen der Griffzonentypen hinterlegt');