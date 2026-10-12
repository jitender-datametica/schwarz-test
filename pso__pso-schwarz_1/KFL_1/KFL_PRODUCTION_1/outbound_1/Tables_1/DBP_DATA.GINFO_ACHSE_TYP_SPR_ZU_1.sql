--==============================================================
-- Table: ginfo_achse_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ginfo_achse_typ_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ginfo_achse_typ_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.'),
ginfo_achse_typ_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Angabe der Einheit des Achsenwertes. Z.Bsp lfm oder Stk'),
ginfo_achse_typ_bez STRING(50) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Achsentyps. Z.Bsp laufende Meter'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='IOS - Sprachabhängige Bezeichnung des Achsentyps');