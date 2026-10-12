/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_CLIENT
#-------------------------------------------------------------------------------
# Description: Create DDL for Client Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-20 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.2  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  1.3  2022-02-10 Andreas kurz		Removed COUTRY_GROUP columns not needed any more
#									Parallel execution will be done by client_id and Data_size param
#  1.4  2022-02-16 Andreas Kurz 	Added EXCHANGE_RATE_TO_EUR
#  1.5  2022-06-01 Andreas Kurz 	Added COUNTRY_ORIG_DESCR COUNTRY_DESCR represent in Germna Language
#  1.6  2022-08-25 Andreas Kurz		Added CTR_STORE_NBR used for paralell execution
#-------------------------------------------------------------------------------
*/

/*
---------------------------------------------------------------------
0. Create DIM Table in T_DIM_CLIENT_2
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_MART_PIT_2;
DROP TABLE P_LEW_MART_PIT.T_DIM_CLIENT_2; 
ALTER TABLE P_LEW_MART_PIT.T_DIM_CLIENT_2
ADD CTR_STORE_NBR								NUMBER(38,5)		NOT NULL 		DEFAULT -1										COMMENT 'Countrie Number of Stores, see also Param , needed for parallel processing'
;

------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_MART_PIT.T_DIM_CLIENT_2 CLUSTER BY (CLIENT_ID)(
	CLIENT_ID 									INTEGER		 		NOT NULL 		DEFAULT -1 										COMMENT 'Client ID e.g. 1=>AT',
	COUNTRY_ISO_CD 								VARCHAR(3) 			NOT NULL 		DEFAULT 'INT' 									COMMENT 'Country_2 ISO Code = WAWI Country_2 ',
	COUNTRY_DESCR 								VARCHAR			 	NOT NULL 		DEFAULT 'Lidl International' 					COMMENT 'Country_2 Name (Language German)',
	COUNTRY_ORIG_DESCR 							VARCHAR			 	NOT NULL 		DEFAULT 'Lidl International' 					COMMENT 'Country_2 Name Orginal from Source',
	COUNTRY_NAT_DESCR							VARCHAR			 	NOT NULL 		DEFAULT 'Lidl International' 					COMMENT 'Country_2 Name - national (Local Language)',
	COUNTRY_INT_DESCR							VARCHAR			 	NOT NULL 		DEFAULT 'Lidl International' 					COMMENT 'Country_2 Name - international (Language German)',
	LANG_SID 									INTEGER		 		NOT NULL 		DEFAULT -1 										COMMENT '[FK]: to Language SID ',
	CURR_SID 									INTEGER		 		NOT NULL 		DEFAULT -1 										COMMENT '[FK] Unique Currency SID based Local Currency of Lidl Country_2',
	CURR_CD 									VARCHAR			 																	COMMENT 'Currency Code',
	EXCHANGE_RATE_TO_EUR 						NUMBER(38,5) 		NOT NULL 		DEFAULT 1 										COMMENT 'Exchange Rate to EUR',
	CTR_ADV_WEEK_START_WEEKDAY_ID 				INTEGER		 		NOT NULL 		DEFAULT -1 										COMMENT 'Start Day of the Adv-Week ID e.g. BE = 1, CH=4. Please see also the PIT_PARAM',
	CTR_STORE_NBR								NUMBER(38,5)		NOT NULL 		DEFAULT -1										COMMENT 'Countrie Number of Stores, see also Param , needed for parallel processing',
	CTR_EX_ELVIS_COUNTRY_FG 					SMALLINT	 		NOT NULL 		DEFAULT -1 										COMMENT 'Flag / Indicator if the Country_2 was migrated from SAP (ELWIS) to WaWi. This true for Norther Ireland, Austria and Serbia. Please see also the PIT_PARAM',
	CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_FROM 	DATE				NOT NULL 		DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 	COMMENT 'Ex Elivs Country_2 Migration Date From (von)',
	CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_TO 		DATE				NOT NULL 		DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 	COMMENT 'Ex Elivs Country_2 Migration Date To (bis)',
	PIT_COUNTRY_FG 								SMALLINT	 		NOT NULL 		DEFAULT -1 										COMMENT 'Flag / Indicator indicating 1::= PIT Country. Please see also the PIT_PARAM',
	VALID_FROM_DT 								DATE 				NOT NULL 		DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_2-DD') 	COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT 								DATE 				NOT NULL 		DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_2-DD') 	COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR 									INTEGER		 		NOT NULL 		DEFAULT 0 										COMMENT 'Technical Field: Version Number of record ; Sequence starting from 0',
	CURRENT_FG 									SMALLINT	 		NOT NULL 		DEFAULT 1 										COMMENT 'Technical Field 1 indicates the current record in case of several version',
	REJECT_FG 									SMALLINT	 		NOT NULL 		DEFAULT 0 										COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID 							INTEGER		 		NOT NULL 		DEFAULT -1 										COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID 							INTEGER		 		NOT NULL 		DEFAULT 0 										COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG 									SMALLINT	 		NOT NULL 		DEFAULT 0 										COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS 								TIMESTAMP		 	NOT NULL 		DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS 								TIMESTAMP		 																	COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID 									INTEGER		 		NOT NULL 		DEFAULT 0 										COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, VALID_FROM_DT, DELETED_FG)
)COMMENT='PIT Dimension table client / country.'
;