/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for P_LEW_MART_PIT.V_SOURCE_WAWI_ITEM_PRICE_2
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_WAWI_ITEM_PRICE_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-12-09 Nikolai Toknov		Initial version
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001; -- new Clone
USE SCHEMA 		P_LEW_MART_PIT_2;
 */
/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_WAWI_ITEM_PRICE_2
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_WAWI_ITEM_PRICE_2
AS
    SELECT DISTINCT
   		 pp.CLIENT_ID
		,pp.ITEM_SID
		,pp.PRICEGROUP_ID
		,pp.DAT_VALID_FROM
		,pp.DAT_VALID_UNTIL
		--,iff(pp.DAT_VALID_FROM = '2002-01-01'::DATE,'1900-01-01'::DATE,pp.DAT_VALID_FROM) 	AS DAT_VALID_FROM
		--,iff(pp.DAT_VALID_UNTIL = '2200-01-01'::DATE,'9999-12-31'::DATE,pp.DAT_VALID_UNTIL) 	AS DAT_VALID_UNTIL
		,pp.VAT_ID
		,vat.VAT_DESC
   		,vat.PCT_VAT
   		,DIV0(COALESCE(vat.pct_vat,0.0),100.00)::NUMBER(38,5)              									AS VAT_FACTOR
		
		,pp.TARE_CD
		,pp.PRICE_RETAIL 																					AS ITEM_UNIT_PRICE_GROSS
		,COALESCE(pp.PRICE_RETAIL_NET,P_LEW_MART_PIT.f_gross2net(pp.PRICE_RETAIL,VAT_FACTOR))				AS ITEM_UNIT_PRICE_NET
		,pp.VAL_REFUND
		,pp.VAL_NET_REFUND
		,pp.VAL_BEVERAGE_TAX
		,pp.LOAD_ID 
   	FROM P_LEW_CORE.T_WAWI_ITM_PRICE_2 pp 
   	
	-- Vat Code to calculate net price
   	LEFT JOIN 
	(
		SELECT
			  CLIENT_ID
			, VAT_ID
			, VAT_DESC
			, PCT_VAT
		FROM P_LEW_CORE.T_WAWI_REF_VAT_2 
		WHERE TRUE
			AND CLIENT_ID = LANGUAGE_ID
			-- Latest Record is selected
			AND DAT_REC_END = '9999-12-31'::DATE	
		GROUP BY 1,2,3,4
		) vat 
   	ON TRUE
   		AND vat.CLIENT_ID 		= 	pp.CLIENT_ID
   		AND vat.VAT_ID 			= 	pp.VAT_ID
   		    			
   	WHERE TRUE
   		AND pp.DAT_VALID_FROM 	IS NOT NULL 
   		--AND pp.dat_valid_from != '2200-01-01'::DATE -- REMOVE UNKNOWN date
   		AND pp.dat_valid_until 	IS NOT NULL 
   		--AND pp.dat_valid_until != '2200-01-01'::DATE -- REMOVE UNKNOWN date 
   		AND pp.DAT_VALID_FROM 	<= pp.DAT_VALID_UNTIL
;