/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW FOR V_SOURCE_ITEM_EAN
#-------------------------------------------------------------------------------
# Description: CREATE VIEW FOR V_SOURCE_ITEM_EAN (item sub group)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-02-07 Andreas Kurz     Initial version
#-------------------------------------------------------------------------------
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT;
 */
/*
---------------------------------------------------------------------
0.   CREATE VIEW in V_SOURCE_ITEM_EAN
     EAN | BARCODE (ejr)
     DESC VIEW P_LEW_MART_PIT.V_SOURCE_ITEM_EAN
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_ITEM_EAN
COMMENT = 'V_SOURCE_ITEM_EAN'
AS
SELECT   

	-- keys (also see version)
	  ean.CLIENT_ID::INTEGER 																						AS CLIENT_ID
	, ean.ITEM_SID::INTEGER 																						AS ITEM_SID

	
    -- business isg keys		
	, ean.EAN::VARCHAR																								AS EAN
	, ean.EAN_ITEM_DESCR::VARCHAR 																					AS EAN_ITEM_DESCR
		
	, MD5(
               		COALESCE(ean.EAN			,'')     -- EAN
               ||  	COALESCE(ean.EAN_ITEM_DESCR	,'')     -- EAN_ITEM_DESC
        )																											AS SCD_KEY_MD

    -- technical versioning                                                                                     		
 	, ean.VALID_FROM_DT::DATE 																						AS VALID_FROM_DT
	, ean.VALID_TO_DT::DATE      																					AS VALID_TO_DT
			
	, 0::SMALLINT                                                                             						AS DELETED_FG    
    , CURRENT_TIMESTAMP()::TIMESTAMP                                                                           		AS DWH_UPDATED_TS

FROM
    (
		SELECT 
			  CLIENT_ID
			, ITEM_SID
			, DAT_REC_START 	AS VALID_FROM_DT
			, DAT_REC_END		AS VALID_TO_DT
			, EAN
			, EAN_ITEM_DESC		AS EAN_ITEM_DESCR
			--,CUSTOM_NR -- not filled
			--,CUSTOM_KEY -- not filled
			, LANGUAGE_ID
			, LOAD_ID
			--,EAN_ITEM_LONG_DESCR -- not filled
		FROM P_LEW_CORE.T_WAWI_ITM_EAN 
		WHERE TRUE 
			AND CLIENT_ID = LANGUAGE_ID
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
        QUALIFY ROW_NUMBER() OVER(PARTITION BY CLIENT_ID, ITEM_SID, EAN ORDER BY DAT_REC_START DESC) = 1
    ) ean


WHERE TRUE

;
-- SELECT CLIENT_ID, ITEM_SID, COUNT(1) AS _RECNBR FROM P_LEW_MART_PIT.V_SOURCE_ITEM_EAN WHERE TRUE AND CLIENT_ID = 1 GROUP BY 1,2 ORDER BY 1,2
-- SELECT * FROM P_LEW_MART_PIT.V_SOURCE_ITEM_EAN WHERE TRUE AND CLIENT_ID = 23 AND ITEM_SID = 5294139
-- SELECT * FROM P_LEW_MART_PIT.V_SOURCE_EJR_POS_RECEIPTLINE WHERE TRUE AND CLIENT_ID = 23 AND ITEM_SID = 5294139 AND EAN IN ('4009700068934')