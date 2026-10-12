create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PRODUCT_GROUP (
	PROD_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the group of marketable products or services.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	PROD_GRP_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminator for product groups.',
	PROD_GRP_NR VARCHAR(100) NOT NULL COMMENT 'The number which identifies the group of products. (The number is unique among one type of product groups.)',
	PROD_GRP_NAME VARCHAR(250) NOT NULL COMMENT 'The name of the product group.',
	PROD_CONTAINER_TYPE_CD VARCHAR(20) COMMENT 'The code identifying the subtype discriminator for item containers.',
	PROD_CONTAINER_CLASS_CD VARCHAR(20) COMMENT 'The code distinguishing between module containers and surface containers.',
	PROD_CONTAINER_ASSORT_AREA_CD VARCHAR(20) COMMENT 'The code identifying the assortment area, by which product containers can be classified.',
	PROD_CONTAINER_SIZE_CD VARCHAR(20) COMMENT 'The code identifying the size class for module containers. (small / medium / large)',
	COUNTRY_ORG_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for the country organization which uses this product container.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PRODUCT_GROUP primary key (PROD_GRP_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A group of marketable products or services which has been formed for a specific purpose. (Note that a group of products is not a product!)'
;