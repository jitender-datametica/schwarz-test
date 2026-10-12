--==============================================================
-- Table: in_budget_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_budget_typ_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_budget_typ_spr_zu_2 (
in_budget_typ_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID eines Budgettyps'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'),
in_budget_typ_bez STRING(50) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung des Budgettyps'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id) NOT ENFORCED
) OPTIONS(description='IMS - Sprachabhängige Bezeichnungen der Budgetypen aus SAP Industrie zco_budg_type_t');