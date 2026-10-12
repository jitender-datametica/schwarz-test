create or replace TABLE SZD_PRODUCTION.CORE_REL.T_EXTERNAL_WAREHOUSE_2 (
	RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	WAREHOUSE_NAME VARCHAR(100) COMMENT 'Descriptive Attribute - The name of the warehouse.',
	WAREHOUSE_SHORT_NAME VARCHAR(100) COMMENT 'Descriptive Attribute - Short name by which the warehouse is known.',
	CITY_NAME VARCHAR(100) COMMENT 'Descriptive Attribute - Name of the city in which warehouse is situated',
	COUNTRY_POL_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying a political country_2 according to ISO 3166.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	COUNTRY_LOCATION_SID NUMBER(38,0) COMMENT 'the unique identifier (surrogate key) for the political country.',
	constraint PK_EXTERNAL_WAREHOUSE primary key (RESOURCE_ITEM_SID, DWH_VALID_TO_TMSP)
)COMMENT='Major Entity - A  warehouse in the harbour used to unload and store goods. Source - VMT'
;