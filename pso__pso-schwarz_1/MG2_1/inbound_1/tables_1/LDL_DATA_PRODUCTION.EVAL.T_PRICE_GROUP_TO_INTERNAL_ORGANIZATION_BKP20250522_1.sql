create or replace TABLE LDL_DATA_PRODUCTION.EVAL.T_PRICE_GROUP_TO_INTERNAL_ORGANIZATION_BKP20250522_1 (
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization to which the price group applies',
	INT_ORG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
	PRICE_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the price level of a product.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	PRICE_GRP_PRIO NUMBER(38,0) COMMENT 'In case several prices are defined for one product, the price originating from the price group is used, which has the highest priority for the given store or warehouse.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PRICE_GROUP_TO_INTERNAL_ORGANIZATION primary key (INT_ORG_SID, PRICE_GRP_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Prices in stores and warehouses (delivery companies) are defined based on price groups. This entity relates an internal organization to all applicable price groups. The priority defines which price group is used, in case several prices are defined for one product.'
;