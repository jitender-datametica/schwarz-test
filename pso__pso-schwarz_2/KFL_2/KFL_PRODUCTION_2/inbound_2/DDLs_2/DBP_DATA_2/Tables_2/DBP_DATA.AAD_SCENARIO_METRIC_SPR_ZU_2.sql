--==============================================================
-- Table: aad_scenario_metric_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_metric_spr_zu_2
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:27:31
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_SCENARIO_METRIC_SPR_ZU_2 (
   scenario_id                         NUMBER(38,0)     NOT NULL COMMENT 'Unique Identifier of the Scenario',
   scenario_metric_id                  NUMBER(38,0)     NOT NULL COMMENT 'Unique identifier of the metric that is monitored in fraud detection scenarios',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH - ein Mandant_2 pro Land.',
   scenario_metric_descr               VARCHAR(255)     COMMENT 'Scenario´s metric name in the corresponding language',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_SCENARIO_METRIC_SPR_ZU PRIMARY KEY (scenario_id, scenario_metric_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'Contains the description of the scenario metrics in the corresponding languages';
