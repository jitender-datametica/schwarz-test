--==============================================================
-- Table: aad_scenario_metric_unit_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_metric_unit_spr_zu_1
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:23:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_SCENARIO_METRIC_UNIT_SPR_ZU_1 (
   scenario_metric_unit_id             NUMBER(38,0)     NOT NULL COMMENT 'Unique identifier of the metric that is monitored in fraud detection scenarios',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
   scenario_metric_unit_descr          VARCHAR(255)     COMMENT 'Scenario´s metric unit_1 name in the corresponding language',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_SCENARIO_METRIC_UNIT_SPR_ZU PRIMARY KEY (scenario_metric_unit_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'Contains the description of the scenario metric units in the corresponding languages';
