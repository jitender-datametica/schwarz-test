--==============================================================
-- Table: aad_scenario_grp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_grp_spr_zu
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:34:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aad_scenario_grp_spr_zu (
scenario_grp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique Identifier of the Scenariogroup'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land.'),
scenario_grp_descr STRING(255) OPTIONS(description='Scenariogroup´s name in the corresponding language'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (scenario_grp_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='Scenariogroup´s name in the corresponding language');