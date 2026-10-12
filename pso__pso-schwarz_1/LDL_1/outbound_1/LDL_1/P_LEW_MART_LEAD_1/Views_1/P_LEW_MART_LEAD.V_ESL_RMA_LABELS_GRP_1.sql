/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_RMA_LABELS_GRP_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#  1.1  26.09.2024	SIMEON NIKOLAEV	Materialization
#  1.2  17.11.2025  DMITRY ZAYTSEV Added new fields for item_1 groups and defect reasons
#  1.3  25.11.2025  Marvin Rekovsky Add natural key for itemgroup_1 and subitemgroup
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_esl_rma_labels_grp_1 (int_id, client_id, move_to_store_id, wh_id, aspect_id,
price_label_producer_name, electronic_price_label_type_cd_fe, dat_formdate, item_grp_int_sid, sub_item_grp_sid,
itemgroup_int_id, subitemgroup_id, price_label_damage_reason_id, analysed_labels, defect_labels, notdefect_labels,
warranty_labels, defectprice_usd, defectprice_cur, currency_iso_cd) AS SELECT GRP.int_id,
 GRP.client_id,
 GRP.move_to_store_id,
 GRP.wh_id,
 GRP.aspect_id,
 GRP.price_label_producer_name,
 GRP.electronic_price_label_type_cd_fe,
 GRP.dat_formdate,
 GRP.item_grp_int_sid,
 GRP.sub_item_grp_sid,
 ROUND(CAST(ITG.src_itemgrp_int_cd AS BIGNUMERIC), 0) AS itemgroup_int_id,
 ROUND(CAST(SIG.src_subitemgrp_cd AS BIGNUMERIC), 0) AS subitemgroup_id,
 GRP.price_label_damage_reason_id,
 GRP.analysed_labels,
 GRP.defect_labels,
 GRP.notdefect_labels,
 GRP.warranty_labels,
 GRP.defectprice_usd,
 GRP.defectprice_cur,
 GRP.currency_iso_cd
FROM ldl_p_lew_mart_lead.t_esl_rma_labels_grp_1 AS GRP
 LEFT JOIN ldl_p_lew_bil_ac.v_subitemgroup_1 AS SIG ON GRP.client_id = SIG.client_id AND GRP.sub_item_grp_sid = SIG.sub_item_grp_sid
   
 LEFT JOIN ldl_p_lew_bil_ac.v_itemgroup_international_1 AS ITG ON SIG.item_grp_int_sid = ITG.item_grp_int_sid;