--==============================================================
-- Table: l_verrechnungsart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_verrechnungsart
   generated from Powerdesigner on Donnerstag, 22. April 2021 11:00:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_verrechnungsart (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
verrechnungsart_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Verrechnung: (A)utomatisch oder (M)anuell'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lookup Verrechnungsart');