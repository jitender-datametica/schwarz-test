/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_REL_NAN_IFG_UWG_WGI_2
#-------------------------------------------------------------------------------
# Describtion: Create DDL for original item_2			NUMBER dimension table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-09-06 Prasanna Ranjan    	Initial version
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
ORIG_ITEM_MSTR_NR
ORIG_ITEM_MSTR_GID
ITEM_FAM_GRP_MSTR_SID
ITEM_FAM_GRP_MSTR_GID
SUB_ITEM_GRP_MSTR_SID
SUB_ITEM_GRP_MSTR_GID
ITEM_GRP_INT_MSTR_SID
ITEM_GRP_INT_MSTR_GID

*/

CREATE TABLE P_LEW_MART_PIT.T_REL_NAN_IFG_UWG_WGI_2 CLUSTER BY (CLIENT_ID)(
	CLIENT_ID				INTEGER			NOT NULL	DEFAULT -1 										COMMENT 'Client ID e.g. 1=>AT',
	COUNTRY_ISO_CD			VARCHAR(3) 																	COMMENT 'Country_2 ISO Code = WAWI Country_2 ',
	COUNTRY_DESCR			VARCHAR 																	COMMENT 'Country_2 Name',

	-- NAN
	ORIG_ITEM_NR			INTEGER			NOT NULL 													COMMENT 'Sid for original item_2 nr (NaN)',

	ORIG_ITEM_GID			INTEGER		 autoincrement 													COMMENT 'key identity. NOT A PK',
	DAT_VALID_FROM			DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_2-DD') 	COMMENT 'Birthdate of item_2',

	NAN_VALID_FROM_DT		DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_2-DD') 	COMMENT 'Versioning: valid from',
	NAN_VALID_TO_DT			DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_2-DD') 	COMMENT 'Versioning: valid to',
	NAN_VERSION_NR			INTEGER			NOT NULL	DEFAULT 0 										COMMENT 'Versioning: version nr',

	-- IFG
	ITEM_FAM_GRP_SID		INTEGER			NOT NULL 													COMMENT 'Sid for item_2 family group. (UWG)',
	ITEM_FAM_GRP_GID		INTEGER IDENTITY(1,1)														COMMENT 'key identity. NOT A PK',

	IFG_VALID_FROM_DT		DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_2-DD') 	COMMENT 'Versioning: valid from',
	IFG_VALID_TO_DT			DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_2-DD') 	COMMENT 'Versioning: valid to',
	IFG_VERSION_NR			INTEGER			NOT NULL	DEFAULT 0 										COMMENT 'Versioning: version nr',

	-- UWG
	SUB_ITEM_GRP_SID		INTEGER			NOT NULL 													COMMENT 'Sid for item_2 sub group. (UWG)',
 	SUB_ITEM_GRP_GID		INTEGER IDENTITY(1,1)														COMMENT 'key identity. NOT A PK',

	UWG_VALID_FROM_DT		DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_2-DD') 	COMMENT 'Versioning: valid from',
	UWG_VALID_TO_DT			DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_2-DD') 	COMMENT 'Versioning: valid to',
	UWG_VERSION_NR			INTEGER			NOT NULL	DEFAULT 0 										COMMENT 'Versioning: version nr',

	-- WGI
	ITEM_GRP_INT_SID		INTEGER			NOT NULL 													COMMENT 'Sid for item_2 international group',
	ITEM_GRP_INT_GID		INTEGER		 autoincrement 													COMMENT 'key identity. NOT A PK',

	WGI_VALID_FROM_DT		DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_2-DD') 	COMMENT 'Versioning: valid from',
	WGI_VALID_TO_DT			DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_2-DD') 	COMMENT 'Versioning: valid to',
	WGI_VERSION_NR			INTEGER			NOT NULL	DEFAULT 0 										COMMENT 'Versioning: version nr',

    -- Technical fields
	REJECT_FG				SMALLINT		NOT NULL	DEFAULT 0 										COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID		INTEGER			NOT NULL	DEFAULT -1 										COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID		INTEGER			NOT NULL	DEFAULT -1 										COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG				SMALLINT		NOT NULL	DEFAULT 0 										COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	LOAD_ID					INTEGER			NOT NULL	DEFAULT 0 										COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, ORIG_ITEM_NR, ITEM_FAM_GRP_SID, SUB_ITEM_GRP_SID, ITEM_GRP_INT_SID, DELETED_FG)
)	COMMENT='Relation Table for NAN, IFG, UWG and WGI'
;