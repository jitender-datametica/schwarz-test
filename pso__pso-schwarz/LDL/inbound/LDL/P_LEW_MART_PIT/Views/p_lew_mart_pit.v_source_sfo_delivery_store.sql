/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for v_source_sfo_delivery_store
#-------------------------------------------------------------------------------
# Describtion: Create View for v_source_sfo_delivery_store
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-07-95 Massimo Morelli	   	Initial version
#  2.0	2022-07-16 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_SFO_DELIVERY_STORE
COMMENT = 'Source View for SFO (delivery to store)'
AS
SELECT

      sfo.CLIENT_ID::INTEGER                       	AS CLIENT_ID
    , sfo.ITEM_SID::INTEGER                        	AS ITEM_SID
    , sfo.LOC_SID_STORE::INTEGER                   	AS STORE_SID
    , sfo.BOOKING_DAT::DATE                        	AS DAY_DT
    , sfo.SFO_TOTAL_QTY::NUMBER(38,5)   			AS SFO_TOTAL_QTY
	
    -- version	
    , '1900-01-01'::DATE                           	AS VALID_FROM_DT
    , '9999-12-31'::DATE                           	AS VALID_TO_DT
    , 0::SMALLINT			                       	AS DELETED_FG
    , sfo.DWH_UPDATED::TIMESTAMP                   	AS DWH_UPDATED_TS

	
FROM    
(
	SELECT 
          CLIENT_ID
        , ITEM_SID 
        , LOC_SID_STORE
        , BOOKING_DAT
        , SFO_TOTAL_QTY
        , DWH_UPDATED
    FROM P_LEW_BIL.T_AGG_STORE_DAY_ITEM_SFO
    WHERE TRUE
    	AND SFOTYPE_ID IN (135, 145)
		
		-- 135	Bruchzuteilung
		-- 145	Korr. Bruchzuteilung

    	
    	AND BOOKING_DAT >= '2019-01-01'
    	AND BOOKING_DAT <= CURRENT_DATE()
    	
    	AND CLIENT_ID IN (
                -- PIT Country
                SELECT 
                     CLIENT_ID 
                FROM P_LEW_MART_PIT.T_DIM_CLIENT 
                WHERE TRUE 
                     AND PIT_COUNTRY_FG   = 1 
                     
                     AND DELETED_FG       = 0 
                     AND REJECT_FG        = 0 
                     AND CURRENT_FG       = 1 
                GROUP BY 1
           )
      
) sfo
WHERE TRUE
;
