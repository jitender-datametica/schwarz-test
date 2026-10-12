--==============================================================
-- Table: angebot_status_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot_status_spr_zu_1
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:51:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.angebot_status_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
angebot_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Angebotsstatus'),
angebot_status_bez STRING(200) NOT NULL OPTIONS(description='Sprachabhängige Bezeichnung des Angebotsstatus.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, angebot_status_id) NOT ENFORCED
) OPTIONS(description='Tabelle für sprachabhängige Bezeichnungen des Angebotsstatus.');