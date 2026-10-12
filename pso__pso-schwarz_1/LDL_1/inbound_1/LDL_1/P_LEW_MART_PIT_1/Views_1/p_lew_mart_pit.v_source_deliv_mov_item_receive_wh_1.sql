/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_DELIV_MOV_ITEM_RECEIVE_WH_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_DELIV_MOV_ITEM_RECEIVE_WH_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli	Initial version
#  1.1  2021-09-29 Dirk Hering      Use example role added, data types added, column order, formatting
#  1.2  2021-10-01 Massimo Morelli  Resetting valid_from_dt, valid_to_dt, deleted_fg
#  1.3  2021-10-08 Dirk Hering      New target names: WAREHOUSE_SID 
#  1.4	2022-02-22 Andreas Kurz		Reformating and integrating Business Logic         
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_DELIV_MOV_ITEM_RECEIVE_WH_1
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_DELIV_MOV_ITEM_RECEIVE_WH_1
COMMENT = 'V_SOURCE_DELIV_MOV_ITEM_RECEIVE_WH_1'
AS
SELECT

      iwr.CLIENT_ID::INTEGER                                AS CLIENT_ID
    , iwr.ITEM_SID::INTEGER                                 AS ITEM_SID
    , iwr.DWH_CAL_DT::DATE                                  AS DWH_CAL_DT
    , iwr.LOC_SID_WH::INTEGER                               AS WAREHOUSE_SID
    
    , iwr.LOCATION_ITEM_RECEIPT_ID::NUMBER(38,0)            AS LOCATION_ITEM_RECEIPT_ID
    , iwr.LOCATION_ITEM_RECEIPT_POS_ID::NUMBER(38,0)        AS LOCATION_ITEM_RECEIPT_POS_ID
	, iwr.ORIG_RECEIPT_ID_RCV::VARCHAR                 		AS ORIG_RECEIPT_ID_RCV
	, iwr.STOCK_LOCATION_NR::NUMBER(38,0)                   AS STOCK_LOCATION_NR
	
	, iwr.CURR_CD_FROM										AS CURR_CD_FROM
	
	, COALESCE(cur.CURR_CD,'n/A')::VARCHAR                  AS CURR_CD
	, COALESCE(cur.CURR_SID,-2)::INTEGER					AS CURR_SID
	
    , iwr.RECEIPT_TYPE_ID::NUMBER(38,0)                     AS RECEIPT_TYPE_ID -- 1,2,3
    , iwr.STATUS_TG::NUMBER(38,0)                           AS STATUS_FG
    , iwr.RECEIPT_POS_MARGIN_REL_FG::NUMBER(38,0)           AS RECEIPT_POS_MARGIN_REL_FG -- 1 already filtered
    , COALESCE(TRY_TO_NUMBER(iwr.CUSTOMER_NR),0)::INTEGER   AS CUSTOMER_NR

    , iff(RECEIPT_TYPE_ID IN (1,2,3) AND STATUS_FG > 3 AND COALESCE(TRY_TO_NUMBER(iwr.CUSTOMER_NR),0) = 0::INTEGER,1::SMALLINT,0::SMALLINT) 
    														AS RCV_QTY_FG
    
	, iff (RCV_QTY_FG=1::SMALLINT, iwr.RECEIVE_PIECE_QTY, NULL) 
															AS RCV_QTY
    , iwr.BUYING_VAL::NUMBER(38,5)                          AS BUYING_VAL

    -- For the moment the valid_from and valid_to are considered not reliable, so statically set here
	, TO_DATE('1900-01-01','YYYY-MM_1-DD')					AS VALID_FROM_DT
	, TO_DATE('9999-12-31','YYYY-MM_1-DD')    				AS VALID_TO_DT
    , 0::SMALLINT                                     		AS DELETED_FG
	, CURRENT_TIMESTAMP()::DATETIME					        AS DWH_UPDATED_TS
	
FROM 

	(
		SELECT 
			* 
		FROM P_LEW_BIL.T_MOV_ITEM_RECEIVE_WH_1 
		WHERE TRUE
			AND 
				(
				RECEIPT_POS_MARGIN_REL_FG = 1
				OR 
				RECEIPT_TYPE_ID IN (1,2,3,4,5)
				)
		
	) iwr
	-- no deduplication because of high row count

	-- Country_1
	INNER JOIN
	(
		SELECT 
			*
		FROM P_LEW_CORE.T_COUNTRY_1 
		WHERE TRUE 
			AND COUNTRY_SID > 0
			
	    -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER(PARTITION BY COUNTRY_SID ORDER BY DWH_UPDATED DESC) = 1	
	) ctr
	ON
		ctr.COUNTRY_SID	= iwr.CLIENT_ID 
		
	-- 	Currency As-Is View only
	--  only local currency is used e.g. BG (3)
	INNER JOIN 
	(
		SELECT 
			  CLIENT_ID
			, CURR_SID_FROM AS CURR_SID
			, CURR_CD_FROM	AS CURR_CD
		FROM
			P_LEW_CORE.T_EXCHANGE_RATE_KNOWN_HIST_1
		WHERE TRUE 
			AND DELETED_FG 		= 0 
			AND CURR_SID_FROM 	= CURR_SID_TO 
			AND CURRENT_DATE() 	BETWEEN DWH_VALID_FROM AND DWH_VALID_TO     -- select just the current currencies
			
		-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER (PARTITION BY CLIENT_ID, CURR_SID, CURR_CD ORDER BY DWH_UPDATED DESC) = 1	
		
	) cur
	ON TRUE
		AND iwr.CLIENT_ID 		= cur.CLIENT_ID
		AND iwr.CURR_CD_FROM 	= cur.CURR_CD
		AND ctr.COUNTRY_SID		= cur.CLIENT_ID

	-- PIT Country_1
	INNER JOIN
	(
		SELECT
			CLIENT_ID
		FROM P_LEW_MART_PIT.T_DIM_CLIENT_1
		WHERE TRUE
			AND PIT_COUNTRY_FG 	= 1
			AND DELETED_FG 		= 0
			AND REJECT_FG 		= 0
			AND CURRENT_FG 		= 1
		GROUP BY 1	
	) cl
	ON TRUE
		AND cl.CLIENT_ID	= iwr.CLIENT_ID
		
WHERE TRUE
;