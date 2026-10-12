--==============================================================
-- Table: fipo_pruefpunkt_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_pruefpunkt_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_pruefpunkt_spr_zu_2 (
fipo_pruefpunkt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID eines Prüfpunkts aus ppu_id'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
fipo_pruefpunkt_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung eines Prüfpunkts aus dem Quellfeld ppi_pruefpunkt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_pruefpunkt_id, spr_id) NOT ENFORCED
) OPTIONS(description='FIPO - Sprachtabelle zu Prüfpunkt - Quelltabelle pruefpunkt_int');