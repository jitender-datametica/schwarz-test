/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_ITEM_BRAND
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_ITEM_BRAND
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli     Initial version
#  1.1  2021-09-08 Mike Davis          Minor adjustments
#                                      Note: brand_type_cd only non-Null for client 7 (INT)
#  1.2  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.3  2021-10-11 Dirk Hering         Deduplication from source (Qualify Row Number = 1); T.DWH_UPDATED
#-------------------------------------------------------------------------------
*/


/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_ITEM_BRAND
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_ITEM_BRAND
COMMENT = "V_SOURCE_ITEM_BRAND"
AS
SELECT

    -- keys (also see version)
      br.CLIENT_ID									AS CLIENT_ID
    , br.BRAND_SID									AS BRAND_SID

    -- brand information
    , br.BRAND_NAME::VARCHAR                    	AS BRAND_NAME
    , br.BRAND_TYPE_CD::VARCHAR                 	AS BRAND_TYPE_CD

    -- technical versioning
    , TO_DATE('1900-01-01','YYYY-MM-DD')            AS VALID_FROM_DT
    , TO_DATE('9999-12-31','YYYY-MM-DD')            AS VALID_TO_DT
    , 0::SMALLINT                                   AS DELETED_FG
    , br.DWH_UPDATED::TIMESTAMP                     AS DWH_UPDATED_TS
                
FROM
    (
        SELECT 
            * 
        FROM P_LEW_CORE.T_BRAND
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
        QUALIFY ROW_NUMBER() OVER(PARTITION BY BRAND_SID ORDER BY DWH_UPDATED DESC) = 1
    ) br
	   
WHERE TRUE
;