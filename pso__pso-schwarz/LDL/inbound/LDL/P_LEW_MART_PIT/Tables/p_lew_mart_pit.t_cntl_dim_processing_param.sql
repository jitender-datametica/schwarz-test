/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_DIM_PROCESSING_PARAM
#-------------------------------------------------------------------------------
# Description: Create DDL for Control Table - Lookup PIT processing params
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-16 Dirk Hering     Fixes, formatting
#  1.2  2021-08-23 Mike Davis      Checks, formatting, FK support (now removed)
#  1.3  2022-02-08 Andreas Kurz	   Reformat, split into load_initialize
#-------------------------------------------------------------------------------
*/

/*
---------------------------------------------------------------------
0. Create DIM Table in T_CNTL_DIM_PROCESSING_PARAM
------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_MART_PIT.T_CNTL_DIM_PROCESSING_PARAM (
	PARAM_ID 				INTEGER		 		NOT NULL 	DEFAULT -1 										COMMENT 'Identifier for the parameter. Note a parameter is specified by the client_id, param_id pair. I.e. the same parameter can have different values for the different clients.',
	PARAM_NAME 				VARCHAR 			NOT NULL 	DEFAULT 'N/A' 									COMMENT 'Parameter name in local LANGUAGE',
	PARAM_DESCR 			VARCHAR 																		COMMENT 'Parameter description in local LANGUAGE',
	PARAM_COLUMN_DATATYPE 	VARCHAR				NOT NULL 	DEFAULT 'VARCHAR' 								COMMENT 'Data type specifier for the parameter (e.g.: TEXT, DATE, TIME, TIMESTAMP, FLOAT, NUMBER)',
	ABINITIO_EXEC_FG 		SMALLINT	 		NOT NULL 	DEFAULT 0 										COMMENT 'ABInitio Execution Flag / Indicator, 1::= Parameter is used also for ABInitio Injection',
	ABINITIO_PARAM_NAME 	VARCHAR 																		COMMENT 'ABInitio Parameter Name',
	VALID_FROM_DT 			DATE 				NOT NULL 	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM-DD') 	COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT 			DATE 				NOT NULL 	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM-DD') 	COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR 				INTEGER		 		NOT NULL 	DEFAULT 0 										COMMENT 'Technical Field: Version Number of record ; Sequence starting from 0',
	CURRENT_FG 				SMALLINT	 		NOT NULL 	DEFAULT 1 										COMMENT 'Technical Field 1 indicates the current record in case of several version',
	REJECT_FG 				SMALLINT	 		NOT NULL 	DEFAULT 0 										COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID 		INTEGER		 		NOT NULL 	DEFAULT -1 										COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID 		INTEGER		 		NOT NULL 	DEFAULT 0 										COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG 				SMALLINT	 		NOT NULL 	DEFAULT 0 										COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS 			TIMESTAMP		 	NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS 			TIMESTAMP		 																COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID 				INTEGER		 		NOT NULL 	DEFAULT 0 										COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (PARAM_ID, VALID_FROM_DT, DELETED_FG)
)COMMENT='Control Table - Lookup PIT processing params'
;