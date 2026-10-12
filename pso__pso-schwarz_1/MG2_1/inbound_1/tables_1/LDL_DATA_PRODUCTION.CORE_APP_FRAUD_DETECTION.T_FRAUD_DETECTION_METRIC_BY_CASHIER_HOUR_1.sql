create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_METRIC_BY_CASHIER_HOUR_1 (
	STORE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the store where the related cash register event happened.',
	CASHIER_NR VARCHAR(20) NOT NULL COMMENT 'The number which identifies the cashier. (The number is unique for a given store and a day.)',
	BUS_DT DATE NOT NULL COMMENT 'The business date on which the retail event is counted.',
	HR NUMBER(38,0) NOT NULL COMMENT 'The hour of the day of which the metrics are calculated',
	METRIC_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of microstratey metric',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)',
	CURR_CD VARCHAR(3) COMMENT 'The currency code for the metric values',
	METRIC_VAL_1 NUMBER(38,5) NOT NULL COMMENT 'The first value to calculate defined by microstrategy metric',
	METRIC_VAL_2 NUMBER(38,5) COMMENT 'The second value to calculate defined by microstrategy metric',
	METRIC_VAL_3 NUMBER(38,5) COMMENT 'The third value to calculate defined by microstrategy metric',
	METRIC_VAL_4 NUMBER(38,5) COMMENT 'The fourth value to calculate defined by microstrategy metric',
	constraint PK_T_FRAUD_DETECTION_METRIC_BY_CASHIER_HOUR primary key (STORE_SID, CASHIER_NR, BUS_DT, METRIC_ID, HR)
)COMMENT='This table brings the values in a normalized form to calculate the metrics, which will be used for dynamic dashboard'
;