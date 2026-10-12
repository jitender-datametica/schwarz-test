--==============================================================
-- Table: aad_scenario_metric_unit_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_metric_unit_spr_zu
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:23:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aad_scenario_metric_unit_spr_zu (
scenario_metric_unit_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier of the metric that is monitored in fraud detection scenarios'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land.'),
scenario_metric_unit_descr STRING(255) OPTIONS(description='Scenario´s metric unit name in the corresponding language'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (scenario_metric_unit_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='Contains the description of the scenario metric units in the corresponding languages');