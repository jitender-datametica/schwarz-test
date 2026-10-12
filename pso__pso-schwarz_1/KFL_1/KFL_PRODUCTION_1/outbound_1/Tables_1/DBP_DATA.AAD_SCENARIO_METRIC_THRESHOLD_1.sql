--==============================================================
-- Table: aad_scenario_metric_threshold_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_metric_threshold_1
   generated from Powerdesigner on Montag, 12. Juni 2023 07:54:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aad_scenario_metric_threshold_1 (
scenario_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique Identifier of the Scenario'),
scenario_metric_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier of the metric that is monitored in fraud detection scenarios'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land.'),
region_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Region_1 eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region_1 gebildet'),
scenario_metric_threshold_min_val NUMERIC(18,4)
OPTIONS(description='The minimum value of the metric at which we will consider there is a suspicious behaviour in this scenario'),
scenario_metric_threshold_max_val NUMERIC(18,4)
OPTIONS(description='The maximum value of the metric at which we will consider there is a suspicious behaviour in this scenario'),
scenario_metric_threshold_init_val NUMERIC(18,4)
OPTIONS(description='The current scenario threshold value, This is used for calculations'),
scenario_metric_unit_id BIGNUMERIC(38,0)
OPTIONS(description='Describes the scenario metric threshold unit_1, e.g. 1=  euro, 2 =days, 3 = hits'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (scenario_id, scenario_metric_id, mandant_id, region_id) NOT ENFORCED
) OPTIONS(description='Contains metrics that we monitor for suspicious values in each fraud detection scenario.');