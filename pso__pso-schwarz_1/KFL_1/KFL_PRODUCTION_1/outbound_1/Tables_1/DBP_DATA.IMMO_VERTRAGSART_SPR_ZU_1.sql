--==============================================================
-- Table: immo_vertragsart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_vertragsart_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_vertragsart_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
vertragsart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Vertragsart'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
vertragsart_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Bezeichnung der Vertragsart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, vertragsart_id, spr_id) NOT ENFORCED
) OPTIONS(description='IMMO - Sprachabhängige Bezeichnung der Art_1 des Vermietungsvertrags  - SAP REFX - TIV2F');