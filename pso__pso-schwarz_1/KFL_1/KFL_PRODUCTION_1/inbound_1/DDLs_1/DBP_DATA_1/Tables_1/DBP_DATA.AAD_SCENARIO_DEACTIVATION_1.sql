--==============================================================
-- Table: aad_scenario_deactivation_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_deactivation_1
   generated from Powerdesigner on Mittwoch, 31. Mai 2023 07:01:20
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_SCENARIO_DEACTIVATION_1 (
   scenario_id                         NUMBER(38,0)     NOT NULL COMMENT 'Unique Identifier of the Scenario',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
   dwh_created_tmsp                    TIMESTAMP_NTZ(9) COMMENT 'Auto generate by Insert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_SCENARIO_DEACTIVATION PRIMARY KEY (scenario_id, mandant_id) NOT ENFORCED
)  COMMENT = 'Contains information which AAD fraud scenarios are deactivated for which countries (mandant_id)';
