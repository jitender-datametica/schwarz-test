/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ORIG_ITEM
#-------------------------------------------------------------------------------
# Describtion: Create DDL for original item_1			NUMBER dimension table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-11 Massimo Morelli    	Initial version
#  1.1  2022-05-30 Massimo Morelli    	Changed type of ORIG_ITEM_MSTR_NR
#  1.1  2022-05-30 Massimo Morelli    	Changed type of SCD_MD5, added ATTR_SEQ
#  1.2  2022-06-20 Prasanna Ranjan		Added DAT_VALID_FROM
#  2.0	2022-07-13 Nikolai Toknov  		Changing the script for DevOps
#  2.1  2022-07-18 Andreas Kurz			Changed VARCHAR(100) --> VARCHAR
#  2.2  2023-07-07 Andreas Kurz			Added BRAND_NAME and BRAND_TYPE_CD
#  3.0  2024-02-14 Prasanna Ranjan		Added new columns for PIT Increment 2 (PV)
#  4.0  2024-03-25 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
ORIG_ITEM_MSTR_NR
ORIG_ITEM_MSTR_GID

*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT;

ALTER TABLE P_LEW_MART_PIT.T_DIM_ORIG_ITEM_1
ADD BRAND_NAME			VARCHAR 																COMMENT 'Brand_1 name.'
;
ALTER TABLE P_LEW_MART_PIT.T_DIM_ORIG_ITEM_1
ADD BRAND_TYPE_CD		VARCHAR 																COMMENT 'Brand_1 type. Marke M or Eigenmarke EM'
;
*/


CREATE TABLE P_LEW_MART_PIT.T_DIM_ORIG_ITEM_1 CLUSTER BY (CLIENT_ID)(
	CLIENT_ID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g. 1=>AT',
	COUNTRY_ISO_CD		VARCHAR(3) 																COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR		VARCHAR 																COMMENT 'Country_1 Name',

	ORIG_ITEM_NR		INTEGER			NOT NULL 												COMMENT 'Sid for original item_1 nr (NaN)',
--	ORIG_ITEM_MSTR_NR	INTEGER		 AS (
--										IFF(ORIG_ITEM_NR < 0,
--											(ORIG_ITEM_NR * 100) - CLIENT_ID,
--											(ORIG_ITEM_NR * 100) + CLIENT_ID
--											)
--										) 														COMMENT 'Sid for original item_1 nr (NaN) * 100 +/- CLIENT_ID e.g. for client AT (1) and ORIG_ITEM_NR 1000 -> 100001, for ORIG_ITEM_NR -1000 -> -100001',
--
	-- WARNING: THIS IS NOT PK
	ORIG_ITEM_GID		INTEGER		 autoincrement 												COMMENT 'key identity. NOT A PK',
--	ORIG_ITEM_MSTR_GID	INTEGER		 AS (
--										IFF(ORIG_ITEM_GID < 0,
--											(ORIG_ITEM_GID * 100) - CLIENT_ID,
--											(ORIG_ITEM_GID * 100) + CLIENT_ID
--											)
--										) 														COMMENT 'Technical Field: MSTR GID',
	DAT_VALID_FROM		DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_1-DD') COMMENT 'Birthdate of item_1',

	ITEM_NAME			VARCHAR 																COMMENT '(short) item_1 name in local language',
	ITEM_DESCR			VARCHAR 																COMMENT '(long) item_1 description in local language',
	ITEM_INT_DESCR		VARCHAR 																COMMENT '(long) item_1 description in international language of centre (Deutsch)',

	ITEM_FAM_GRP_SID	INTEGER		 															COMMENT 'Sid for item_1 family group.',
	SUB_ITEM_GRP_SID	INTEGER		 															COMMENT 'Sid for sub item_1 group.',
	ITEM_GRP_INT_SID	INTEGER		 															COMMENT 'Sid for item_1 group int.',
	BRAND_SID			INTEGER		 															COMMENT 'Sid for brand_1 of item.',
	BRAND_NAME			VARCHAR 																COMMENT 'Brand_1 name.',
	BRAND_TYPE_CD		VARCHAR 																COMMENT 'Brand_1 type. Marke M or Eigenmarke EM',

	VALID_FROM_DT		DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_1-DD') COMMENT 'Versioning: valid from',
	VALID_TO_DT			DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_1-DD') COMMENT 'Versioning: valid to',
	VERSION_NR			INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Versioning: version nr',
	CURRENT_FG			SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Versioning: current flag: 1-->current version ; 0-->not current version',

	SCD_KEY_MD			CHAR(32) 																COMMENT 'Slowly Changing Dimension (SCD) MD Key. Tracking the version relevant columns',

    -- Technical fields
	REJECT_FG			SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID	INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID	INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG			SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS		TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID				INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, ORIG_ITEM_NR, DAT_VALID_FROM, DELETED_FG)
)	COMMENT='Dimension table for Orig Item_1 _ MSTR use only'
;