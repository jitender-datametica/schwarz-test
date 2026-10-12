--==============================================================
-- Table: fipo_kriterium_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_kriterium_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_kriterium_spr_zu (
fipo_kriterium_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='FIPO - Eindeutige ID eines FIPO Kriteriums aus der Quelltabelle kriterien'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
fipo_kriterium_bez STRING(255) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung aus der Quellspalte kin_kriterium'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_kriterium_id, spr_id) NOT ENFORCED
) OPTIONS(description='FIPO - Sprachabhängige Bezeichnungen der FIPO-Kriterien');