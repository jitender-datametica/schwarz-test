--==============================================================
-- Table: verrechnungsart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: verrechnungsart_spr_zu_2
   generated from Powerdesigner on Donnerstag, 22. April 2021 11:03:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.verrechnungsart_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
verrechnungsart_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Verrechnung: (A)utomatisch oder (M)anuell'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprach-ID'),
verrechnungsart_bez STRING(50) COLLATE 'und:ci' NOT NULL OPTIONS(description='Verrechnungsart Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Verrechnungsart Bezeichnung');