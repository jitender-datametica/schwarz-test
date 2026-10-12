--==============================================================
-- Table: flw_charge_objekt_merkmal_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_charge_objekt_merkmal_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_charge_objekt_merkmal_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
objekt_nummer_id STRING(50) COLLATE 'und:ci' NOT NULL OPTIONS(description='Objektnummer aus SAP Quelle AUSP.OBJEK'),
int_merkmal_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Internes Merkmal aus SAP Quelle AUSP.ATINN'),
dat_wert DATE
OPTIONS(description='Datumswert aus SAP Quelle AUSP.ATFLV, zB Produktionsdatum oder Verpackungsdatum, abhängig von int_merkmal_id'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Ausprägungswerte der Sachmerkmale aus SAP P21 AUSP_1');