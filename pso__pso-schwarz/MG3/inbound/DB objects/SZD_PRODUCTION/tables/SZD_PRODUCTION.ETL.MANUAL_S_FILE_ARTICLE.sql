create or replace TABLE SZD_PRODUCTION.ETL.MANUAL_S_FILE_ARTICLE (
	ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier for an item',
	ITEM_GTIN VARCHAR(20) NOT NULL COMMENT 'The gtin of an item',
	LOB_CD VARCHAR(50) NOT NULL COMMENT 'The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland\n            lob=line os business',
	MANUFACTURER_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a company which produces deposit machines.',
	UNITSIZE_DESCR VARCHAR(250) COMMENT 'The size of a deposit article',
	ITEM_NAME VARCHAR(100) COMMENT 'The name of an item',
	ITEM_CONTAINER_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The description of a container which can be foreign or own container',
	ITEM_PACKAGE_TYPE_DESCR VARCHAR(250) COMMENT 'The type of a package e.g. PET, Bottle',
	FIRST_DISTRIBUTOR_NAME VARCHAR(100) COMMENT 'The first distributor to the market',
	COUNTRY_POL_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying a political country according to ISO 3166.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(250) NOT NULL COMMENT 'The unique identifier of the batch load that has done the last modification to this record. (This can either be the initial insert, or an update operation at a later point in time.)',
	SRC_1_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The identifier for the first source the table refers to.',
	SRC_2_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The identifier for the second source the table refers to.',
	SRC_3_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The identifier for the third source the table refers to.'
);