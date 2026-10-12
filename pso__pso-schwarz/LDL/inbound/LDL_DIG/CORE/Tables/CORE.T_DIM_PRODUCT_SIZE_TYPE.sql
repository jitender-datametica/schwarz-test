CREATE TABLE CORE.T_DIM_PRODUCT_SIZE_TYPE (
	PROD_SIZE_TYPE_CD VARCHAR(5) NOT NULL COMMENT 'The code for the product size type (''Kleines Kleinteil'', ''Großteil''\t, etc)',
	PROD_SIZE_TYPE_GROUP_CD             VARCHAR(5)      COMMENT 'A code for product size  classification grouped in the bigger buckets - ''Kleinteil'', ''Großteil'', etc',
	PROD_SIZE_TYPE_DESCR VARCHAR(250)   COMMENT 'A textual description for the  product  size type  in group language (German).',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_PRODUCT_SIZE_TYPE PRIMARY KEY (PROD_SIZE_TYPE_CD)
)COMMENT='This minor dimension for product size classification as defined by Lidl, based on the product''s dimensions (length, width, height) - ''Kleines Kleinteil'', ''Großteil'', etc'
;