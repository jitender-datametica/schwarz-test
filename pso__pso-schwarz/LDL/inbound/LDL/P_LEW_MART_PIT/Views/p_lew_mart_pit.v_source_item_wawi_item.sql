/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_SOURCE_ITEM_WAWI_ITEM
#-------------------------------------------------------------------------------
# Description: CREATE VIEW fOR V_SOURCE_ITEM_WAWI_ITEM
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli     Initial version
#  1.1  2021-09-07 Mike Davis          Refinement
#  1.2  2021-09-17 Mike Davis          Formatting
#  1.3  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.4  2021-10-12 Dirk Hering         Deduplication from source (Qualify Row Number = 1)
#  1.5  2022-02-10 Mike Davis          Add dat_valid_from
#  1.6  2024-02-01 Andreas Kurz		   added additional PV logic SORTIMENT_ARTICLE_FG
#  1.7	2024-09-23 Nikolai Toknov	   Add schema name for f_CleanValidToDate
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
0.   CREATE VIEW in V_SOURCE_ITEM_WAWI_ITEM
     Merge the coure sources: t_wawi_itm_item
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_ITEM_WAWI_ITEM
COMMENT = 'V_SOURCE_ITEM_WAWI_ITEM'
AS
SELECT
    -- keys (also see version)
      w_itm.client_id::INTEGER                                                     AS CLIENT_ID
    , w_itm.item_sid::INTEGER                                                      AS ITEM_SID
                                                                                   
    -- business w_itm keys (dat_valid_from is just invalid if Null)                
    , COALESCE(w_itm.dat_valid_from::DATE, '8888-12-31'::DATE)::DATE               AS DAT_VALID_FROM
                                                                                   
    -- w_itm information                                                           
    , w_itm.buying_list_type_id::INTEGER                                           AS BUYING_LIST_TYPE_ID
    , COALESCE(w_itm.buying_list_type_desc, 'N/A')::VARCHAR                        AS BUYING_LIST_TYPE_DESCR
    , COALESCE(w_itm.buying_list_type_desc, 'N/A')::VARCHAR                        AS BUYING_LIST_TYPE_INT_DESCR

	, iff ( w_itm.buying_list_type_id NOT IN (7,8)
			,1::SMALLINT
			,0::SMALLINT
		)																		   AS SORTIMENT_ARTICLE_FG
    -- additional item hierarchy join fields
    -- none

    -- technical versioning
    , COALESCE(w_itm.dat_rec_start, '1900-01-01'::DATE)::DATE                      AS VALID_FROM_DT
    , P_LEW_MART_PIT.f_CleanValidToDate(w_itm.dat_rec_end)::DATE                                  AS VALID_TO_DT
    
	, 0::SMALLINT                                                                  AS DELETED_FG
    , CURRENT_TIMESTAMP()::DATETIME                                                AS DWH_UPDATED_TS

FROM
    (
        SELECT
              CLIENT_ID
			, ITEM_SID
			, DAT_REC_START
			, DAT_REC_END
			, DAT_VALID_FROM

			, BUYING_LIST_TYPE_ID
			, BUYING_LIST_TYPE_DESC
		FROM P_LEW_CORE.T_WAWI_ITM_ITEM
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
        QUALIFY ROW_NUMBER() OVER (PARTITION BY CLIENT_ID, ITEM_SID, DAT_REC_START ORDER BY DAT_VALID_FROM DESC) = 1
    ) w_itm
;

--SELECT CLIENT_ID, SORTIMENT_ARTICLE_FG, COUNT(DISTINCT ITEM_SID) AS _RECNBR FROM p_lew_mart_pit.V_SOURCE_ITEM_WAWI_ITEM WHERE TRUE GROUP BY 1,2 ORDER BY 1,2;