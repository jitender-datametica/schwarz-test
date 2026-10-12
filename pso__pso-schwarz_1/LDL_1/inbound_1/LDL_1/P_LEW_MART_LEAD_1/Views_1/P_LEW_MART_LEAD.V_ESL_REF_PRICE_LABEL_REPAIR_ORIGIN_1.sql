 /*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_REF_PRICE_LABEL_REPAIR_ORIGIN_1 
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ESL_REF_PRICE_LABEL_REPAIR_ORIGIN_1 
(
   PRICE_LABEL_REPAIR_ORIGIN_NAME
  ,PRICE_LABEL_PRODUCER_NAME
) AS
SELECT 
   PRICE_LABEL_REPAIR_ORIGIN_NAME
  ,PRICE_LABEL_PRODUCER_NAME
  
FROM P_LEW_CORE_AC.V_ESL_REF_PRICE_LABEL_REPAIR_ORIGIN_1 
;