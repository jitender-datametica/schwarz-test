--==============================================================
-- Table: fipo_standard_text_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_standard_text_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_standard_text_spr_zu (
fipo_standard_text_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID eines Standardtextes aus ste_id'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
fipo_standard_text STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Standardtext aus dem Quellfeld sti_text'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_standard_text_id, spr_id) NOT ENFORCED
) OPTIONS(description='FIPO - Sprachabhängige Bezeichnungen der FIPO-Standardtexte aus standardtexte_int');