--==============================================================
-- Table: immo_l_rolle
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_l_rolle
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_l_rolle (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
rolle_kz STRING(7) COLLATE 'und:ci' NOT NULL OPTIONS(description='Geschäftspartner: Rolle'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='IMMO - Mitarbeiterrolle - SAP REFX - TB003T');