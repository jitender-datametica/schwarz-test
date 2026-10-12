/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_WAREHOUSE
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Warehouse
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-11 Massimo Morelli  Initial version
#  2.0	2022-07-13 Nikolai Toknov  	Changing the script for DevOps
#  2.1  2022-07-17 Andreas Kurz		Removed VARCHAR(150) --> VARCHAR
#  2.1  2024-04-15 Nikolai Toknov   Fix issue DDLvsGIT
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
WAREHOUSE_MSTR_SID
WAREHOUSE_MSTR_GID
ORIG_WH_NR_NAME
*/

CREATE TABLE   P_LEW_MART_PIT.T_DIM_WAREHOUSE_2 CLUSTER BY (CLIENT_ID, WAREHOUSE_SID)(
	CLIENT_ID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g. 1=>AT',
	COUNTRY_ISO_CD		VARCHAR(3) 																COMMENT 'Country_2 ISO Code = WAWI Country_2 ',
	COUNTRY_DESCR		VARCHAR 																COMMENT 'Country_2 Name',

	WAREHOUSE_SID		INTEGER			NOT NULL 												COMMENT 'Sid for warehouse',
	WAREHOUSE_GID		INTEGER IDENTITY(1,1)                                                   COMMENT 'key identity. NOT A PK',
	WAREHOUSE_NAME		VARCHAR 																COMMENT 'Warehouse name',

	ORIG_WH_NR			INTEGER		 															COMMENT 'Original Wahrehouse NUMBER  / code from Wawi',

	REGION_TYPE_ID		VARCHAR(3)				 												COMMENT 'Standard (STD) or Individual region_2 (IND)',
	REGION_TYPE_DESCR	VARCHAR 																COMMENT 'Region_2 Type Description',

	VALID_FROM_DT		DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_2-DD') COMMENT 'Versioning: valid from',
	VALID_TO_DT			DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_2-DD') COMMENT 'Versioning: valid to',
	VERSION_NR			INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Versioning: version nr',
	CURRENT_FG			SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Versioning: current flag: 1-->current version ; 0-->not current version',
	SCD_KEY_MD			VARCHAR(32)				 												COMMENT 'Slowly Changing Dimension (SCD) MD Key. Tracking the version relevant columns',

    -- Technical fields
	REJECT_FG			SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID	INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID	INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG			SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS		TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID				INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, WAREHOUSE_SID, VALID_FROM_DT, DELETED_FG)
)	COMMENT='Dimension table for Region_2'
;