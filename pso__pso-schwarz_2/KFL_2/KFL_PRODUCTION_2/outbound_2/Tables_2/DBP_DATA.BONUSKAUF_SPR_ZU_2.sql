--==============================================================
-- Table: bonuskauf_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bonuskauf_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:16 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bonuskauf_spr_zu_2 (
bonuskauf_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige ID einer Bonuskaufaktion z.Bsp. 700 aus bbynr'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
bonuskauf_bez STRING(20) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Bonuskaufs aus bontext, z.Bsp. 3 la pret de 2'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Sprachabhängige Bezeichnungen der Promotions aus zbonus_text');