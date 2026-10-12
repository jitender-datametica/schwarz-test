create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER_REASON_2 (
	ORDER_REASON_CD VARCHAR(20) NOT NULL COMMENT 'The revision reason code for an analysis, if it is for threshold definition or fraud analysis',
	ORDER_REASON_DESCR VARCHAR(250) NOT NULL COMMENT 'Textual description for the order reason',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FRAUD_DETECTION_ORDER_REASON primary key (ORDER_REASON_CD)
)COMMENT='Reason why the fraud detection was ordered.Reason (for example):Inter audit, rparameter defition'
;