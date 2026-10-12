/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDLs for CNTL_CNTL_ETL_LOGGING structures.
#-------------------------------------------------------------------------------
# Description: DDLs for ETL Logging Control structures:
#                   FUNCTION f_QueryTag
#                   Sequence SEQ_CNTL_ETL_LOGGING
#                   TABLE P_LEW_MART_PIT.T_CNTL_ETL_LOGGING_RUN_SEQ_2
#                   TABLE P_LEW_MART_PIT.T_CNTL_ETL_LOGGING_2
#                   Logging Procedures
#                   View V_CNTL_ETL_LOGGING_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-27 Andreas Kurz    	Initial version
#  1.1  2021-08-16 Dirk Hering     	Fixes, formatting
#  1.2  2021-08-18 Andreas Kurz		Added Nr. of Processed Records
#									Changed the Procedures
#  2.0	2022-07-13 Nikolai Toknov  	Changing the script for DevOps
#  2.5  2022-09-17 Andreas Kurz		Changed additional columns MULTI_CLIENT
#  2.6  2023-08-14 Andreas Kurz 	Added new columns for changed Logging mechanism
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
RUN_TIME_MIN
RUN_TIME_SEC
RUN_LDESC
MULTI_CLIENT_RUN_LST_NR
MULTI_CLIENT_RUN_LST_DESCR
MULTI_CLIENT_RUN_FG
*/

