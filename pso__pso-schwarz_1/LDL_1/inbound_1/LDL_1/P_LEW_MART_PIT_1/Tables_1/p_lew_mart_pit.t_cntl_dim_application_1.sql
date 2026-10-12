/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDLs for T_CNTL_DIM_APPLICATION_1 structures.
#-------------------------------------------------------------------------------
# Description: 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-10-25 Nikolai Toknov    	Initial version
#-------------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_MART_PIT.T_CNTL_DIM_APPLICATION_1 (

	APPLICATION_NAME					VARCHAR			NOT NULL 		DEFAULT 'PITonCloud' 							COMMENT 'General name of the application (see ETL_LOGGING_RUN_SEQ) Name of Application --> Module --> Component',
	APPLICATION_DESCR					VARCHAR			NOT NULL 		DEFAULT 'PITonCloud' 							COMMENT 'Annotation further Description',
	APPLICATION_CNTR_TABLE_PREFIX		VARCHAR			NOT NULL 		DEFAULT '' 										COMMENT 'The prefix indicating which CNTR tables should be used. For example, the prefix PSNF_ for the table  T_CNTL_PSNF_PROCESSING_PARAM_NORMALIZED_1',

	-- Technical fields				
	VALID_FROM_DT 						DATE 			NOT NULL 		DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_1-DD') 	COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT 						DATE 			NOT NULL 		DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_1-DD') 	COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR 							INTEGER		 	NOT NULL 		DEFAULT 0 										COMMENT 'Technical Field: Version Number of record ; Sequence starting from 0',
	CURRENT_FG 							SMALLINT	 	NOT NULL 		DEFAULT 1 										COMMENT 'Technical Field 1 indicates the current record in case of several version',
	REJECT_FG 							SMALLINT	 	NOT NULL 		DEFAULT 0 										COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID 					INTEGER		 	NOT NULL 		DEFAULT -1 										COMMENT 'Link to DQ Reject Reason Codes',
	DELETED_FG 							SMALLINT	 	NOT NULL 		DEFAULT 0 										COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS 						TIMESTAMP		 NOT NULL 		DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS 						TIMESTAMP		 																COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID 							INTEGER		 	NOT NULL 		DEFAULT 0 										COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (APPLICATION_NAME, VALID_FROM_DT)
)COMMENT='Control Table - Lookup Applicaton System'
;