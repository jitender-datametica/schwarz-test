/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_REGION_HIER
#-------------------------------------------------------------------------------
# Describtion: Create DDL for flattened and Daily sliced Region Dimension
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-07-26 Mike Davis      	Some tweaks, extra	NOT NULLs and warehouse_mstr_sid.
#  1.2  2021-08-20 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  1.4  2022-02-11 Andreas Kurz		Added new column GEO_INFO_FG, STORE_LONGITUDE, STORE_ALTIDUDE
#  1.5  2022-02-13 Nikolai Toknov	Cosmetic changes
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
WAREHOUSE_MSTR_SID
*/

CREATE TABLE P_LEW_MART_PIT.T_DIM_REGION_HIER CLUSTER BY (CLIENT_ID, DAY_DT)(
	DAY_DT					DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD')	COMMENT 'Calendar Day of the daily sliced flattened store-region hierarchy',

	CLIENT_ID				INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g. 1=>AT',
	COUNTRY_ISO_CD			VARCHAR(3) 																COMMENT 'Country ISO Code = WAWI Country ',
	COUNTRY_DESCR			VARCHAR 																COMMENT 'Country Name',

	STORE_SID				INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Surrogate ID For Store L1 Note: We need to investigate which field to use move_to_store_sid vs. store_sid',
	STORE_NAME				VARCHAR 																COMMENT 'Store name',
	ORIG_STORE_NR			INTEGER		 															COMMENT 'Original Store NUMBER / code from Wawi',

	-- AKU 2021-07-26
	STORE_SALES_FG			SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag / Indicator if Store had a sales on the day. (from POS)',

	-- AKU 2022-02-10
	GEO_INFO_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag / indicator if the Store have a valid Longitude and Altidue Coordinates',
	STORE_LONGITUDE			NUMBER(38,5) 															COMMENT 'Lonitude of the Store',
	STORE_LATITUDE			NUMBER(38,5) 															COMMENT 'Altidue of the Store',

	WAREHOUSE_SID			INTEGER						DEFAULT -1 									COMMENT 'Warehouse Surrogate ID L2',
	WAREHOUSE_NAME			VARCHAR 																COMMENT 'Warehouse Name',
	ORIG_WH_NR				INTEGER		 															COMMENT 'Original Wahrehouse NUMBER  / code from Wawi',

	SUB_REGION_SID			INTEGER						DEFAULT -1 									COMMENT '[Future Use] Sub Region L3. e.g. DE=23 L3 = S1 (süd 1)',
	SUB_REGION_NAME			VARCHAR 																COMMENT 'Description of Sub_Region',

	MAIN_REGION_SID			INTEGER						DEFAULT -1 									COMMENT '[Future use]: Main Region L4. e.g. DE=23 S (Süd)',
	MAIN_REGION_NAME		VARCHAR 																COMMENT 'Description of Main Region',

	REGION_TYPE_ID			CHAR(3)						DEFAULT 'STD' 								COMMENT 'Standard (STD) or Individual region(IND)',
	REGION_TYPE_DESCR		VARCHAR						DEFAULT 'Standard' 							COMMENT 'Region Type Description',

	CLOSED_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag / indicator if the Store is Closed',
	TEST_STORE_FG			SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag / indicator if the Store is a Test Store',
	DUMMY_STORE_FG			SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag / indicator if the Store is a Dummy Store',
	TEMPLATE_STORE_FG		SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag / indicator if the Store is a Template Store',

	REAL_OPENING_DT			DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'Flag / indicator if the Store Real Opening DATE. Unknown			DATEs will be transalted to 8888-12-31',
	OPENING_DT				DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'Flag / indicator if the Store Opening DATE. Unknown			DATEs will be transalted to 8888-12-31',
	CLOSING_DT				DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'Flag / indicator if the Store Closing DATE. Unknown			DATEs will be transalted to 8888-12-31',

	--  Technical Fields
	REJECT_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID		INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID		INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS			TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID					INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (DAY_DT, CLIENT_ID, STORE_SID, DELETED_FG)
)	COMMENT='Dimension table flattened store-region hierarchy'
;