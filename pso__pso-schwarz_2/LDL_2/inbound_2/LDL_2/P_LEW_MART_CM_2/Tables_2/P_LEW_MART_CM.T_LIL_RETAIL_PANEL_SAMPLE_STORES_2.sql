/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - Category Management 2022
#-------------------------------------------------------------------------------
# Interface : DDL for T_LIL_RETAIL_PANEL_SAMPLE_STORES_2
#-------------------------------------------------------------------------------
# Description: Create DDL for transaction services 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  03.11.2022 Mateusz Rek    Initial version
#  1.1  08.11.2022 Mateusz Rek 	  Removed LOC_SID
#  1.2  01.12.2022 Mateusz Rek 	  Added DATERIME_UPDATED
#-------------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_MART_CM.T_LIL_RETAIL_PANEL_SAMPLE_STORES_2(
	CLIENT_ID		NUMBER (38,0)		NOT NULL 												COMMENT 'Country_2 identifier',
	ORIG_STORE_NR	NUMBER (38,0)		NOT NULL												COMMENT 'Store identifier',
	PARTNER_NAME	VARCHAR (100)		NOT NULL												COMMENT 'Name of partner',
	DATETIME_UPDATED DATETIME																	COMMENT 'Insert/update Timestamp',
	PRIMARY KEY (PARTNER_NAME, CLIENT_ID, ORIG_STORE_NR)
)	COMMENT='Transaction Services Table for Retail Panel'
;