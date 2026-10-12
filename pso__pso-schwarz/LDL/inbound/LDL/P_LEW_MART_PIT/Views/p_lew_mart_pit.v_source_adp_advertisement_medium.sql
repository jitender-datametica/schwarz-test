/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for ADVERTISEMENT_MEDIUM
#-------------------------------------------------------------------------------
# Describtion: Create View for ADVERTISEMENT_MEDIUM
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-09-01 Aparna Rayanki      	Initial version
#  1.1  2021-09-29 Dirk Hering         	Use example role added, data types added, column order, formatting
#  1.2  2021-10-11 Dirk Hering         	Deduplication from source (Qualify Row Number = 1); 
#                                      	Changed to select from source: ch.dwh_updated
#  1.3  2022-03-23 Mike Davis          	Use MD5 for the MEDIUM_SID.
#  1.4  2022-05-27 Andreas Kurz			Reworked View
#  1.5	2024-09-23 Nikolai Toknov		Add schema name for f_CleanString
#-------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_ADP_ADVERTISEMENT_MEDIUM
COMMENT = 'V_SOURCE_ADP_ADVERTISEMENT_MEDIUM'
AS
SELECT
      CLIENT_ID::INTEGER                                        	AS CLIENT_ID
         
  	, ADV_CHANNEL_SID::INTEGER                                  	AS MEDIUM_SID
																	
    , ADV_CHANNEL_NAME::VARCHAR                		            	AS MEDIUM_NAME
    , ADV_CHANNEL_NAME || ' (' || COALESCE(ADV_CHANNEL_CD,'n/A') || ')'::VARCHAR 	
    																AS MEDIUM_NAME_LDESCR
    , ADV_CHANNEL_DESCR::VARCHAR  		            				AS MEDIUM_DESCR
                                                                    
    -- version relevant attributes Default                                  
  	, '1900-01-01'::DATE                                        	AS VALID_FROM_DT
	, '9999-12-31'::DATE                                        	AS VALID_TO_DT
    , 0::SMALLINT                                               	AS DELETED_FG
    , DWH_UPDATED::TIMESTAMP                                    	AS DWH_UPDATED_TS
    
FROM
(
    SELECT 
          CLIENT_ID
        , ADV_CHANNEL_SID
        , P_LEW_MART_PIT.f_CleanString(COALESCE(ADV_CHANNEL_NAME,''))		AS ADV_CHANNEL_NAME
        , ADV_CHANNEL_CD
        , P_LEW_MART_PIT.f_CleanString(COALESCE(ADV_CHANNEL_DESCR,''))		AS ADV_CHANNEL_DESCR
        , DWH_UPDATED
    FROM P_LEW_CORE.T_ADVERTISEMENT_CHANNEL
	WHERE TRUE
		AND CLIENT_ID IN (
				-- PIT Country
				SELECT 
					CLIENT_ID 
				FROM P_LEW_MART_PIT.T_DIM_CLIENT 
				WHERE TRUE 
					AND PIT_COUNTRY_FG 	= 1 
					AND DELETED_FG 		= 0 
					AND REJECT_FG 		= 0 
					AND CURRENT_FG 		= 1 
				GROUP BY 1
			)	
			
	
    -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
    -- QUALIFY ROW_NUMBER() OVER(PARTITION BY ADV_CHANNEL_SID ORDER BY DWH_UPDATED DESC) = 1
) ch
WHERE TRUE

-- Deduplicate 
--QUALIFY ROW_NUMBER() OVER(PARTITION BY CLIENT_ID, MEDIUM_NAME ORDER BY DWH_UPDATED_TS DESC) = 1
QUALIFY ROW_NUMBER() OVER(PARTITION BY CLIENT_ID, ADV_CHANNEL_SID ORDER BY DWH_UPDATED_TS DESC) = 1
;