create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER_STATUS_TYPE (
	ORDER_PARAMETER_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The status of a order parameter if it is approved, requested or denied.',
	ORDER_PARAMETER_STATUS_SEQ NUMBER(38,0) NOT NULL,
	ORDER_PARAMETER_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'Textual describes of the lifecycle status',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FRAUD_DETECTION_ORDER_STATUS_TYPE primary key (ORDER_PARAMETER_STATUS_CD)
)COMMENT='This look-up table defines the status of the revision order'
;