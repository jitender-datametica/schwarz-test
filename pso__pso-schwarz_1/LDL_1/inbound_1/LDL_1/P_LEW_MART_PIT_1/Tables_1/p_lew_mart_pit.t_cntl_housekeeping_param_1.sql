/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_HOUSEKEEPING_PARAM_1
#-------------------------------------------------------------------------------
# Describtion: Create DDL for configuration for the old data cleanup table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-05-10 Nikolai Toknov    	Initial version
#-------------------------------------------------------------------------------
*/

/*
---------------------------------------------------------------------
0. Create CNTL Table in T_CNTL_HOUSEKEEPING_PARAM_1
------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_MART_PIT.T_CNTL_HOUSEKEEPING_PARAM_1 (
	SF_SCHEMA					VARCHAR(67108864)				NOT NULL 													COMMENT 'SF Schema',
	SF_TABLE_NAME				VARCHAR(67108864) 			NOT NULL													COMMENT 'SF Table Name',
	HOUSEKEEPING_PARAM  		VARCHAR(67108864) 																		COMMENT 'Parameters for deleting records in the table',
	VALID_FROM_DT 				DATE 				NOT NULL 	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_1-DD') 	COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT 				DATE 				NOT NULL 	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_1-DD') 	COMMENT 'Technical field Data Historization Valid to',
--	VERSION_NR 					INTEGER		 		NOT NULL 	DEFAULT 0 										COMMENT 'Technical Field: Version Number of record ; Sequence starting from 0',
	CURRENT_FG 					SMALLINT	 		NOT NULL 	DEFAULT 1 										COMMENT 'Technical Field 1 indicates the current record in case of several version',
	REJECT_FG 					SMALLINT	 		NOT NULL 	DEFAULT 0 										COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID 			INTEGER		 		NOT NULL 	DEFAULT -1 										COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID 			INTEGER		 		NOT NULL 	DEFAULT 0 										COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG 					SMALLINT	 		NOT NULL 	DEFAULT 0 										COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS 				TIMESTAMP		 	NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS 				TIMESTAMP		 																COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID 					INTEGER		 		NOT NULL 	DEFAULT 0 										COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (SF_SCHEMA, SF_TABLE_NAME, VALID_FROM_DT)
)COMMENT='Control Table - PIT housekeeping params' 
;
/*TO DO:
- validate columns name
- add column like type of data (PV/FA) (?)
*/