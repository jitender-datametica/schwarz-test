--==============================================================
-- Table: l_lagerbereichskennzeichen
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lagerbereichskennzeichen
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:08:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lagerbereichskennzeichen (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex'),
lagerbereichskennzeichen_id STRING(4) NOT NULL OPTIONS(description='Lagerbereichskennzeichen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lookup Lagerbereichskennzeichen (EWM)');