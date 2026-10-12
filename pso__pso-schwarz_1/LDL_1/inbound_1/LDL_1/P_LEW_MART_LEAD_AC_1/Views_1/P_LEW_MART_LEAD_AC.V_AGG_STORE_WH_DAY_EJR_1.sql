/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG
#-------------------------------------------------------------------------------
# Interface : DDL for V_AGG_STORE_WH_DAY_EJR_1
#-------------------------------------------------------------------------------
# Description:  This view provides aggregated Umsatz, Umsatz for Food and 
#				NonFood and Bon Totals for current and previous year.
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-02-16 Mateusz Rek     	Initial file
#  1.1  2023-02-16 K Lukaszewska   	Comments and edition
#  1.2  2023-04-03 Prasanna Ranjan	Re_1-Desing to access table
#-------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STORE_WH_DAY_EJR_1(
	  CLIENT_ID									COMMENT 'Client ID e.g AT=1'
	, CURRENCY_ISO_CD							COMMENT 'Country_1 ISO Code = WAWI Country_1 '
	, WH_ID										COMMENT 'Warehouse ID'
	, MOVE_TO_STORE_ID							COMMENT 'Unique key Region_1 surrogate key'
	, CY_WEEK									COMMENT 'Number of week, YYYYWW'
	, PREVIOUS_YEAR_FG							COMMENT 'Flag indicating if current year 0 or previous year 1'
	, LAST_12_CY_WEEK_FG						COMMENT	'Flag indicating if in last 12 weeks'
	, VAL_RETURN_NET_EJR_ASIS					COMMENT 'Returns value'
	, VAL_RTL_NET_EJR_ASIS						COMMENT 'Umsatz EJR'
	, VAL_RETURN_NET_EJR_ASIS_NF				COMMENT 'Returns value for NonFood'
	, VAL_RTL_NET_EJR_ASIS_NF					COMMENT 'Umsatz EJR for NonFood'
	, VAL_RETURN_NET_EJR_ASIS_FA				COMMENT 'Returns value for Food Aktion_1'
	, VAL_RTL_NET_EJR_ASIS_FA					COMMENT 'Umsatz EJR for Food Aktion_1'
	, DWH_CREATED_TS							COMMENT 'Timestamp when record was created'
	, DWH_UPDATED_TS							COMMENT 'Technical field timestamp when record was updated'
	, LOAD_ID									COMMENT 'Technical Field ELT / ABInitio Process ID'
)
AS
SELECT
	  CLIENT_ID					
	, CURRENCY_ISO_CD			
	, WH_ID						
	, MOVE_TO_STORE_ID			
	, CY_WEEK					
	, PREVIOUS_YEAR_FG
	, LAST_12_CY_WEEK_FG			
	, VAL_RETURN_NET_EJR_ASIS	
	, VAL_RTL_NET_EJR_ASIS		
	, VAL_RETURN_NET_EJR_ASIS_NF
	, VAL_RTL_NET_EJR_ASIS_NF	
	, VAL_RETURN_NET_EJR_ASIS_FA
	, VAL_RTL_NET_EJR_ASIS_FA	
	, DWH_CREATED_TS			
	, DWH_UPDATED_TS			
	, LOAD_ID					
FROM P_LEW_MART_LEAD.T_AGG_STORE_WH_DAY_EJR_1
;