/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_DIM_KPI_TRANSACTION_TYPE_CODES_1
#-------------------------------------------------------------------------------
# Description: Create DDL for Control Table - Lookup PIT KPIs list of Transactiontype Codes
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-09-14 Andreas Kurz    	Initial version
#  1.1  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
TRANSACTION_TYPE_CD_NR
TRANSACTION_TYPE_CD_DESCR
*/

CREATE TABLE P_LEW_MART_PIT.T_CNTL_DIM_KPI_TRANSACTION_TYPE_CODES_1 (
	KPI_SID 						INTEGER		 		NOT NULL autoincrement START 0 INCREMENT 1 						COMMENT 'Autoincrement (0,1)',
	KPI_NAME 						VARCHAR(150) 		NOT NULL 														COMMENT 'KPI Name',
	TRANSACTION_TYPE_CD 			ARRAY 																				COMMENT 'Array of UPI Columns of the associated table',
--	TRANSACTION_TYPE_CD_NR 			INTEGER		 					AS (ARRAY_SIZE(TRANSACTION_TYPE_CD)) 				COMMENT 'Size of Array Elements',
--	TRANSACTION_TYPE_CD_DESCR 		VARCHAR(16777216) 				AS (ARRAY_TO_STRING(TRANSACTION_TYPE_CD, ',')) 		COMMENT 'String representation of UPI Array with comma separator',
	TRANSACTION_TYPE_CD_DESCR 		VARCHAR															 					COMMENT 'String representation of UPI Array with comma separator',
	SF_TABLE_NAME 					VARCHAR(150) 		NOT NULL 	DEFAULT 'T_CNTL_DIM_KPI_TRANSACTION_TYPE_CODES_1' 	COMMENT 'SFTable name of Source Table. Could be also a Source View from S2T Mapping. ',
	SF_SCHEMA_NAME 					VARCHAR(150) 		NOT NULL 	DEFAULT CURRENT_SCHEMA() 							COMMENT 'SF Schema Name of Aggregation ',
	SF_DATABASE_NAME 				VARCHAR(150) 		NOT NULL 	DEFAULT CURRENT_DATABASE() 							COMMENT 'SF Database Name',
	SF_WAREHOUSE_NAME 				VARCHAR(150) 		NOT NULL 	DEFAULT CURRENT_WAREHOUSE() 						COMMENT 'SF Warehouse Name',
	ANNOTATION 						VARCHAR(1500) 																		COMMENT 'Further annotation',
	VALID_FROM_DT 					DATE 				NOT NULL 	DEFAULT CAST('1900-01-01' AS DATE) 					COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT 					DATE 				NOT NULL 	DEFAULT CAST('9999-12-31' AS DATE) 					COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR 						INTEGER		 		NOT NULL 	DEFAULT 0 											COMMENT 'Technical Field: Version Number of record ; Sequence starting from 0',
	CURRENT_FG 						SMALLINT	 		NOT NULL 	DEFAULT 1 											COMMENT 'Technical Field 1 indicates the current record in case of several version',
	REJECT_FG 						SMALLINT	 		NOT NULL 	DEFAULT 0 											COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID 				INTEGER		 		NOT NULL 	DEFAULT -1 											COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID 				INTEGER		 		NOT NULL 	DEFAULT 0 											COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG 						SMALLINT	 		NOT NULL 	DEFAULT 0 											COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS 					TIMESTAMP		 	NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 						COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS 					TIMESTAMP		 																	COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID 						INTEGER		 		NOT NULL 	DEFAULT 0 											COMMENT 'Technical Field ELT / AB>Initio Process ID',
	CONSTRAINT T_CNTL_DIM_KPI_TRANSACTION_TYPE_CODES_PK PRIMARY KEY (KPI_SID, VALID_FROM_DT, DELETED_FG)
)COMMENT='Control Table - Lookup PIT KPI Transaction Codes Mapping.'
;