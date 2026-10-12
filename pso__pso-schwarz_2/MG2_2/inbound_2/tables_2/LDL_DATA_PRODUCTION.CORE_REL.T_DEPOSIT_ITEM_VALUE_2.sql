create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_DEPOSIT_ITEM_VALUE_2 (
	DEPOSIT_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the deposit item.',
	COUNTRY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DEPOSIT_VAL NUMBER(38,5) NOT NULL COMMENT 'The deposit amount for this item. E.g. 25c for a plastic bottle.',
	CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DEPOSIT_ITEM_VALUE primary key (COUNTRY_SID, DEPOSIT_ITEM_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the deposit amount which is charged for a deposit item_2, depending on the country.'
;