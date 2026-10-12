create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_POSTAL_CODE_AREA_1 (
	POSTAL_CD_AREA_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the postal code area.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	COUNTRY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country.',
	ISO_COUNTRY_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the country_1 according to ISO 3166.',
	COUNTRY_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the country_1 is known,',
	ZIP VARCHAR(15) NOT NULL COMMENT 'A code used by the postal service to identify a geographical area. E.g. 74072 for Heilbronn in Germany',
	POSTAL_CD_AREA_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the postal code area is known,',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint AK_ALTERNATE_KEY_T_POSTAL unique (ISO_COUNTRY_CD, ZIP),
	constraint PK_T_POSTAL_CODE_AREA primary key (POSTAL_CD_AREA_SID, DWH_VALID_FROM_TMSP)
)COMMENT='The geographical area which is identified by a zip code.'
;