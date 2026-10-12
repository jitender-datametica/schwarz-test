 /*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_RMA_LABELS_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#  2.0  26.09.2024	SIMEON NIKOLAEV	Materialization
#  3.0  17.11.2025  DMITRY ZAYTSEV Added new fields for item_1 groups and defect reasons
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ESL_RMA_LABELS_1(
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
FROM P_LEW_MART_LEAD.T_ESL_RMA_LABELS_1
;