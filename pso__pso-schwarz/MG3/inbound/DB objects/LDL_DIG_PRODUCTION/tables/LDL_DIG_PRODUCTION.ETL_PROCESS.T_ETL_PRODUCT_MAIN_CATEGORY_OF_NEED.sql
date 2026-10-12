create or replace TABLE LDL_DIG_PRODUCTION.ETL_PROCESS.T_ETL_PRODUCT_MAIN_CATEGORY_OF_NEED (
	PROD_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
	WORLD_OF_NEED_CD VARCHAR(20) COMMENT 'The code for the main World of Need which the product has been automatically assigned.',
	WORLD_OF_NEED_NAME VARCHAR(250) COMMENT 'The name of the main World of Need which the product has been automatically assigned.',
	CATEGORY_OF_NEED_CD VARCHAR(20) COMMENT 'The code for the main Category of Need which the product has been automatically assigned.',
	CATEGORY_OF_NEED_NAME VARCHAR(250) COMMENT 'The name of the main Category of Need which the product has been automatically assigned.',
	SUBCATEGORY_OF_NEED_CD VARCHAR(20) COMMENT 'The code for the main Subcategory of Need (if any) which the product has been automatically assigned.',
	SUBCATEGORY_OF_NEED_NAME VARCHAR(250) COMMENT 'The name of the main Subcategory of Need (if any) which the product has been automatically assigned.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_T_ETL_PRODUCT_MAIN_CATEGORY_OF_NEED primary key (PROD_SID)
)COMMENT='Cleaned table, showing only the main relationship between product/category_of_needs\n             \n             Source: Progress (the system behind the online shop).'
;