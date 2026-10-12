/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for CNTL_PSNF_PROCESSING_PARAM
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-08-27 Nikolai Toknov   Initial version
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
PARAM_VALUE_ARRAY_NR
PARAM_VALUE_ARRAY_DESCR
*/


/*
---------------------------------------------------------------------
0. Create CNTL Table in T_CNTL_PSNF_PROCESSING_PARAM_1
------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_MART_PIT.T_CNTL_PSNF_PROCESSING_PARAM_1 (
	CLIENT_ID 					INTEGER		 		NOT NULL 	DEFAULT -1 										COMMENT 'PIT Country_1',
	PARAM_ID 					INTEGER		 		NOT NULL 	DEFAULT -1 										COMMENT 'Identifier for the parameter. Note a parameter is specified by the client_id, param_id pair. I.e. the same parameter can have different values for the different clients.',
	PARAM_VALUE 				NUMBER(38,5) 					DEFAULT 0 										COMMENT 'Parameter numeric value of the parameter, where appropriate',
	PARAM_VALUE_CHAR 			VARCHAR 																		COMMENT 'Parameter character value of the parameter, where appropriate',
	PARAM_VALUE_ARRAY 			ARRAY 																			COMMENT 'Parameter Array of Values, where appropriate',
/*	PARAM_VALUE_ARRAY_NR 		INTEGER		 					AS (ARRAY_SIZE(PARAM_VALUE_ARRAY)) 				COMMENT '[VC] Parameter Array Number of Values',
	PARAM_VALUE_ARRAY_DESCR 	VARCHAR 						AS (ARRAY_TO_STRING(PARAM_VALUE_ARRAY, ',')) 	COMMENT '[VC] Parameter Array Descr comma-separated', */
	VALID_FROM_DT 				DATE 				NOT NULL 	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_1-DD') 	COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT 				DATE 				NOT NULL 	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_1-DD') 	COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR 					INTEGER		 		NOT NULL 	DEFAULT 0 										COMMENT 'Technical Field: Version Number of record ; Sequence starting from 0',
	CURRENT_FG 					SMALLINT	 		NOT NULL 	DEFAULT 1 										COMMENT 'Technical Field 1 indicates the current record in case of several version',
	REJECT_FG 					SMALLINT	 		NOT NULL 	DEFAULT 0 										COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID 			INTEGER		 		NOT NULL 	DEFAULT -1 										COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID 			INTEGER		 		NOT NULL 	DEFAULT 0 										COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG 					SMALLINT	 		NOT NULL 	DEFAULT 0 										COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS 				TIMESTAMP		 	NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS 				TIMESTAMP		 																COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID 					INTEGER		 		NOT NULL 	DEFAULT 0 										COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, PARAM_ID, VALID_FROM_DT, DELETED_FG)
)COMMENT='Control Table - PIT PSNF processing params'
;