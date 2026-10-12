create or replace TABLE LDL_DIG_PRODUCTION.ETL_PROCESS.T_ETL_PROGRESS_PRODUCT_CATEGORY_OF_NEED_2 (
	PROD_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the product',
	PROD_NR VARCHAR(20) COMMENT 'The number for internal onlineshop product, which is country_2 independent.',
	META_TIMESTAMP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The meta timestamp indicated in source data.',
	META_LANGUAGE VARCHAR(20) NOT NULL COMMENT 'The meta language indicated in source data.',
	LOWEST_NEED_CAT_LVL_CD VARCHAR(20) NOT NULL COMMENT 'The code for the lowest level of category of need used for classifying the product on the online shop.',
	IS_MAIN_FG BOOLEAN COMMENT 'A flag indicating that the category of needs indicated for this product is the main one.',
	LOWEST_NEED_CAT_LVL_NAME VARCHAR(250) COMMENT 'The name for the lowest level of category of need used for classifying the product on the online shop.',
	LOWEST_NEED_CAT_PARENT_LVL_CD VARCHAR(20) COMMENT 'The code for the parent category of the lowest hieararchy of need used for classifying the product on the online shop.',
	SUPER_CAT_CHILD_LVL_CD VARCHAR(20) NOT NULL COMMENT 'The code for the child supercategory in the hierarchy_2 of needs which has been defined for this product.',
	SUPER_CAT_CHILD_LVL_NAME VARCHAR(250) COMMENT 'The name for the child supercategory in the hierarchy_2 of needs which has been defined for this product.',
	SUPER_CAT_PARENT_LVL_CD VARCHAR(20) COMMENT 'The code for the parent supercategory in the hierarchy_2 of needs which has been defined for this product.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_T_ETL_PROGRESS_PRODUCT_CATEGORY_OF_NEED primary key (PROD_SID, META_TIMESTAMP, META_LANGUAGE, LOWEST_NEED_CAT_LVL_CD, SUPER_CAT_CHILD_LVL_CD)
)COMMENT='World of Needs is a categorization for products, The goal is to divide products in only 6 big categories (+ subcategories). This table is a technical reproduction from the source, built in a parent_child way to get all the possible relationships between products/categories/subcategories.\n             \n             Source: Progress (the system behind the online shop).\n             '
;