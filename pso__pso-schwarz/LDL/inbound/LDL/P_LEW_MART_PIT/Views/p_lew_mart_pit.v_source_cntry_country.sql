/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_CNTRY_COUNTRY
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_CNTRY_COUNTRY
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli	   Initial version
#  1.1  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.2  2021-10-11 Dirk Hering         Deduplication from source (Qualify Row Number = 1) descending; ctr.DWH_UPDATED 
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_MART_PIT;
*/

CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_CNTRY_COUNTRY
COMMENT = 'PIT Source View for Lidl Countries'
AS
SELECT
      ctr.COUNTRY_SID::INTEGER                          		AS CLIENT_ID
    , ctr.COUNTRY_NAME::VARCHAR                    				AS COUNTRY_DESCR
    
    , ctr.LANG_SID::INTEGER                             		AS LANG_SID
	, ctr.SRC_COUNTRY_LIDL_CD::VARCHAR(3)						AS COUNTRY_ISO_CD
    
	, COALESCE(cur.CURR_SID,-2)::INTEGER						AS CURR_SID
    , COALESCE(cur.CURR_CD,'n/A')::VARCHAR						AS CURR_CD
	
    -- AKU 2022-02-16 Added Exchange Rate for Param calculation
	, cur.X_RATE_TYPE_SID										AS X_RATE_TYPE_SID
	, COALESCE(cur.EXCHANGE_RATE_TO_EUR, 1.0)::NUMBER(38,5) 	AS EXCHANGE_RATE_TO_EUR    
 	
	-- AKUK 2022-06-15 Ex Elis Countrys
	, COALESCE(clm.MIGRATION_DAT_VALID_FROM, '8888-12-31'::DATE)::DATE
																AS CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_FROM
	, COALESCE(clm.MIGRATION_DAT_VALID_TO, '8888-12-31'::DATE)::DATE
																AS CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_TO																
	, iff (clm.CLIENT_ID IS NOT NULL, 1::SMALLINT, 0::SMALLINT)
																AS CTR_EX_ELVIS_COUNTRY_FG
	, COALESCE(TO_DATE(ctr.DWH_CREATED),'1900-01-01'::DATE)::DATE
																AS VALID_FROM_DT
															
	, TO_DATE('9999-12-31','YYYY-MM-DD')              			AS VALID_TO_DT

	, 0::SMALLINT   		                          			AS DELETED_FG
	, ctr.DWH_UPDATED::TIMESTAMP       	  	            		AS DWH_UPDATED_TS
                
FROM
	(
		SELECT 
			  COUNTRY_SID
			, COUNTRY_NAME
			, LANG_SID
			, SRC_COUNTRY_LIDL_CD
			, DWH_CREATED
			, DWH_UPDATED
		FROM P_LEW_CORE.T_COUNTRY 
		WHERE TRUE 
			AND COUNTRY_SID > 0
			
	    -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER(PARTITION BY COUNTRY_SID ORDER BY DWH_UPDATED DESC) = 1	
	) ctr
	
	-- 	Currency
	LEFT JOIN 
	(
	
		SELECT
			  loc_cur.CLIENT_ID				AS CLIENT_ID
			
			, loc_cur.CURR_SID				AS CURR_SID
			, loc_cur.CURR_CD				AS CURR_CD
	
			, loc_cur.X_RATE_TYPE_SID
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
			P_LEW_CORE.T_EXCHANGE_RATE_KNOWN_HIST
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
			P_LEW_CORE.T_EXCHANGE_RATE_KNOWN_HIST
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
			
		WHERE TRUE
			
	
		QUALIFY ROW_NUMBER() OVER (PARTITION BY loc_cur.CLIENT_ID, loc_cur.CURR_SID ORDER BY loc_cur.ACTIVE_FROM_DT DESC) = 1

	) cur
	ON TRUE
		AND ctr.COUNTRY_SID = cur.CLIENT_ID
		
	-- Ex Elivs Country Migration Date
	LEFT JOIN
	(
		SELECT
			  CLIENT_ID
			, MIGRATION_DAT_VALID_FROM
			, MIGRATION_DAT_VALID_TO
		FROM P_LEW_CORE.T_CLIENT_MIGRATION_PER
		WHERE TRUE
			AND MIGRATION_DAT_VALID_FROM 	<> '9999-12-31'::DATE
			AND ACTIVE_FG 					= 0	
	) clm
	ON TRUE
		AND ctr.COUNTRY_SID = clm.CLIENT_ID
		AND CURRENT_DATE()	BETWEEN cur.VALID_FROM_DT AND cur.VALID_TO_DT
WHERE
	TRUE 	
;
