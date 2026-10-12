create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_HGA_PRODUCT_CATEGORY_2 (
	HGA_PRODUCT_CAT_ID NUMBER(38,0) NOT NULL COMMENT 'The code for a hot beverage product',
	HGA_PRODUCT_CAT_NAME VARCHAR(100) NOT NULL COMMENT 'The default textual name for hot beverage products',
	HGA_PRODUCT_CAT_NAME_DE VARCHAR(100) NOT NULL COMMENT 'The textual name for hot beverage products in German.',
	HGA_PRODUCT_CAT_NAME_EN VARCHAR(100) NOT NULL COMMENT 'The textual name for hot beverage products in English.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_DIM_HGA_PRODUCT_CATEGORY primary key (HGA_PRODUCT_CAT_ID)
)COMMENT='Hot beverage products which are for sale in Kaufland and Lidl stores e.g. coffee'
;