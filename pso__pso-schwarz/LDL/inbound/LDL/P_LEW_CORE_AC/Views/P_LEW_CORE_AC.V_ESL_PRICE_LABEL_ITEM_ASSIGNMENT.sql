 /*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_CORE_AC.V_ESL_PRICE_LABEL_ITEM_ASSIGNMENT
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ESL_PRICE_LABEL_ITEM_ASSIGNMENT(
   EVENT_TMSP
  ,PRICE_LABEL_SID
  ,PRICE_LABEL_EVENT_TYPE_CD
  ,PRICE_LABEL_EVENT_DISPLAY_TYPE_CD
  ,ITEM_SID
  ,NEXT_EVENT_TMSP
  ,DWH_LOAD_ID
  ,DWH_CREATED
  ,DWH_UPDATED
) AS
SELECT
   EVENT_TMSP
  ,PRICE_LABEL_SID
  ,PRICE_LABEL_EVENT_TYPE_CD
  ,PRICE_LABEL_EVENT_DISPLAY_TYPE_CD
  ,ITEM_SID
  ,NEXT_EVENT_TMSP
  ,DWH_LOAD_ID
  ,DWH_CREATED
  ,DWH_UPDATED
FROM 
    P_LEW_CORE.T_PRICE_LABEL_ITEM_ASSIGNMENT
;
