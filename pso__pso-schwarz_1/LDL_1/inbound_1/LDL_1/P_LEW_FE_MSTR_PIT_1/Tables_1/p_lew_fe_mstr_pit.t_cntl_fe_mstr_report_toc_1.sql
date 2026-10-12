/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025 
#-------------------------------------------------------------------------------
# Interface : DDL for CNTL_FE_MSTR_REPORT_TOC
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-30 Mike Davis      Checks, formatting
#  1.2	2021-09-13 Massimo Morelli Fixed SCHEMA added COMMIT
#  2.0	2022-07-14 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_REPORT_TOC_1');


DROP TABLE IF EXISTS P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_REPORT_TOC_1

*/

CREATE TABLE P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_REPORT_TOC_1 (
	REPORT_ID			INTEGER			NOT NULL	DEFAULT -1										COMMENT 'Identifier, implicied logic',
	REPORT_SORT_VAL		INTEGER			NOT NULL	DEFAULT -1										COMMENT 'Sorting Order of the Frontend Reports',
	REPORT_NAME			VARCHAR			NOT NULL	DEFAULT 'N/A'									COMMENT 'MicroStrategy Name of Reporting Object',
	REPORT_GUID			VARCHAR			NOT NULL	DEFAULT '00000000000000000000000000000000'		COMMENT 'MicroStrategy GUID Identifier ',

	REPORT_ANNOTATION	VARCHAR																		COMMENT 'Annotation of Frontend Report',

	REPORT_VISIBLE_FG	SMALLINT					DEFAULT 0										COMMENT 'Flag / Indicator if Report is visible ',
	REPORT_TEASER_FG	SMALLINT					DEFAULT 0										COMMENT 'Flag / Indicator if Report is a teaser Report',
	REPORT_TYPE_FG		SMALLINT					DEFAULT 0										COMMENT 'Flag / Indicator if a Report is a RSD or Visual Insight Report',

	REPORT_PANEL_NAME	VARCHAR																		COMMENT 'Technical Field: MicroStrategy internal Panel Name',
	REPORT_PANEL_PSKEY	VARCHAR																		COMMENT 'Technical Field: MicroStrategy internal Panel Stack Key PSKEY',
	REPORT_PANEL_PKEY	VARCHAR																		COMMENT 'Technical Field: MicroStrategy internal Panel Key',

    -- Versioning
	VALID_FROM_DT		DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_1-DD')		COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT			DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_1-DD')		COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR			INTEGER			NOT NULL	DEFAULT 0										COMMENT 'Technical Field: Version NUMBER of record ; Sequence starting from 0',
	CURRENT_FG			SMALLINT		NOT NULL	DEFAULT 1										COMMENT 'Technical Field 1 indicates the current record in case of several version',

    -- Technical fields								
	REJECT_FG			SMALLINT		NOT NULL	DEFAULT 0										COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID	INTEGER			NOT NULL	DEFAULT -1										COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID	INTEGER			NOT NULL	DEFAULT 0										COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG			SMALLINT		NOT NULL	DEFAULT 0										COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS		TIMESTAMP		NOT NULL 	DEFAULT CURRENT_TIMESTAMP()						COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS		TIMESTAMP																	COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID				INTEGER			NOT NULL 	DEFAULT 0										COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (REPORT_ID, VALID_FROM_DT, DELETED_FG)
)COMMENT='Control Table - Table of Content (ToC) parameters used within PIT MicroStrategy reporting'
;