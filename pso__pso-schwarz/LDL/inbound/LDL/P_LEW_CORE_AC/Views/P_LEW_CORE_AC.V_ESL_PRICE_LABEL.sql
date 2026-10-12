 /*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_CORE_AC.V_ESL_PRICE_LABEL
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ESL_PRICE_LABEL(
   CLIENT_ID
  ,PRICE_LABEL_SID
  ,PRICE_LABEL_NR
  ,ELECTRONIC_PRICE_LABEL_TYPE_CD
  ,PRICE_LABEL_PRODUCER_NAME
  ,DWH_LOAD_ID
  ,DWH_CREATED
  ,DWH_UPDATED
) AS
SELECT
   CLIENT_ID 
  ,PRICE_LABEL_SID 
  ,PRICE_LABEL_NR 
  ,ELECTRONIC_PRICE_LABEL_TYPE_CD 
  ,PRICE_LABEL_PRODUCER_NAME 
  ,DWH_LOAD_ID 
  ,DWH_CREATED 
  ,DWH_UPDATED
FROM 
    P_LEW_CORE.T_PRICE_LABEL
;