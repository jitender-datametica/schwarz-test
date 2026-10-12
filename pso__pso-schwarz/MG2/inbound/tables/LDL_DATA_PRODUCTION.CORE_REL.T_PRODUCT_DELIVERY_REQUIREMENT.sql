create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PRODUCT_DELIVERY_REQUIREMENT (
	PROD_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization which has defined these requirements.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DELIV_TEMP_MEAS NUMBER(38,5) COMMENT 'The (recommended) delivery temperature for the product.',
	MIN_DELIV_TEMP_MEAS NUMBER(38,5) COMMENT 'The minimum delivery temperature for the product.',
	MAX_DELIV_TEMP_MEAS NUMBER(38,5) COMMENT 'The maximum delivery temperature for the product.',
	UOM_CD VARCHAR(20) COMMENT 'The code identifying the unit of measure.',
	SHELFLIFE_CHECK_ON_RECEIPT_FG BOOLEAN COMMENT 'An indicator showing, if the minimum shelflife for this product shall be checked upon receipt.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PRODUCT_DELIVERY_REQUIREMENT primary key (INT_ORG_SID, PROD_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A product may require special treatment when transported. E.g. it must be kept refrigerated.'
;