/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_SUB_ITEM_GRP
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Item_2 Group Dimension Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-10 Massimo Morelli    	Initial version
#  2.0	2022-07-13 Nikolai Toknov  		Changing the script for DevOps
#  2.1 	2022-07-18 Andreas Kurz			Changed VARCHAR(150)-->VARCHAR
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
SUB_ITEM_GRP_MSTR_SID
SUB_ITEM_GRP_MSTR_GID

*/

CREATE TABLE P_LEW_MART_PIT.T_DIM_SUB_ITEM_GRP_2 CLUSTER BY (CLIENT_ID, SUB_ITEM_GRP_SID)(
	CLIENT_ID				INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g. 1=>AT',
	COUNTRY_ISO_CD			VARCHAR(3) 																COMMENT 'Country_2 ISO Code = WAWI Country_2 ',
	COUNTRY_DESCR			VARCHAR 																COMMENT 'Country_2 Name',

	SUB_ITEM_GRP_SID		INTEGER			NOT NULL 												COMMENT 'Sid for item_2 sub group. (UWG)',
	SUB_ITEM_GRP_GID		INTEGER IDENTITY(1,1)													COMMENT 'key identity. NOT A PK',
	SUB_ITEM_GRP_NAME		VARCHAR		 															COMMENT 'Item_2 sub group name.',
	SUB_ITEM_GRP_SRC_CD		VARCHAR		 															COMMENT 'Item_2 sub group Wawi Source Code. Business Key',
	SUB_ITEM_GRP_DESCR		VARCHAR		 															COMMENT 'Item_2 sub group description (local)',
	SUB_ITEM_GRP_INT_DESCR	VARCHAR		 															COMMENT 'Item_2 sub group description (international)',
	ITEM_GRP_INT_SID		INTEGER																	COMMENT 'Sid for item_2 international group',
	
	VALID_FROM_DT			DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_2-DD') COMMENT 'Versioning: valid from',
	VALID_TO_DT				DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_2-DD') COMMENT 'Versioning: valid to',
	VERSION_NR				INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Versioning: version nr',
	CURRENT_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Versioning: current flag: 1-->current version ; 0-->not current version',
	SCD_KEY_MD				CHAR(32) 																COMMENT 'Slowly Changing Dimension (SCD) MD Key. Tracking the version relevant columns',

	 -- Technical fields
	REJECT_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID		INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID		INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS			TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID					INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, SUB_ITEM_GRP_SID, VALID_FROM_DT, DELETED_FG)
)	COMMENT='Dimension table for Sub Item_2 Group'
;