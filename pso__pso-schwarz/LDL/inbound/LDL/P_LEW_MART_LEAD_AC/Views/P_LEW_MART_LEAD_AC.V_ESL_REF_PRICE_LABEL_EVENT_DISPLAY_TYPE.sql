/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_REF_PRICE_LABEL_EVENT_DISPLAY_TYPE
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ESL_REF_PRICE_LABEL_EVENT_DISPLAY_TYPE
(
   PRICE_LABEL_EVENT_DISPLAY_TYPE_CD
  ,PRICE_LABEL_EVENT_DISPLAY_TYPE_DESCR
) AS
SELECT 
   PRICE_LABEL_EVENT_DISPLAY_TYPE_CD
  ,PRICE_LABEL_EVENT_DISPLAY_TYPE_DESCR
	
FROM P_LEW_MART_LEAD.V_ESL_REF_PRICE_LABEL_EVENT_DISPLAY_TYPE
;