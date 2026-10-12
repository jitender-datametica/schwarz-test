/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_REF_ELECTRONIC_PRICE_LABEL_TYPE_1 
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ESL_REF_ELECTRONIC_PRICE_LABEL_TYPE_1 
(
   ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
  
) AS
SELECT DISTINCT
   ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
	
FROM P_LEW_MART_LEAD.V_ESL_REF_ELECTRONIC_PRICE_LABEL_TYPE_1 
;