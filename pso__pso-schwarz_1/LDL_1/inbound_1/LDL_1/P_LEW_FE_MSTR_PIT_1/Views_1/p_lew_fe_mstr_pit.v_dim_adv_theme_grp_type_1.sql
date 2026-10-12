/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_ADV_THEME_GRP_TYPE
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar_1 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0	2023-06-26 Nikolai Toknov	INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status_1
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_THEME_GRP_TYPE_1
COMMENT = 'View Dimension Action Type'
AS
SELECT
	  typ.THEME_GRP_TYPE_ID			
	, typ.FE_MSTR_RELEVANT_FG		
	, typ.THEME_GRP_TYPE_SORT_VAL	
	, typ.THEME_GRP_TYPE_NAME		
	, typ.THEME_GRP_TYPE_DESCR		
	, typ.VALID_FROM_DT			
	, typ.VALID_TO_DT				
	, typ.VERSION_NR				
	, typ.CURRENT_FG				
	, typ.REJECT_FG				
	, typ.REJECT_REASON_ID		
	, typ.DELETED_FG				
	, typ.DWH_CREATED_TS			
	, typ.DWH_UPDATED_TS			
	, typ.LOAD_ID										
FROM P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP_TYPE_1 typ
WHERE TRUE
	AND typ.DELETED_FG 	= 0
	AND typ.REJECT_FG	= 0
	AND typ.CURRENT_FG	= 1
	
QUALIFY VERSION_NR = MAX(typ.VERSION_NR) OVER (PARTITION BY typ.THEME_GRP_TYPE_ID)
;	

--SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_THEME_GRP_TYPE_1 LIMIT 1;


/* --- EOF - END OF FILE --- */

