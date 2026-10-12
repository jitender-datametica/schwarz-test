/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_CORE_AC.V_ESL_PRICE_LABEL_PRICE_HIST
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ESL_PRICE_LABEL_PRICE_HIST(
   ELECTRONIC_PRICE_LABEL_TYPE_CD
  ,PRICE_LABEL_PRODUCER_NAME
  ,CURR_ISO_CD 
  ,NET_PRICE 
  ,DELETED_FG 
  ,DWH_VALID_FROM
  ,DWH_VALID_TO
  ,DWH_LOAD_ID
  ,DWH_CREATED 
  ,DWH_UPDATED
) AS
SELECT
   ELECTRONIC_PRICE_LABEL_TYPE_CD
  ,PRICE_LABEL_PRODUCER_NAME
  ,CURR_ISO_CD 
  ,NET_PRICE 
  ,DELETED_FG 
  ,DWH_VALID_FROM
  ,DWH_VALID_TO
  ,DWH_LOAD_ID
  ,DWH_CREATED 
  ,DWH_UPDATED
FROM 
    P_LEW_CORE.T_PRICE_LABEL_PRICE_HIST
;