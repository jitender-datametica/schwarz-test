create or replace TABLE SZD_PRODUCTION.CORE_REL.T_LOT_PART_CONTAINER_REL (
	LOT_PART_PRODUCT_INSTANCE_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the lot.',
	CONTAINER_RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the container.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SHIPPED_PRODUCT_QTY NUMBER(38,5) NOT NULL COMMENT 'Measure - Shipped Product Quantity',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_LOT_PART_CONTAINER_REL primary key (LOT_PART_PRODUCT_INSTANCE_GROUP_SID, CONTAINER_RESOURCE_ITEM_SID, DWH_VALID_FROM_TMSP)
)COMMENT='M:N Relation Entity - A shipment of particular product variant in a container.  - Source - VMT'
;