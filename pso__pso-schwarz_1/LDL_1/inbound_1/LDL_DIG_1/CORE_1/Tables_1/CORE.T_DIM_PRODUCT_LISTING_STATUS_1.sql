CREATE TABLE CORE.T_DIM_PRODUCT_LISTING_STATUS_1 (
	PROD_LISTING_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'Code that defines the listing status_1 of a product ',
	PROD_LISTING_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the listing status_1 of a product ',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_PRODUCT_LISTING_STATU PRIMARY KEY (PROD_LISTING_STATUS_CD)
)COMMENT='Minor dimension that defines  the listing status_1 of a product ( sellable or non sellable )'
;