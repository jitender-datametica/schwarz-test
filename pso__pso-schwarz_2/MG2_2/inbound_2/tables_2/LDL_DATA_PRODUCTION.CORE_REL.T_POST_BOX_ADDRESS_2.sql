create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_POST_BOX_ADDRESS_2 (
	PO_BOX_ADDR_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the post office box address.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	COUNTRY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country.',
	ISO_COUNTRY_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the country_2 according to ISO 3166.',
	POSTAL_CD_AREA_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the postal code area, in which the post office box is located.',
	ZIP VARCHAR(15) NOT NULL COMMENT 'A code used by the postal service to identify a geographical area. E.g. 74072 for Heilbronn in Germany',
	PO_BOX_NR VARCHAR(20) NOT NULL COMMENT 'The number of a post office box, i.e. of a place managed by a post office where mail can be collected.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint AK_ALTERNATE_KEY_T_POST_B unique (ISO_COUNTRY_CD, ZIP, PO_BOX_NR),
	constraint PK_T_POST_BOX_ADDRESS primary key (PO_BOX_ADDR_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A post office box is a place managed by a post office where mail can be collected.'
;