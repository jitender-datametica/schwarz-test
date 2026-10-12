/*
# History:
#  1.0  11.11.2025	DMITRY ZAYTSEV New view to support item groups and defect reasons
#  1.1  25.11.2025  Marvin Rekovsky Add natural key for itemgroup and subitemgroup
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW  P_LEW_MART_LEAD.V_ESL_PRICE_LABEL_STORE_RMA 
(
   INT_ID
  ,CLIENT_ID
  ,WH_ID
  ,MOVE_TO_STORE_ID
  ,ASPECT_ID
  ,PRICE_LABEL_PRODUCER_NAME
  ,ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
  ,DAT_FORMDATE
  ,CURRENCY_ISO_CD
  ,ITEM_GRP_INT_SID
  ,SUB_ITEM_GRP_SID
  ,ITEMGROUP_INT_ID
  ,SUBITEMGROUP_ID
  ,PRICE_LABEL_DAMAGE_REASON_ID 
  ,RMA_LABELS
) AS
SELECT
   rma.int_id
  ,rma.client_id
  ,rma.wh_id
  ,rma.move_to_store_id
  ,rma.aspect_id
  ,rma.price_label_producer_name
  ,rma.electronic_price_label_type_cd_fe
  ,rma.dat_formdate
  ,rma.currency_iso_cd
  ,rma.item_grp_int_sid
  ,rma.sub_item_grp_sid
  ,TO_NUMBER(itg.src_itemgrp_int_cd) AS itemgroup_int_id
  ,TO_NUMBER(sig.src_subitemgrp_cd)	 AS subitemgroup_id
  ,rma.price_label_damage_reason_id 
  ,rma.rma_labels
FROM p_lew_mart_lead.t_esl_price_label_store_rma AS rma

LEFT JOIN p_lew_bil_ac.v_subitemgroup AS sig
ON rma.client_id = sig.client_id
AND rma.sub_item_grp_sid = sig.sub_item_grp_sid

LEFT JOIN p_lew_bil_ac.v_itemgroup_international AS itg
ON sig.item_grp_int_sid = itg.item_grp_int_sid 
;
