/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_COUPON_HIST_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_COUPON_HIST_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-01-22 Nikolai Toknov	   Initial version
#  1.1  2025-05-14 Nikolai Toknov	   Inkrement 2.1 CR new types of LP-promotions(Mail: 09.05.2025)
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_COUPON_HIST_1
------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_COUPON_HIST_1
COMMENT = 'Source View Lidl Plus COUPON_HIST'
AS
SELECT
      ch.CLIENT_ID                                     										AS CLIENT_ID   
	, ch.COUPON_SID							 												AS COUPON_SID
	, ch.COUPON_TYPE_CD																		AS COUPON_TYPE_CD
    , ch.COUPON_NR 																			AS COUPON_NR
    , ch.COUPON_NAME 																		AS COUPON_NAME
    , ch.LOYALTY_PROG_CD 																	AS LOYALTY_PROG_CD
    , ch.GEO_AREA_SID 																		AS GEO_AREA_SID
    , ch.GEO_AREA_CD 																		AS GEO_AREA_CD
    , ch.COUPON_STATUS_CD 																	AS COUPON_STATUS_CD
    , ch.DISCOUNT_TYPE_CD 																	AS DISCOUNT_TYPE_CD
    , ch.CURR_CD 																			AS CURR_CD
    , ch.REDUCED_SALES_PRICE 																AS COUPON_REDUCED_SALES_PRICE
    , ch.DISCOUNT_VAL 																		AS COUPON_DISCOUNT_VAL
    , ch.DISCOUNT_PCT 																		AS COUPON_DISCOUNT_PCT
    , ch.DISCOUNT_X_CNT 																	AS COUPON_DISCOUNT_X_CNT
    , ch.DISCOUNT_Y_CNT 																	AS COUPON_DISCOUNT_Y_CNT  
    , ch.ORIG_DISCOUNT_TYPE_SID 															AS ORIG_DISCOUNT_TYPE_SID
    , ch.ORIG_COUPON_TYPE_SID 																AS ORIG_COUPON_TYPE_SID
    , ch.COUPON_REASON_NR 																	AS COUPON_REASON_NR
	, rct.ORIG_COUPON_TYPE_DESCR															AS COUPON_ORIG_COUPON_TYPE_DESCR
--    ,COUPON_ACTIVATION_TMSP
--    ,COUPON_VALID_FROM_TMSP
--    ,COUPON_VALID_TO_TMSP


    																				
   -- Version                                                                              
	, COALESCE(ch.DWH_VALID_FROM,TO_DATE('1900-01-01','YYYY-MM_1-DD'))  						AS VALID_FROM_DT														
	, COALESCE(ch.DWH_VALID_TO,TO_DATE('9999-12-31','YYYY-MM_1-DD'))  						AS VALID_TO_DT													
	, COALESCE(ch.DELETED_FG::SMALLINT, 0::SMALLINT)										AS DELETED_FG
	, ch.DWH_UPDATED::TIMESTAMP      				  										AS DWH_UPDATED_TS															
	
FROM P_LEW_CORE.T_COUPON_HIST_1 ch
	LEFT JOIN P_LEW_CORE.T_REF_ORIG_COUPON_TYPE_1 rct
	ON rct.ORIG_COUPON_TYPE_SID=ch.ORIG_COUPON_TYPE_SID
	
	
WHERE TRUE
;