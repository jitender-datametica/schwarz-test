--==============================================================
-- Table: flw_auftrag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_auftrag
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_auftrag (
auftrag_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Auftragsnummer aus aufnr'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH. In der Regel länderbezogen'),
auftragsart_id STRING(4) COLLATE 'und:ci' OPTIONS(description='ID der Auftragsart aus auart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Auftragsstammdaten aus aufk');