CREATE TABLE ETL.T_WAWI_ITEM_VARIANT_STATUS_TYPE (
	WAWI_ITEM_VARIANT_STATUS_TYPE_ID VARCHAR(20) NOT NULL COMMENT 'The identifier for the lifecycle status for Wawi item variants.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	WAWI_ITEM_VARIANT_STATUS_TYPE_NAME VARCHAR(250) NOT NULL COMMENT 'The name for the lifecycle status for Wawi item variants.',
	WAWI_ITEM_VARIANT_STATUS_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the lifecycle status for Wawi item variants.',
	CONSTRAINT PK_T_PRODUCT_VARIANT_STATUS_TYPE PRIMARY KEY (WAWI_ITEM_VARIANT_STATUS_TYPE_ID, LANG_CD)
);