create or replace TABLE SZD_PRODUCTION.CORE_REL.T_LOT_PART (
	PRODUCT_INSTANCE_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the lot part.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	LOT_PART_STATUS_CD VARCHAR(50) NOT NULL COMMENT 'The status code for the lot part',
	LOT_PRODUCT_INSTANCE_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the lot.',
	SHIPPING_DESTINATION_CD VARCHAR(50) NOT NULL COMMENT 'The code identifying a political country according to ISO 3166.',
	GTIN_NR VARCHAR(50) COMMENT 'Descriptive Attribute - GTIN',
	SPARE_UNIT_FG BOOLEAN NOT NULL COMMENT 'Descriptive Attribute - Indication if spare unit or not',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_LOT_PART primary key (PRODUCT_INSTANCE_GROUP_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Entity - A shipment of particular product variant  - Source - VMT'
;