/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_PRICE_LABEL
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ESL_PRICE_LABEL
(
   PRICE_LABEL_SID
  ,PRICE_LABEL_NR
  ,ELECTRONIC_PRICE_LABEL_TYPE_CD
  ,ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
  ,PRICE_LABEL_PRODUCER_NAME
) AS
SELECT 
   PRICE_LABEL_SID
  ,PRICE_LABEL_NR
  ,ELECTRONIC_PRICE_LABEL_TYPE_CD
  ,ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
  ,PRICE_LABEL_PRODUCER_NAME
	
FROM P_LEW_MART_LEAD.V_ESL_PRICE_LABEL
;