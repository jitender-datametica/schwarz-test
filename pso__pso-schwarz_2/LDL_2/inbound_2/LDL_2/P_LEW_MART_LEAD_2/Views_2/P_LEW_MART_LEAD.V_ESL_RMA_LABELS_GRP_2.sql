 /*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_RMA_LABELS_GRP_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#  1.1  26.09.2024	SIMEON NIKOLAEV	Materialization
#  1.2  17.11.2025  DMITRY ZAYTSEV Added new fields for item_2 groups and defect reasons
#  1.3  25.11.2025  Marvin Rekovsky Add natural key for itemgroup_2 and subitemgroup
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ESL_RMA_LABELS_GRP_2
(
	 INT_ID
	,CLIENT_ID
	,MOVE_TO_STORE_ID
	,WH_ID
	,ASPECT_ID
	,PRICE_LABEL_PRODUCER_NAME
	,ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
	,DAT_FORMDATE
    ,ITEM_GRP_INT_SID
    ,SUB_ITEM_GRP_SID
	,ITEMGROUP_INT_ID
	,SUBITEMGROUP_ID
    ,PRICE_LABEL_DAMAGE_REASON_ID
	,ANALYSED_LABELS
	,DEFECT_LABELS
	,NOTDEFECT_LABELS
	,WARRANTY_LABELS
	,DEFECTPRICE_USD
	,DEFECTPRICE_CUR
	,CURRENCY_ISO_CD
) AS
SELECT
  grp.int_id
 ,grp.client_id
 ,grp.move_to_store_id
 ,grp.wh_id
 ,grp.aspect_id
 ,grp.price_label_producer_name
 ,grp.electronic_price_label_type_cd_fe
 ,grp.dat_formdate
 ,grp.item_grp_int_sid
 ,grp.sub_item_grp_sid
 ,TO_NUMBER(itg.src_itemgrp_int_cd) AS itemgroup_int_id
 ,TO_NUMBER(sig.src_subitemgrp_cd)	AS subitemgroup_id
 ,grp.price_label_damage_reason_id
 ,grp.analysed_labels
 ,grp.defect_labels
 ,grp.notdefect_labels
 ,grp.warranty_labels
 ,grp.defectprice_usd
 ,grp.defectprice_cur
 ,grp.currency_iso_cd
FROM p_lew_mart_lead.t_esl_rma_labels_grp_2 AS grp

LEFT JOIN p_lew_bil_ac.v_subitemgroup_2 AS sig
ON grp.client_id = sig.client_id
AND grp.sub_item_grp_sid = sig.sub_item_grp_sid

LEFT JOIN p_lew_bil_ac.v_itemgroup_international_2 AS itg
ON sig.item_grp_int_sid = itg.item_grp_int_sid 
;