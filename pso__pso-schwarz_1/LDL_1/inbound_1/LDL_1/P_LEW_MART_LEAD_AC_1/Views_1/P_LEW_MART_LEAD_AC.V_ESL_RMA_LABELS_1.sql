/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_RMA_LABELS_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ESL_RMA_LABELS_1
(
   INT_ID
	,CLIENT_ID
	,MOVE_TO_STORE_ID
	,WH_ID
	,ASPECT_ID
	,PRICE_LABEL_PRODUCER_NAME
	,ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
	,DAT_FORMDATE
	,ANALYSED_LABELS
	,DEFECT_LABELS
	,NOTDEFECT_LABELS
	,WARRANTY_LABELS
	,DEFECTPRICE_USD
	,DEFECTPRICE_CUR
	,CURRENCY_ISO_CD
) AS
SELECT 
  INT_ID
 ,CLIENT_ID
 ,MOVE_TO_STORE_ID
 ,WH_ID
 ,ASPECT_ID
 ,PRICE_LABEL_PRODUCER_NAME
 ,ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
 ,DAT_FORMDATE
 ,ANALYSED_LABELS
 ,DEFECT_LABELS
 ,NOTDEFECT_LABELS
 ,WARRANTY_LABELS
 ,DEFECTPRICE_USD
 ,DEFECTPRICE_CUR
 ,CURRENCY_ISO_CD
	
FROM P_LEW_MART_LEAD.V_ESL_RMA_LABELS_1
;