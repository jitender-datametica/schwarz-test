--==============================================================
-- Table: aad_scenario_metric_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_metric_spr_zu
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:27:31
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_SCENARIO_METRIC_SPR_ZU (
   scenario_id                         INTEGER     NOT NULL COMMENT 'Unique Identifier of the Scenario',
   scenario_metric_id                  INTEGER     NOT NULL COMMENT 'Unique identifier of the metric that is monitored in fraud detection scenarios',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land.',
   scenario_metric_descr               VARCHAR(255)     COMMENT 'Scenario´s metric name in the corresponding language',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_SCENARIO_METRIC_SPR_ZU PRIMARY KEY (scenario_id, scenario_metric_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'Contains the description of the scenario metrics in the corresponding languages';
