CREATE TABLE CORE.T_DIM_PRICE_GROUP_2 (
	PRICE_GROUP_CD VARCHAR(20) NOT NULL COMMENT 'Code of pricing group - internal or customer facing',
	PRICE_GROUP_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for thepricing group in group language (German)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRICE_GROUP PRIMARY KEY (PRICE_GROUP_CD)
)COMMENT='Code of pricing group - internal or customer facing'
;