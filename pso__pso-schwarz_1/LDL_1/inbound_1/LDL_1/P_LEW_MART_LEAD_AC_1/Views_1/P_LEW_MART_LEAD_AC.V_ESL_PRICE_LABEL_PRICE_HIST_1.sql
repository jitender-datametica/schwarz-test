/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_PRICE_LABEL_PRICE_HIST_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ESL_PRICE_LABEL_PRICE_HIST_1
(
   ELECTRONIC_PRICE_LABEL_TYPE_CD
  ,PRICE_LABEL_PRODUCER_NAME
  ,CURR_ISO_CD 
  ,NET_PRICE 
  ,DELETED_FG 
  ,DWH_VALID_FROM
  ,DWH_VALID_TO
) AS
SELECT 
   ELECTRONIC_PRICE_LABEL_TYPE_CD
  ,PRICE_LABEL_PRODUCER_NAME
  ,CURR_ISO_CD 
  ,NET_PRICE 
  ,DELETED_FG 
  ,DWH_VALID_FROM
  ,DWH_VALID_TO
	
FROM P_LEW_MART_LEAD.V_ESL_PRICE_LABEL_PRICE_HIST_1
;