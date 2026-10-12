CREATE TABLE CORE.T_DIM_PRODUCT_PACKING_TYPE_2 (
	PROD_PACKING_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'Code that defines the general type of packaging for the article (i.e. carton, bag)',
	PROD_PACKING_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the general type of packaging for the article ',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_PRODUCT_PACKING_TYPE PRIMARY KEY(PROD_PACKING_TYPE_CD)
)COMMENT='Minor dimension that defines the general type of packaging for the article (i.e. carton, bag)'
;