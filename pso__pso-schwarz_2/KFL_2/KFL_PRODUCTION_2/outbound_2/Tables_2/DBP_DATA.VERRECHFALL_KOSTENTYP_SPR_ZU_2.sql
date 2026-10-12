--==============================================================
-- Table: verrechfall_kostentyp_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: verrechfall_kostentyp_spr_zu_2
   generated from Powerdesigner on Donnerstag, 22. April 2021 10:57:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.verrechfall_kostentyp_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
verrechfall_kostentyp_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Typ: (F)ix oder (V)ariabel'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprach-ID'),
verrechfall_kostentyp_bez STRING(50) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kostentyp Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Kostentyp Bezeichnung');