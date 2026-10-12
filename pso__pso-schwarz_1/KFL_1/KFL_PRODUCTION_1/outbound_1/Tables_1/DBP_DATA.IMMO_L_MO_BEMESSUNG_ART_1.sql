--==============================================================
-- Table: immo_l_mo_bemessung_art_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_l_mo_bemessung_art_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_l_mo_bemessung_art_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
bemessung_art_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bemessungsart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='IMMO - Lookup Tabelle für die Bemessungsart (Mietobjekt) - SAP REFX - TIVBDMEAST');