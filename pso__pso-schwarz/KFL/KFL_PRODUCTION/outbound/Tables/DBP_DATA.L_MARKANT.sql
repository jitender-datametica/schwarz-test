--==============================================================
-- Table: l_markant
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_markant
   generated from Powerdesigner on Donnerstag, 16. September 2021 11:41:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_markant (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
markant_id STRING(2) NOT NULL OPTIONS(description='ID Markantabrechnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='AIS - Lookuptabelle für Markantabrechnung - manuelle Beladung');