--==============================================================
-- Table: fipo_l_kriterium_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_kriterium_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_l_kriterium_1 (
fipo_kriterium_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='FIPO - Eindeutige ID eines FIPO Kriteriums aus der Quelltabelle kriterien'),
fipo_kriterium_typ STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Kriterientyp  - Jedes Kriterium in K-VISIT wird einem Kriterientyp zugeordnet'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_kriterium_id) NOT ENFORCED
) OPTIONS(description='FIPO - Lookuptabelle der FIPO-Kriterien');