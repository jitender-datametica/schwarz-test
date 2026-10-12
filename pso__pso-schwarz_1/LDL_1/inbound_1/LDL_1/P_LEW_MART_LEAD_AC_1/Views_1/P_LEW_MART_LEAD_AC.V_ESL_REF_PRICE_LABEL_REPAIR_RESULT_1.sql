/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_REF_PRICE_LABEL_REPAIR_RESULT_1 
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ESL_REF_PRICE_LABEL_REPAIR_RESULT_1 
(
   PRICE_LABEL_REPAIR_RESULT_CD
  ,PRICE_LABEL_REPAIR_RESULT_DESCR
  ,PRICE_LABEL_PRODUCER_NAME
) AS
SELECT 
   PRICE_LABEL_REPAIR_RESULT_CD
  ,PRICE_LABEL_REPAIR_RESULT_DESCR
  ,PRICE_LABEL_PRODUCER_NAME
	
FROM P_LEW_MART_LEAD.V_ESL_REF_PRICE_LABEL_REPAIR_RESULT_1 
;