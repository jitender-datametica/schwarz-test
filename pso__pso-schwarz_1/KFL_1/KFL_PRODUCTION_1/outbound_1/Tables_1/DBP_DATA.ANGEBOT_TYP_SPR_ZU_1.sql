--==============================================================
-- Table: angebot_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot_typ_spr_zu_1
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:48:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.angebot_typ_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
angebot_typ_cd STRING(10) NOT NULL OPTIONS(description='Alphanumerischer Code des Angebotstyps'),
angebot_typ_bez STRING(200) NOT NULL OPTIONS(description='Sprachabhängige Bezeichnung des Angebotstyps.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, angebot_typ_cd) NOT ENFORCED
) OPTIONS(description='Tabelle für sprachabhängige Bezeichnungen der Angebotstypen.');