-- Table: bq_findung_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bq_findung_spr_zu_2
   generated from Powerdesigner on Sonntag, 4. Februar 2024 12:13:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bq_findung_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
bq_findung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache im DWH'),
bq_findung_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Sprachabhängige Bezeichnung des Ausstiegspunkts'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bq_findung_id, spr_id) NOT ENFORCED
)
OPTIONS(description='AIS - Sprachabhängige Bezeichnung der Ausstiegspunkte bei der Bezugsquellenfindung - initial versorgt');