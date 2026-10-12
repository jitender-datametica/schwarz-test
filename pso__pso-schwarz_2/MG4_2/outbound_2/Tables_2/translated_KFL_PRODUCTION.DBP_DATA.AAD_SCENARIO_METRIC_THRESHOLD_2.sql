CREATE OR REPLACE TABLE kfl_production_dbp_data.aad_scenario_metric_threshold_2 (
scenario_id INTEGER NOT NULL OPTIONS(description='Unique Identifier of the Scenario'),
scenario_metric_id INTEGER NOT NULL
OPTIONS(description='Unique identifier of the metric that is monitored in fraud detection scenarios'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land.'),
region_id INTEGER NOT NULL
OPTIONS(description='Region_2 eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region_2 gebildet'),
scenario_metric_threshold_min_val NUMERIC(18,4)
OPTIONS(description='The minimum value of the metric at which we will consider there is a suspicious behaviour in this scenario'),
scenario_metric_threshold_max_val NUMERIC(18,4)
OPTIONS(description='The maximum value of the metric at which we will consider there is a suspicious behaviour in this scenario'),
scenario_metric_threshold_init_val NUMERIC(18,4)
OPTIONS(description='The current scenario threshold value, This is used for calculations'),
scenario_metric_unit_id INTEGER
OPTIONS(description='Describes the scenario metric threshold unit_2, e.g. 1=  euro, 2 =days, 3 = hits'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (scenario_id, scenario_metric_id, mandant_id, region_id) NOT ENFORCED
) OPTIONS(description='Contains metrics that we monitor for suspicious values in each fraud detection scenario.');