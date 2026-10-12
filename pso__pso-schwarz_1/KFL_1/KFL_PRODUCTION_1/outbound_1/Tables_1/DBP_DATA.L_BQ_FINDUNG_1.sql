--==============================================================
-- Table: l_bq_findung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_bq_findung_1
   generated from Powerdesigner on Sonntag, 4. Februar 2024 12:09:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_bq_findung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
bq_findung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bq_findung_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle der Ausstiegspunkte bei der Bezugsquellenfindung - initial versorgt');