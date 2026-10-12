--==============================================================
-- Table: aad_scenario
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario
   generated from Powerdesigner on Mittwoch, 10. Mai 2023 08:29:20
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_SCENARIO (
   scenario_id                         INTEGER     NOT NULL COMMENT 'Unique Identifier of the Scenario',
   scenario_grp_id                     INTEGER     NOT NULL COMMENT 'Unique Identifier of the Scenariogroup',
   dwh_created_tmsp                    TIMESTAMP_NTZ(9) COMMENT 'Auto generate by Insert',
   dwh_updated_tmsp                    TIMESTAMP_NTZ(9) COMMENT 'Auto generate by Update',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_SCENARIO PRIMARY KEY (scenario_id) NOT ENFORCED
)  COMMENT = ' Contains the scenario and scenariogroup mapping';
