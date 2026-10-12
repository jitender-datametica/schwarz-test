--==============================================================
-- Table: aad_scenario_metric_threshold_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_metric_threshold_1
   generated from Powerdesigner on Montag, 12. Juni 2023 07:54:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_SCENARIO_METRIC_THRESHOLD_1 (
   scenario_id                         NUMBER(38,0)     NOT NULL COMMENT 'Unique Identifier of the Scenario',
   scenario_metric_id                  NUMBER(38,0)     NOT NULL COMMENT 'Unique identifier of the metric that is monitored in fraud detection scenarios',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
   region_id                           NUMBER(38,0)     NOT NULL COMMENT 'Region_1 eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region_1 gebildet',
   scenario_metric_threshold_min_val   NUMBER(18,4)     COMMENT 'The minimum value of the metric at which we will consider there is a suspicious behaviour in this scenario',
   scenario_metric_threshold_max_val   NUMBER(18,4)     COMMENT 'The maximum value of the metric at which we will consider there is a suspicious behaviour in this scenario',
   scenario_metric_threshold_init_val  NUMBER(18,4)     COMMENT 'The current scenario threshold value, This is used for calculations',
   scenario_metric_unit_id             NUMBER(38,0)     COMMENT 'Describes the scenario metric threshold unit_1, e.g. 1=  euro, 2 =days, 3 = hits',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_SCENARIO_METRIC_THRESHOLD PRIMARY KEY (scenario_id, scenario_metric_id, mandant_id, region_id) NOT ENFORCED
)  COMMENT = 'Contains metrics that we monitor for suspicious values in each fraud detection scenario.';
