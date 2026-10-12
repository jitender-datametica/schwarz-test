/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_CORE_AC.V_ESL_REF_PRICE_LABEL_STATUS_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ESL_REF_PRICE_LABEL_STATUS_1(
   PRICE_LABEL_STATUS_CD
  ,PRICE_LABEL_STATUS_TYPE_CD
  ,PRICE_LABEL_PRODUCER_NAME
  ,PRICE_LABEL_STATUS_DESCR
  ,DWH_LOAD_ID
  ,DWH_CREATED
  ,DWH_UPDATED
) AS
SELECT
   PRICE_LABEL_STATUS_CD
  ,PRICE_LABEL_STATUS_TYPE_CD
  ,PRICE_LABEL_PRODUCER_NAME
  ,PRICE_LABEL_STATUS_DESCR
  ,DWH_LOAD_ID
  ,DWH_CREATED
  ,DWH_UPDATED
FROM 
    P_LEW_CORE.T_REF_PRICE_LABEL_STATUS_1
;
