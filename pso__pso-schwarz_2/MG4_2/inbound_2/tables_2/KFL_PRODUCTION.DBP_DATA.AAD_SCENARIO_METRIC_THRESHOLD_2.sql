create or replace TABLE KFL_PRODUCTION.DBP_DATA.AAD_SCENARIO_METRIC_THRESHOLD_2 (
	SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the Scenario',
	SCENARIO_METRIC_ID NUMBER(38,0) NOT NULL COMMENT 'Unique identifier of the metric that is monitored in fraud detection scenarios',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH - ein Mandant_2 pro Land.',
	REGION_ID NUMBER(38,0) NOT NULL COMMENT 'Region_2 eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region_2 gebildet',
	SCENARIO_METRIC_THRESHOLD_MIN_VAL NUMBER(18,4) COMMENT 'The minimum value of the metric at which we will consider there is a suspicious behaviour in this scenario',
	SCENARIO_METRIC_THRESHOLD_MAX_VAL NUMBER(18,4) COMMENT 'The maximum value of the metric at which we will consider there is a suspicious behaviour in this scenario',
	SCENARIO_METRIC_THRESHOLD_INIT_VAL NUMBER(18,4) COMMENT 'The current scenario threshold value, This is used for calculations',
	SCENARIO_METRIC_UNIT_ID NUMBER(38,0) COMMENT 'Describes the scenario metric threshold unit_2, e.g. 1=  euro, 2 =days, 3 = hits',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AAD_SCENARIO_METRIC_THRESHOLD primary key (SCENARIO_ID, SCENARIO_METRIC_ID, MANDANT_ID, REGION_ID)
)COMMENT='Contains metrics that we monitor for suspicious values in each fraud detection scenario.'
;