/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for P_LEW_MART_PIT.V_SOURCE_PV_PRICE_CHANGE_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_PV_PRICE_CHANGE_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-01-04 Andreas Kurz		Initial version
#									No additional Logic included
#  1.1 	2024-08-08 Andreas Kurz		Distinct was removed
#  1.2  2025-01-28 Nikolai Toknov	Restore view
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001; -- new Clone
USE SCHEMA 		P_LEW_MART_PIT_1;
 */
/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_PV_PRICE_CHANGE_1
------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_PV_PRICE_CHANGE_1
COMMENT = 'PIT Source View for PV Price Change Table'
AS
    SELECT 
    	  pc.CLIENT_ID
		, pc.STORE_SID
		, pc.DAY_DT
		, pc.ORIG_ITEM_NR
		, pc.ITEM_SID
		, pc.PCWO_REASON_ID
		, pc.PCWO_REASON_DESC

		, pc.PCH_DAY_PRICEGROUP_FG
		, pc.DISCOUNT_VALUE_PROMODESIGNER
		, pc.DISCOUNT_VALUE_LIDLPLUS
		, pc.PCH_BASELINE_FG

		, pc.DWH_CREATED_TS
		, pc.DWH_UPDATED_TS  
    FROM
		(
			SELECT 
    			  CLIENT_ID
				, LOC_SID_STORE								AS STORE_SID
				, DWH_CAL_DT								AS DAY_DT
				, ORIG_ITEM_NR
				, ITEM_SID
				, PCWO_REASON_ID
				, PCWO_REASON_DESC
				
				, PCH_DAY_PRICEGROUP_FG
				, DISCOUNT_VALUE_PROMODESIGNER
				, DISCOUNT_VALUE_LIDLPLUS
				, PCH_BASELINE_FG
				, DWH_LOAD_ID
				, DWH_CREATED AS DWH_CREATED_TS
				, DWH_UPDATED AS DWH_UPDATED_TS 
    		FROM P_LEW_BIL.T_STORE_DAY_ITEM_PRICE_CHANGE_1    	
		) pc
    		    
    	-- Adv.Week restrict the nbr of touched rows
    	INNER JOIN 
    			-- Country_1 Information
		(	
			SELECT DISTINCT 
				  CLIENT_ID
				, COUNTRY_ORIG_DESCR
				, COUNTRY_INT_DESCR    
				, COUNTRY_NAT_DESCR
				, COUNTRY_DESCR
				, COUNTRY_ISO_CD
				, LANG_SID
				, CURR_SID
				, CURR_CD
				, EXCHANGE_RATE_TO_EUR
				, VALID_FROM_DT
				, CTR_EX_ELVIS_COUNTRY_FG
				, CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_FROM
				, CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_TO
				, CTR_ADV_WEEK_START_WEEKDAY_ID
			FROM P_LEW_MART_PIT.T_DIM_CLIENT_1 
			WHERE TRUE 
				AND PIT_COUNTRY_FG 			= 1 
				
				AND DELETED_FG 				= 0 
				AND REJECT_FG 				= 0 
				AND CURRENT_FG 				= 1 
		) cl
    	ON TRUE
    		AND cl.CLIENT_ID = pc.CLIENT_ID
    	
    	

    WHERE TRUE	
;
--SELECT * FROM LDL_PRODUCTION_CLONE_PIT_R60001_CLONE_TEST.P_LEW_MART_PIT.V_SOURCE_PV_PRICE_CHANGE_1 WHERE CLIENT_ID = 1 AND STORE_SID = 205 AND DAY_DT = '2024-01-12' LIMIT 100
--SELECT CLIENT_ID, PCWO_REASON_ID, PCWO_REASON_DESC, COUNT(DISTINCT ORIG_ITEM_NR) AS _RECNBR FROM P_LEW_MART_PIT.V_SOURCE_PV_PRICE_CHANGE_1 WHERE TRUE GROUP BY 1,2,3 ORDER BY 1,2,3