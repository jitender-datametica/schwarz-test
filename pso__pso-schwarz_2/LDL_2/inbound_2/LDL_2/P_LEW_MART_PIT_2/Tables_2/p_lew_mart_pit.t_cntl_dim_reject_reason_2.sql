/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_DIM_REJECT_REASON_2
#-------------------------------------------------------------------------------
# Description: Create DDL for Reject Reason Lookup Table - holding the reject reasons during the ETL Process
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-16 Dirk Hering     Fixes, formatting
#  1.2  2021-08-20 Mike Davis      Checks, FK support (now removed)
#-------------------------------------------------------------------------------
*/


/*
---------------------------------------------------------------------
0. Create DIM Table in T_CNTL_DIM_REJECT_REASON_2
------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_MART_PIT.T_CNTL_DIM_REJECT_REASON_2 (
	REJECT_REASON_ID 		INTEGER		 		NOT NULL 		DEFAULT -1 											COMMENT 'Unique Identifier of Reject Reason',
	REJECT_REASON_DESCR 	VARCHAR(1500) 		NOT NULL 		DEFAULT 'N/A' 										COMMENT 'Reject Reason Annotation further description',
	VALID_FROM_DT 			DATE 				NOT NULL 		DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_2-DD') 		COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT 			DATE 				NOT NULL 		DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_2-DD') 		COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR 				INTEGER		 		NOT NULL 		DEFAULT 0 											COMMENT 'Technical Field: Version Number of record ; Sequence starting from 0',
	CURRENT_FG 				SMALLINT	 		NOT NULL 		DEFAULT 1 											COMMENT 'Technical Field 1 indicates the current record in case of several version',
	SOURCE_SYSTEM_ID 		INTEGER		 		NOT NULL 		DEFAULT 0 											COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG 				SMALLINT	 		NOT NULL 		DEFAULT 0 											COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS 			TIMESTAMP		 	NOT NULL 		DEFAULT CURRENT_TIMESTAMP() 						COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS 			TIMESTAMP		 																		COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID 				INTEGER		 		NOT NULL 		DEFAULT 0 											COMMENT 'Technical Field ELT / AB>Initio Process ID',
	CONSTRAINT T_CNTL_DIM_REJECT_REASON_PK PRIMARY KEY (REJECT_REASON_ID, VALID_FROM_DT, DELETED_FG)
)COMMENT='Control Table - Lookup PIT Reject Reason - holding the reject reasons during the ETL Process'
;