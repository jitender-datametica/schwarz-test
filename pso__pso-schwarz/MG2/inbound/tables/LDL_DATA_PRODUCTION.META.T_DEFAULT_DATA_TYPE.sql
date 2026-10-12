create or replace TABLE LDL_DATA_PRODUCTION.META.T_DEFAULT_DATA_TYPE (
	DOMAIN_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the domain.',
	TECHNOLOGY_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the technology is known, e.g. Teradata, AVRO, etc.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DATA_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the data type, as defined for the given technology.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DEFAULT_DATA_TYPE primary key (TECHNOLOGY_NAME, DOMAIN_NAME, DWH_VALID_FROM_TMSP)
)COMMENT='In a physical model a domain is implemented by a data type. Depending on the technology, the domain concept defines a default data type for each domain. (Note that this data type may be overwritten for a particular column.)'
;