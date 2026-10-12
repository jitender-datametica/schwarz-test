create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_FACT_REAL_ESTATE_EVENT_1 (
	BUS_DT DATE NOT NULL COMMENT 'The business date on which the event occurred.',
	REAL_ESTATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
	REAL_ESTATE_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the subtype discriminator for real estate objects. It distinguishes between store buildings, warehouse buildings and other kinds of real estate objects.',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the business country_1 to which the real estate object belongs. (The business country_1 is not identical to a political country.)',
	REPORTING_COUNTRY_CD VARCHAR(20) NOT NULL COMMENT 'The code which identifies the reporting country_1 to which the real estate object belongs.',
	REAL_ESTATE_EVENT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of event which changes the status_1 of a real estate object, such as opening, closing or relocation.',
	REAL_ESTATE_EVENT_REASON_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the reason why the status_1 of a real estate object has changed. E.g. a store was closed because of lack of expansion options.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FACT_REAL_ESTATE_EVENT primary key (BUS_DT, REAL_ESTATE_SID, REAL_ESTATE_EVENT_TYPE_CD)
)COMMENT='This transactional fact tracks the events which change the status_1 of real estate objects, such as stores. This includes openings, closings or relocations. The type of event is defined by the real estate event type code.'
;