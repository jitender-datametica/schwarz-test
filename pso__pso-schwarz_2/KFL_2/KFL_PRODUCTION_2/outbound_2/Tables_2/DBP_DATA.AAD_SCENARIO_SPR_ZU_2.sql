--==============================================================
-- Table: aad_scenario_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_spr_zu_2
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:33:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aad_scenario_spr_zu_2 (
scenario_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique Identifier of the Scenario'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land.'),
scenario_descr STRING(255) OPTIONS(description='Scenario´s name in the corresponding language'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (scenario_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description=' Contains the description of the scenario in the corresponding languages');