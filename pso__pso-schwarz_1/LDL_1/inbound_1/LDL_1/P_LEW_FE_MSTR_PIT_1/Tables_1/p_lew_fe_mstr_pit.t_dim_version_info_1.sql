/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_VERSION_INFO
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Adv.Period Dimension Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-18 Mike Davis      	Checks, formatting
#  1.2  2021-09-13 Massimo Morelli 	Fixed SCHEMA, added COMMIT
#  1.8  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.0	2022-04-12 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC. 
#-------------------------------------------------------------------------------
*/

/*
VC:
PIT_ENVIRONMENT_LONG_DESCR
VERSION_NBR_DESCR
VERSION_INFO_LONG_DESCR

*/

CREATE TABLE P_LEW_FE_MSTR_PIT.T_DIM_VERSION_INFO_1 (

	VERSION_DT					DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') COMMENT 'Version DATE',
	
	MAJOR_NBR					INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Major Version NUMBER',
	MINOR_NBR					INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Minor Version NUMBER',
	BUILD_NBR					INTEGER			NOT NULL	DEFAULT 0 									COMMENT '[Optional] Daily Build NUMBER',
	REVISION_NBR				INTEGER			NOT NULL	DEFAULT 0 									COMMENT '[Optional] Revision NUMBER',
	PIT_ENVIRONMENT_DESCR		VARCHAR(2)		NOT NULL	DEFAULT 'SF' 								COMMENT 'Environment info TD ::= Teradata and SF::=Snowflake',
	VERSION_INFO_DESCR			VARCHAR 																COMMENT 'Version Info Description',
	FE_MSTR_RELEVANT_FG			SMALLINT		NOT NULL	DEFAULT 1 									COMMENT 'Flag indicates if used on FE_MSTR',
	
	CURRENT_PIT_VERSION_FG		SMALLINT		NOT NULL	DEFAULT 0,
	
	-- [View] Relevant Columns will be filled in View! Just mentioned here so that we have Column 						COMMENTs	
	CURRENT_PIT_VERION_FG		SMALLINT					DEFAULT 0 									COMMENT 'Indicator / Flag if the current PIT Version based on current day',

    -- Versioning  
	VALID_FROM_DT				DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_1-DD')	COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT					DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_1-DD')	COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR					INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field: Version NUMBER of record ; Sequence starting from 0',
	CURRENT_FG					SMALLINT		NOT NULL	DEFAULT 1 									COMMENT 'Technical Field 1 indicates the current record in case of several version',
			
    -- Technical fields			
	REJECT_FG					SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID			INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG					SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS				TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS				TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID						INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (VERSION_DT, VALID_FROM_DT, FE_MSTR_RELEVANT_FG, DELETED_FG)
)	COMMENT='Dimension table for PIT Version Information'
;