CREATE TABLE CORE.T_DIM_PRODUCT_FOOD_CLASSIFICATION_2 (
	PROD_FOOD_CLASS_CD VARCHAR(5) NOT NULL COMMENT 'The code for the indicating if product is a food or non food',
	PROD_FOOD_CLASS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the product food classification in group language (German).',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_PRODUCT_FOOD_CLASSIFI PRIMARY KEY (PROD_FOOD_CLASS_CD)
)COMMENT='This minor dimension defines if product is classified as a food or non food'
;