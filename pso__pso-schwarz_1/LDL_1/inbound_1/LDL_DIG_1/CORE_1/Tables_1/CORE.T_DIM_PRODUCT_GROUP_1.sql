CREATE TABLE CORE.T_DIM_PRODUCT_GROUP_1 (
	PROD_GROUP_CD VARCHAR(20) NOT NULL COMMENT 'Code of warengruppe - one of the LD classification for the products (DMM165-013, DMM165-014 , etc)',
	PROD_GROUP_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the warengruppe - one of the LD classification for the products (Beauty , Werkzeug, etc)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_PRODUCT_GROUP PRIMARY KEY (PROD_GROUP_CD)
)COMMENT='Warengruppe - one of the LD classification for the products (Beauty , Werkzeug, etc)'
;