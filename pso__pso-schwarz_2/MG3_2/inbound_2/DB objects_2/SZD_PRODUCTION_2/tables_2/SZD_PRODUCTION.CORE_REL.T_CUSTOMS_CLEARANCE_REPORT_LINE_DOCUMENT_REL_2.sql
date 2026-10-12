create or replace TABLE SZD_PRODUCTION.CORE_REL.T_CUSTOMS_CLEARANCE_REPORT_LINE_DOCUMENT_REL_2 (
	MOVEMENT_REF_NUMBER VARCHAR(250) NOT NULL COMMENT 'The movement reference number is a customs identification number that’s created each time a declaration is submitted.',
	TRADER_REFERENCE VARCHAR(250) NOT NULL COMMENT 'Descriptive attribute - This is a reference assigned by the declarant for the goods covered by the declaration.',
	ITEM_POSITION NUMBER(38,0) NOT NULL COMMENT 'The position of the item_2 (report line) within a declaration.',
	RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item..',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_CUSTOMS_CLEARANCE_REPORT_LINE_DOCUMENT_REL primary key (MOVEMENT_REF_NUMBER, TRADER_REFERENCE, ITEM_POSITION, RESOURCE_ITEM_SID)
)COMMENT='Bridge - Associates a customs clearance report line with all attached documents. - CDS (Customs Declaration Service) - Source - Excel Report from CDS (per Mail)'
;