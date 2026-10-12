--==============================================================
-- Table: l_werbebereich_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbebereich_1
   generated from Powerdesigner on Freitag, 11. Oktober 2024 15:09:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_werbebereich_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
werbebereich_cd STRING(100) NOT NULL OPTIONS(description='Code des Werbebereichs.'),
werbebereich_bez STRING(100) OPTIONS(description='Werbebereich - Bezeichnung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werbebereich_cd) NOT ENFORCED
) OPTIONS(description='Bündelung von mehreren werbeteams zu einem Bereich.');