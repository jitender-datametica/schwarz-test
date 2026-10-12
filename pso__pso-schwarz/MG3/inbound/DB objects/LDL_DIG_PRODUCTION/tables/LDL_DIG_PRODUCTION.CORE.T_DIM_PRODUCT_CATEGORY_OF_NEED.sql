create or replace TABLE LDL_DIG_PRODUCTION.CORE.T_DIM_PRODUCT_CATEGORY_OF_NEED (
	CATEGORY_OF_NEED_CD VARCHAR(50) NOT NULL COMMENT 'The code for main Category of Need which the product has been automatically assigned.',
	CATEGORY_OF_NEED_NAME VARCHAR(100) COMMENT 'The description for category of need product category',
	WORLD_OF_NEED_CD VARCHAR(50) COMMENT 'The code for the main World of Need which the product has been automatically assigned.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_T_DIM_PRODUCT_CATEGORY_OF_NEED primary key (CATEGORY_OF_NEED_CD)
)COMMENT='The World of Needs categorization system groups products into six broad categories to simplify and organize the vast array of products. A Category of Need represents a middle level of this product categorization (examples are Men''s Clothing, Toys, and Fitness goods).'
;