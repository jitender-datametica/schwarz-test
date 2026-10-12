create or replace TABLE SZD_PRODUCTION.CORE_REL.T_EXPORT_WAREHOUSE_1 (
	RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the export warehouse.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	EXPORT_WAREHOUSE_NAME VARCHAR(100) NOT NULL COMMENT 'Natural Key/Business Key - The name of the export warehouse.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_EXPORT_WAREHOUSE primary key (RESOURCE_ITEM_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Entity - The export warehouse is an external warehouse near a port of the country_1 that is exporting the goods. - Source - WWT Report'
;