CREATE TABLE P_LEW_MART_PIT.T_CNTL_ETL_LOGGING_2 (
	RUN_ID_SEQ					INTEGER				NOT NULL 	DEFAULT -1 										COMMENT 'Sequence NUMBER of ETL processing - based on SEQ_CNTL_ETL_LOGGING (see CNTL_ETL_LOGGING_RUN_SEQ)',
	RUN_TS						TIMESTAMP			NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Execution timestamp. Start of daily ETL processing (see ETL_LOGGING_RUN_SEQ)',
	RUN_DAY_ID					DATE				NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 	COMMENT 'Execution day. Format YYYY-MM_2-DD (see ETL_LOGGING_RUN_SEQ).',

	-- executed client Id(s) -1 ::= All clients
	CLIENT_ID 						INTEGER		 		NOT NULL 	DEFAULT -1 									COMMENT 'Client ID e.g. 1=>AT',	

	-- executed client Id(s)
 	MULTI_CLIENT_RUN_LST			ARRAY																		COMMENT 'Executed Client ID(s) in case of multiple Client IDs will be executed',
	-- in case of parallel Execution Clusters of same application
	-- this will keep the clustering (partition by) key
	RUN_CLUSTERING_DESC			VARCHAR				NOT NULL 	DEFAULT '[0]' 									COMMENT 'Execution cluster in case of parallel execution. Format [ cluster name ]. (see ETL_LOGGING_RUN_SEQ).',

	
	-- Name of Application --> Module --> Component
	APPLICATION_NAME			VARCHAR				NOT NULL 	DEFAULT 'PITonCloud' 							COMMENT 'General name of the application (see ETL_LOGGING_RUN_SEQ) Name of Application --> Module --> Component',

	-- Module NAME --> Component
	MODULE_NAME					VARCHAR				NOT NULL 	DEFAULT 'N/A' 									COMMENT 'Name of the program module. Example: POS cash register data processing. Module Name --> Component.',

	-- Component NAME OF Module
	COMPONENT_NAME				VARCHAR				NOT NULL 	DEFAULT 'N/A' 									COMMENT 'Name of the program component of a program module. Example: POS-ReceiptLine processing',

	START_RUN_TS				TIMESTAMP			NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Start timestamp of processing',
	END_RUN_TS					TIMESTAMP		 																COMMENT 'End timestamp of processing',
	QUERY_TAG					VARCHAR 																		COMMENT 'Querytag',

	SF_USER						VARCHAR			NOT NULL 	DEFAULT CURRENT_USER() 								COMMENT 'Snowflake User - DEFAULT =  CURRENT_USER()',
	SF_WAREHOUSE				VARCHAR			NOT NULL 	DEFAULT CURRENT_WAREHOUSE() 						COMMENT 'Snowflake Warehouse - DEFAULT = CURRENT_WAREHOUSE()',
	SF_ROLE						VARCHAR			NOT NULL 	DEFAULT CURRENT_ROLE() 								COMMENT 'Snowflake Role - DEFAULT = CURRENT_ROLE()',
	SF_DATABASE					VARCHAR			NOT NULL 	DEFAULT CURRENT_DATABASE() 							COMMENT 'Snowflake Database - DEFAULT = CURRENT_DATABASE()',
	SF_SCHEMA					VARCHAR			NOT NULL 	DEFAULT CURRENT_SCHEMA() 							COMMENT 'Snowflake Schema - DEFAULT = CURRENT_SCHEMA()',
	SF_SESSION					VARCHAR			NOT NULL 	DEFAULT CURRENT_SESSION() 							COMMENT 'Snowflake Session - DEFAULT = CURRENT_SESSION()',
	SF_CLIENT					VARCHAR			NOT NULL 	DEFAULT CURRENT_CLIENT() 							COMMENT 'Snowflake Client - DEFAULT = CURRENT_CLIENT()',
	
	-- AKU 2021-08-18 Added Nr. of Processed Records		
	RECORD_PROCESSED_NR			INTEGER			NOT NULL 	DEFAULT 0 											COMMENT 'Number of processed Records',
			
	START_PROCESSING_FG			SMALLINT		NOT NULL 	DEFAULT 0 											COMMENT 'Flag / indicator of the start of the loading run. [0|1]',
	END_PROCESSING_FG			SMALLINT		NOT NULL 	DEFAULT 0 											COMMENT 'Flag / indicator of the end of the loading run. [0|1]',
	
	MODULE_LEVEL_FG				SMALLINT		NOT NULL 	DEFAULT 0 											COMMENT 'Flag / indicator level Module. [0|1]',
	COMPONENT_LEVEL_FG			SMALLINT		NOT NULL 	DEFAULT 0 											COMMENT 'Flag / indicator level Component. [0|1]',
	COMPLETED_RUN_FG			SMALLINT		NOT NULL 	DEFAULT 0 											COMMENT 'Flag / indicator that loading run is completed. [0|1]',
	
	-- AKU 2023-08-14
	MODULE_START_FG				SMALLINT		NOT NULL 	DEFAULT 0 											COMMENT 'Flag / indicator level Module. [0|1]',
	MODULE_END_FG				SMALLINT		NOT NULL 	DEFAULT 0 											COMMENT 'Flag / indicator level Module. [0|1]',	
	COMPONENT_START_FG			SMALLINT		NOT NULL 	DEFAULT 0 											COMMENT 'Flag / indicator level Component. [0|1]',
	COMPONENT_END_FG			SMALLINT		NOT NULL 	DEFAULT 0 											COMMENT 'Flag / indicator level Component. [0|1]',

	
	-- VC Populated by View				
	MOVING_RUN_ID_FROM_CURRENT	INTEGER		 				DEFAULT 0 											COMMENT '[View] Current ID = 0 previous Run IDs are -1,-2,etc.',
	
	-- Technical fields				
	DELETED_FG					SMALLINT		NOT NULL 	DEFAULT 0 											COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS				TIMESTAMP		NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 						COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS				TIMESTAMP		 																COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID						INTEGER			NOT NULL 	DEFAULT 0 											COMMENT 'Technical Field ELT / ABInitio Process ID',
	UNIQUE (RUN_ID_SEQ),
	PRIMARY KEY (RUN_ID_SEQ, RUN_DAY_ID, DELETED_FG)
)	COMMENT='Central ETL Logging Table, holding the start and end timestamps, and the execution run time.'
;