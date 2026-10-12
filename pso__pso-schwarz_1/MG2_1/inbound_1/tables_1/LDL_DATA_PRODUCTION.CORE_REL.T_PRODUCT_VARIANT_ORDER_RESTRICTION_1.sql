create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PRODUCT_VARIANT_ORDER_RESTRICTION_1 (
	PROD_VARIANT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a variant of a product for which a restriction applies.',
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization, in which the restriction applies.',
	ORDER_RESTRICTION_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of restriction that apply when ordering a product. (e.g. minimum order quantity, maximum order quantity, etc.)',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	ORDER_QTY NUMBER(38,5) NOT NULL COMMENT 'The order quantity which is described by the restriction. (I.e. the minimum or maximum order quantity)',
	LOGISTIC_UOM_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the logistic unit_1 of measure. (e.g. palettes, boxes, pieces or layers on a palette)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PRODUCT_VARIANT_ORDER_RESTRICTION primary key (ORDER_RESTRICTION_TYPE_CD, PROD_VARIANT_SID, INT_ORG_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Products may only be ordered in certain quantities, i.e. there may be minimum or maximum quantities.'
;