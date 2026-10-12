--==============================================================
-- Table: flw_einheiten_umrechnung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_einheiten_umrechnung
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_einheiten_umrechnung (
einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Internationalen Maßeinheit aus msehi'),
dimension_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dimension der Einheit. Nur Einheiten derselben Dimension können umgerechnet werden aus dimid'),
zaehler BIGNUMERIC(38,0) NOT NULL OPTIONS(description='zaehler aus zaehl'),
nenner BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nenner aus nennr'),
basis_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Die Basis-Einheit der Dimension. Bei der Länge z.Bsp Meter. Quelle ist t006d.mssie'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='FLW - Maßeinheiten International und deren Umrechnung aus t006 und t006d Fleischwerkssystem');