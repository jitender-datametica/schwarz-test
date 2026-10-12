--==============================================================
-- Table: immo_rolle_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_rolle_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_rolle_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
rolle_kz STRING(7) COLLATE 'und:ci' NOT NULL OPTIONS(description='Geschäftspartner: Rolle'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
rolle_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Rollenbezeichnung Geschäftspartner'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='IMMO - Sprachabhängige Bezeichungen für die Mitarbeiterrolle - SAP REFX - TB003T');