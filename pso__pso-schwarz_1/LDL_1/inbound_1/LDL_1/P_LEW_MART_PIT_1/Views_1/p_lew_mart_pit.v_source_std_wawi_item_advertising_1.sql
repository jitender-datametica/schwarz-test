/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_STD_WAWI_ITEM_ADVERTISING_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_STD_WAWI_ITEM_ADVERTISING_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli     Initial version
#  1.1  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.2  2021-10-08 Dirk Hering         New target names: warehouse_sid
#  1.3  2021-10-12 Dirk Hering         Deduplication from source (Qualify Row Number = 1)
#-------------------------------------------------------------------------------
*/


/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_STD_WAWI_ITEM_ADVERTISING_1
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_STD_WAWI_ITEM_ADVERTISING_1
COMMENT = 'V_SOURCE_STD_WAWI_ITEM_ADVERTISING_1'
AS
SELECT

      stda.client_id::INTEGER                         AS CLIENT_ID
    , stda.wh_loc_sid::INTEGER                        AS WAREHOUSE_SID -- ORIG_WH_NR

    -- AR 09.09.2021 check if dat_dayend is considered as per the business requirement or can be removed. This is part of unique key if considered
    , stda.dat_dayend::DATE                           AS DAT_DAYEND  -- added to have unique group of keys
	
    , stda.item_sid::INTEGER                          AS ITEM_SID 
    , stda.price_retail_adv::NUMBER(38,5)             AS PRICE_RETAIL_ADV   
    , stda.dat_adv::DATE                              AS DAT_ADV

    -- Version
    , TO_DATE('1900-01-01','YYYY-MM_1-DD')              AS VALID_FROM_DT
    , TO_DATE('9999-12-31','YYYY-MM_1-DD')              AS VALID_TO_DT
    
	, 0::SMALLINT                                     AS DELETED_FG
    , CURRENT_TIMESTAMP()::DATETIME                   AS DWH_UPDATED_TS
                        
FROM 
    (
        SELECT 
            *
        FROM P_LEW_CORE.T_WAWI_ADV_ITEM_ADVERTISING_1
		WHERE TRUE
			AND CLIENT_ID IN (
				-- PIT Country_1
				SELECT 
					CLIENT_ID 
				FROM P_LEW_MART_PIT.T_DIM_CLIENT_1 
				WHERE TRUE 
					AND PIT_COUNTRY_FG 	= 1 
					AND DELETED_FG 		= 0 
					AND REJECT_FG 		= 0 
					AND CURRENT_FG 		= 1 
				GROUP BY 1
			)	
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		-- AKU 2022-03-11 this does not make sense here!!
        QUALIFY ROW_NUMBER() OVER (PARTITION BY CLIENT_ID, WH_LOC_SID, ITEM_SID, DAT_ADV ORDER BY DAT_DAYEND DESC NULLS LAST, LOAD_ID DESC) = 1
    ) stda

WHERE TRUE  
;