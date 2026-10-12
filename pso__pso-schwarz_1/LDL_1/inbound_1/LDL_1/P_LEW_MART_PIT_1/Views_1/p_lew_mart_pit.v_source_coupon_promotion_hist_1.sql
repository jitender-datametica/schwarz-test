/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_COUPON_PROMOTION_HIST_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_COUPON_PROMOTION_HIST_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-01-22 Nikolai Toknov	   Initial version
#  1.1  2024-02-12 Nikolai Toknov		add WA to remove duplicates
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_COUPON_PROMOTION_HIST_1
------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_COUPON_PROMOTION_HIST_1
COMMENT = 'Source View Lidl Plus COUPON_PROMOTION_HIST'
AS
SELECT
      cph.CLIENT_ID                                     									AS CLIENT_ID   
	, cph.COUPON_PROMO_SID							 										AS COUPON_PROMO_SID
	, cph.COUPON_PROMO_TYPE_SID																AS COUPON_PROMO_TYPE_SID
	, cph.COUPON_SID																		AS COUPON_SID
	, cph.SRC_COUPON_PROMO_NR																AS SRC_COUPON_PROMO_NR
	, cph.SRC_COUPON_PROMO_VIZ_NR 															AS SRC_COUPON_PROMO_VIZ_NR
    , cph.COUPON_PROMO_BENEFIT_TXT 															AS COUPON_PROMO_BENEFIT_TXT
    , cph.COUPON_PROMO_START_DT 															AS COUPON_PROMO_START_DT
    , cph.COUPON_PROMO_END_DT 																AS COUPON_PROMO_END_DT
    , cph.SCRATCH_REDEMTION_DAY_QTY 														AS SCRATCH_REDEMTION_DAY_QTY
    																				
   -- Version                                                                              
	, COALESCE(cph.DWH_VALID_FROM,TO_DATE('1900-01-01','YYYY-MM_1-DD'))  						AS VALID_FROM_DT														
	, COALESCE(cph.DWH_VALID_TO,TO_DATE('9999-12-31','YYYY-MM_1-DD'))  						AS VALID_TO_DT													
	, COALESCE(cph.DELETED_FG::SMALLINT, 0::SMALLINT)										AS DELETED_FG
	, cph.DWH_UPDATED::TIMESTAMP      				  										AS DWH_UPDATED_TS															
	
FROM P_LEW_CORE.T_COUPON_PROMOTION_HIST_1 cph
	
WHERE TRUE
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		-- WA to remove duplicates
        QUALIFY ROW_NUMBER() OVER(PARTITION BY cph.CLIENT_ID, cph.COUPON_PROMO_SID, VALID_TO_DT ORDER BY DWH_UPDATED DESC) = 1
;