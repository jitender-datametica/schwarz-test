/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2023 
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_FE_MSTR_INFORMATION_TEXT_2
#-------------------------------------------------------------------------------
# Description: Create DDL for Frontend Information for the Startpage and Report Pages
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-12-01 K Lukaszewska    Initial version 
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 
DROP TABLE P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_INFORMATION_TEXT_2
*/ 

/*
---------------------------------------------------------------------
0. Create DIM Table in T_CNTL_FE_MSTR_INFORMATION_TEXT_2
------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_INFORMATION_TEXT_2 (
	INFORMATION_ID	 						INTEGER		 		NOT NULL 		DEFAULT -1 											COMMENT 'Unique Identifier',
	INFORMATION_HTML_DESCR_DE				VARCHAR 			NOT NULL 		DEFAULT 'N/A' 										COMMENT 'German:  Information Message, HTML Format simple. <b> <ul>, etc.',
	INFORMATION_HTML_DESCR_EN				VARCHAR 			NOT NULL 		DEFAULT 'N/A' 										COMMENT 'English: Information Message, HTML Format simple. <b> <ul>, etc.',
	
	INFORMATION_AUTHOR						VARCHAR				NULL																COMMENT 'Author of the information message. ',
	INFORMATION_ENTRY_DT					DATE				NOT NULL		DEFAULT CURRENT_DATE()								COMMENT 'Entry Date of the information message.',
	
	INFORMATION_VISIBLE_START_PAGE_FG		SMALLINT			DEFAULT 0															COMMENT 'Flag / Indicator if the information should be visibale on Startpage',
	INFORMATION_VISIBLE_REPORT_FG			SMALLINT			DEFAULT 0															COMMENT 'Flag / Indicator if the information should be visibale on Report Page',
	
	VALID_FROM_DT 							DATE 				NOT NULL 		DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_2-DD') 		COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT 							DATE 				NOT NULL 		DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_2-DD') 		COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR 								INTEGER		 		NOT NULL 		DEFAULT 0 											COMMENT 'Technical Field: Version Number of record ; Sequence starting from 0',
	CURRENT_FG 								SMALLINT	 		NOT NULL 		DEFAULT 1 											COMMENT 'Technical Field 1 indicates the current record in case of several version',
	
	SOURCE_SYSTEM_ID 						INTEGER		 		NOT NULL 		DEFAULT 0 											COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG 								SMALLINT	 		NOT NULL 		DEFAULT 0 											COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS 							TIMESTAMP		 	NOT NULL 		DEFAULT CURRENT_TIMESTAMP() 						COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS 							TIMESTAMP		 																		COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID 								INTEGER		 		NOT NULL 		DEFAULT 0 											COMMENT 'Technical Field ELT / AB>Initio Process ID',
	CONSTRAINT T_CNTL_FE_MSTR_INFORMATION_TEXT_PK PRIMARY KEY (INFORMATION_ID, VALID_FROM_DT, DELETED_FG)
)COMMENT='Control Table - Frontend Information for the Startpage and Report Pages '
;