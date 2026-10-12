create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_RELATIONSHIP_1 cluster by (COUNTRY_ORG_CD)(
	CASH_REGISTER_EVENT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.',
	CASH_REGISTER_EVENT_REL_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The way one cash register event is related to another, return to sales_1 receipt (Geldrügabe zu Originalbon) ',
	REL_CASH_REGISTER_EVENT_SID NUMBER(38,0) NOT NULL COMMENT 'The child cash register event, which is part of the scenario like following receipt of show price or sale receipt of return',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the business country_1 for which the related country_1 organization is responsible, e.g. cash_register_event_sid. (The business country_1 is not identical to a political country.)',
	BUS_DT DATE NOT NULL COMMENT 'The business date on which the retail event is counted.',
	REL_BUS_DT DATE NOT NULL COMMENT 'The business date on which the retail event is counted.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CASH_REGISTER_EVENT_RELATIONSHIP primary key (CASH_REGISTER_EVENT_SID, CASH_REGISTER_EVENT_REL_TYPE_CD, REL_CASH_REGISTER_EVENT_SID)
)COMMENT='The table lists the related cash register events of a main cash register event which is identified by a scenario e.g. return main scenario and its relevant sale receipt '
;