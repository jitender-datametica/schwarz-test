/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_REF_ELECTRONIC_PRICE_LABEL_PRODUCER 
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ESL_REF_ELECTRONIC_PRICE_LABEL_PRODUCER
(
   ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
  ,PRICE_LABEL_PRODUCER_NAME
  
) AS
SELECT DISTINCT
   ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
  ,PRICE_LABEL_PRODUCER_NAME
  
	
FROM P_LEW_MART_LEAD.V_ESL_REF_ELECTRONIC_PRICE_LABEL_TYPE 
;