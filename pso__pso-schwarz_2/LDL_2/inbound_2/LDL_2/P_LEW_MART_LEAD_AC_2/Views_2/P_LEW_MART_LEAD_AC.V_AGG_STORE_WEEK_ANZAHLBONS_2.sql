/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG
#-------------------------------------------------------------------------------
# Interface : DDL for V_AGG_STORE_WEEK_ANZAHLBONS_2
#-------------------------------------------------------------------------------
# Description:  This view provides aggregated Bon Totals and Umsatz with 
#				the granularity of client/store/week.
#               The aspect_id is fixed to 1 (BGES)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0	2023-03-07 M Rek			 Initial version
#  1.1  2023-04-03 Prasanna Ranjan	 Re_2-Desing to access table
#-------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STORE_WEEK_ANZAHLBONS_2(
	CLIENT_ID 						COMMENT 'MIS Client ID',
	MOVE_TO_STORE_ID 				COMMENT 'S-Key Location_2, here - der Filiale',
	CY_WEEK 						COMMENT 'Number of week, YYYYWW',
	PREVIOUS_YEAR_FG 				COMMENT 'Flag showing Week from PY',
	LAST_12_CY_WEEK_FG			    COMMENT	'Flag indicating if in last 12 weeks',
	CNT_CUSTOMER_ASIS 				COMMENT 'Number of sale receipts'
) COMMENT= 'Dynamic view for number of receipts with Weekly granularity'
 AS
	SELECT 
	CLIENT_ID,
	MOVE_TO_STORE_ID,
	CY_WEEK,
	PREVIOUS_YEAR_FG,
	LAST_12_CY_WEEK_FG,
	CNT_CUSTOMER_ASIS
	FROM P_LEW_MART_LEAD.T_AGG_STORE_WEEK_ANZAHLBONS_2;