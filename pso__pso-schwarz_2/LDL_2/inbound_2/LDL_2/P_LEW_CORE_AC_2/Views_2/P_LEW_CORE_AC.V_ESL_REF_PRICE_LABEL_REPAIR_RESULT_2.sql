/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_CORE_AC.V_ESL_REF_PRICE_LABEL_REPAIR_RESULT_2 
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ESL_REF_PRICE_LABEL_REPAIR_RESULT_2(
   PRICE_LABEL_REPAIR_RESULT_CD
  ,PRICE_LABEL_REPAIR_RESULT_DESCR
  ,PRICE_LABEL_PRODUCER_NAME
  ,DWH_LOAD_ID
  ,DWH_CREATED
  ,DWH_UPDATED
) AS
SELECT
   PRICE_LABEL_REPAIR_RESULT_CD
  ,PRICE_LABEL_REPAIR_RESULT_DESCR
  ,PRICE_LABEL_PRODUCER_NAME
  ,DWH_LOAD_ID
  ,DWH_CREATED
  ,DWH_UPDATED
FROM 
    P_LEW_CORE.T_REF_PRICE_LABEL_REPAIR_RESULT_2
;