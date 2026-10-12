create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_ADDRESS_DEMOGRAPHICS_1 (
	ADDR_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the postal address.',
	DEMOGRAPHICS_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the type of statistical information.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DEMOGRAPHIC_MEAS NUMBER(38,5) NOT NULL COMMENT 'The value of the statistical information which has been collected for this address.',
	UOM_CD VARCHAR(20) COMMENT 'The code identifying the unit_1 of measure.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_ADDRESS_DEMOGRAPHICS primary key (DEMOGRAPHICS_TYPE_CD, ADDR_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Several statistical informations can be collected on an address_1, such as the number of inhabitants in its vicinity. The type of information is defined by the demographic type'
;