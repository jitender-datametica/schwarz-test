--==============================================================
-- Table: geschaeftsvorfall_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geschaeftsvorfall_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geschaeftsvorfall_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
geschaeftsvorfall_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige ID eines Geschäftsvorfalls aus gv_id, z.Bsp. 01'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.'),
geschaeftsvorfall_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Geschäftvorfalls aus gv_bez, z.Bsp. NATURALRABATT N FÜR M'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Sprachabhängige Bezeichnungen der Geschäftsvorfälle aus zbonus_sl');