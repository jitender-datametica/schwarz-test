/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for v_source_sfo_store_form
#-------------------------------------------------------------------------------
# Describtion: Create View for v_source_currency_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-01-05 Andreas Kurz		   	Initial version 
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_MART_PIT_2;
*/

CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_CURRENCY_2
COMMENT = 'Source View for Currency'
AS
	SELECT
		  loc_cur.CLIENT_ID				AS CLIENT_ID
		, cl.COUNTRY_ISO_CD				AS COUNTRY_ISO_CD
		, cl.LANG_SID					AS LANG_SID
		
		, loc_cur.CURR_SID				AS CURR_SID
		, loc_cur.CURR_CD				AS CURR_CD
		, exc_cur.X_RATE_TYPE_SID
		, exc_cur.EXCHANGE_RATE_TO_EUR
		
		, loc_cur.ACTIVE_FROM_DT		AS VALID_FROM_DT
		, loc_cur.ACTIVE_TO_DT			AS VALID_TO_DT
	FROM
	(
	SELECT 
		  CLIENT_ID
		, CURR_SID_FROM 		AS CURR_SID
		, CURR_CD_FROM 			AS CURR_CD
		, X_RATE_TYPE_SID
		, ACTIVE_FROM_DT
		, ACTIVE_TO_DT
	FROM
		P_LEW_CORE.T_EXCHANGE_RATE_KNOWN_HIST_2
	WHERE TRUE 
		AND DELETED_FG 		= 0 
		AND CURR_SID_FROM 	= CURR_SID_TO 
		
		AND ACTIVE_TO_DT	> '2019-01-01'::DATE
				
		-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER (PARTITION BY CLIENT_ID, CURR_SID, X_RATE_TYPE_SID, ACTIVE_FROM_DT ORDER BY DWH_UPDATED DESC) = 1
	) loc_cur
	
	-- exchange Rate to EUR
	INNER JOIN
	(
	SELECT 
		  CLIENT_ID
		, X_RATE_TYPE_SID
		, EXCHANGE_RATE 		AS EXCHANGE_RATE_TO_EUR
		, CURR_SID_FROM 		AS CURR_SID
		, ACTIVE_FROM_DT
		, ACTIVE_TO_DT
		, CURR_CD_TO
		, DWH_UPDATED
		--SELECT *
	FROM
		P_LEW_CORE.T_EXCHANGE_RATE_KNOWN_HIST_2
	WHERE TRUE 
		AND DELETED_FG 		= 0 
		AND CURR_CD_TO      = 'EUR'
	
		AND ACTIVE_TO_DT	> '2019-01-01'::DATE	

		-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER (PARTITION BY CLIENT_ID, CURR_SID, X_RATE_TYPE_SID, ACTIVE_FROM_DT ORDER BY DWH_UPDATED DESC) = 1		
	) exc_cur
	ON TRUE
		AND exc_cur.CLIENT_ID 		= loc_cur.CLIENT_ID
		AND exc_cur.CURR_SID		= loc_cur.CURR_SID
		
		AND exc_cur.X_RATE_TYPE_SID	= loc_cur.X_RATE_TYPE_SID
		
		-- time overlap
		AND exc_cur.ACTIVE_FROM_DT  >= loc_cur.ACTIVE_FROM_DT
		AND exc_cur.ACTIVE_TO_DT	<= loc_cur.ACTIVE_TO_DT
		
   	-- Restrict the nbr of touched rows
    INNER JOIN 
    		-- Country_2 Information
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
		FROM P_LEW_MART_PIT.T_DIM_CLIENT_2 
		WHERE TRUE 
			AND PIT_COUNTRY_FG 			= 1 
			
			AND DELETED_FG 				= 0 
			AND REJECT_FG 				= 0 
			AND CURRENT_FG 				= 1 
	) cl
    ON TRUE
    	AND cl.CLIENT_ID = exc_cur.CLIENT_ID
WHERE TRUE
--	AND  VALID_FROM_DT = '9999-12-31'::DATE

    QUALIFY ROW_NUMBER() OVER (PARTITION BY loc_cur.CLIENT_ID, loc_cur.CURR_SID ORDER BY loc_cur.ACTIVE_FROM_DT DESC) = 1
;		