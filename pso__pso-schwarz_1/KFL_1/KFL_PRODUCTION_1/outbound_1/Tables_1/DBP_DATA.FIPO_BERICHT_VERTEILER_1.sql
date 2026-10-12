--==============================================================
-- Table: fipo_bericht_verteiler_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_bericht_verteiler_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_bericht_verteiler_1 (
fipo_bericht_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID eines FIPO-Berichts aus bri_id'),
fipo_bericht_verteiler_id STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Hier ist hinterlegt, wer (welche Position, wi HL_1) den Bericht erhält. Aus dem Quellfeld value'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_bericht_id) NOT ENFORCED
) OPTIONS(description='FIPO - Verteilerinformation für Berichte aus der Quelltabelle berichte_verteiler');