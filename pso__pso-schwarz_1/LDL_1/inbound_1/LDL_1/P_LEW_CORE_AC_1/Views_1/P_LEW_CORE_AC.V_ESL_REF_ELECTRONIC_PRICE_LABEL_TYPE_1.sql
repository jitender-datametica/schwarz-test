/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_CORE_AC.V_ESL_REF_ELECTRONIC_PRICE_LABEL_TYPE_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ESL_REF_ELECTRONIC_PRICE_LABEL_TYPE_1 (
   ELECTRONIC_PRICE_LABEL_TYPE_CD
  ,PRICE_LABEL_PRODUCER_NAME
  ,DWH_LOAD_ID
  ,DWH_CREATED
  ,DWH_UPDATED
) AS
SELECT
   ELECTRONIC_PRICE_LABEL_TYPE_CD
  ,PRICE_LABEL_PRODUCER_NAME
  ,DWH_LOAD_ID
  ,DWH_CREATED
  ,DWH_UPDATED
FROM 
    P_LEW_CORE.T_REF_ELECTRONIC_PRICE_LABEL_TYPE_1
;