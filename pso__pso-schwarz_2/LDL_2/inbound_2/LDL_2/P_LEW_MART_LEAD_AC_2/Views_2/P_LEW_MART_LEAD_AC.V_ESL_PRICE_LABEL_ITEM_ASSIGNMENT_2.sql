/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_PRICE_LABEL_ITEM_ASSIGNMENT_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ESL_PRICE_LABEL_ITEM_ASSIGNMENT_2
(
   EVENT_TMSP
  ,PRICE_LABEL_SID
  ,PRICE_LABEL_EVENT_TYPE_CD
  ,PRICE_LABEL_EVENT_DISPLAY_TYPE_CD
  ,ITEM_SID
  ,NEXT_EVENT_TMSP
) AS
SELECT 
   EVENT_TMSP
  ,PRICE_LABEL_SID
  ,PRICE_LABEL_EVENT_TYPE_CD
  ,PRICE_LABEL_EVENT_DISPLAY_TYPE_CD
  ,ITEM_SID
  ,NEXT_EVENT_TMSP
	
FROM P_LEW_MART_LEAD.V_ESL_PRICE_LABEL_ITEM_ASSIGNMENT_2
;