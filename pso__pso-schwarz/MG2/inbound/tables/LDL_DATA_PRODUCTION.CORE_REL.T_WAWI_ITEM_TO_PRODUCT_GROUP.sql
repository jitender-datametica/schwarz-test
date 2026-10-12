create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_WAWI_ITEM_TO_PRODUCT_GROUP (
	WAWI_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item.',
	PROD_GRP_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminator for product groups.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	PROD_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the group of marketable products or services.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_WAWI_ITEM_TO_PRODUCT_GROUP primary key (WAWI_ITEM_SID, PROD_GRP_TYPE_CD, DWH_VALID_FROM_TMSP)
)COMMENT='This table relates Wawi items to product groups. A Wawi item may belong to more than one product group at the same time, however for a given product group type a Wawi item can be assigned to only one product group, so that Wawi items and product groups form a hierarchy.'
;