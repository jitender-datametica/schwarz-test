create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_LOT_LOT_PART_CONTAINER_2 (
	LOT_PRODUCT_INSTANCE_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the lot.',
	LOT_PART_PRODUCT_INSTANCE_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'Natural Key/Business Key - The unique identifier (surrogate key) for the lot.',
	CONTAINER_RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'Natural Key/Business Key - The unique identifier (surrogate key) for the container.',
	SHIPPING_DESTINATION_CD VARCHAR(50) NOT NULL COMMENT 'The code identifying a political country_2 according to ISO 3166.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	LOT_NR VARCHAR(50) NOT NULL COMMENT 'Business Key - The number which identifies the lot.',
	GTIN_NR VARCHAR(50) COMMENT 'Descriptive Attribute - GTIN',
	SHIPPED_PRODUCT_QTY NUMBER(38,5) NOT NULL COMMENT 'Fact - additive - Shipped Product Quantity',
	TOTAL_SHIPPED_PRODUCT_QTY NUMBER(38,5) NOT NULL COMMENT 'Fact - additive - Total product shipped quantity within lot',
	CONTAINER_SHARE_PCT NUMBER(38,5) NOT NULL COMMENT 'Fact - additive - Container share of product in container',
	TOTAL_SHIPPED_CONTAINER_PRODUCT_QTY NUMBER(38,5) NOT NULL COMMENT 'Fact - additive - Total product shipped quantity within container',
	OTHER_LOTS_IN_CONTAINER_TXT VARCHAR(1000) NOT NULL COMMENT 'Derrived attribute - A list of lot numbers travelling in the same container, can be an empty list',
	OTHER_LOTS_IN_CONTAINER_CNT NUMBER(38,0) NOT NULL COMMENT 'Derrived attribute - count of other lots travelling in the same container',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_FACT_LOT_LOT_PART_CONTAINER primary key (LOT_PART_PRODUCT_INSTANCE_GROUP_SID, CONTAINER_RESOURCE_ITEM_SID, LOT_PRODUCT_INSTANCE_GROUP_SID, DWH_VALID_FROM_TMSP, SHIPPING_DESTINATION_CD)
)COMMENT='Fact table - Transactional Events - Transaction - A shipment of particular product variant and it''s parts in a container to a destination. - Source - VMT'
;