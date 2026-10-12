/*
# History:
#  1.0  11.11.2025	DMITRY ZAYTSEV New view to support item_1 groups and defect reasons
#  1.1  25.11.2025  Marvin Rekovsky Add natural key for itemgroup_1 and subitemgroup
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_esl_price_label_store_rma_1 (int_id, client_id, wh_id, move_to_store_id,
aspect_id, price_label_producer_name, electronic_price_label_type_cd_fe, dat_formdate, currency_iso_cd, item_grp_int_sid
, sub_item_grp_sid, itemgroup_int_id, subitemgroup_id, price_label_damage_reason_id, rma_labels) AS SELECT RMA.int_id,
 RMA.client_id,
 RMA.wh_id,
 RMA.move_to_store_id,
 RMA.aspect_id,
 RMA.price_label_producer_name,
 RMA.electronic_price_label_type_cd_fe,
 RMA.dat_formdate,
 RMA.currency_iso_cd,
 RMA.item_grp_int_sid,
 RMA.sub_item_grp_sid,
 ROUND(CAST(ITG.src_itemgrp_int_cd AS BIGNUMERIC), 0) AS itemgroup_int_id,
 ROUND(CAST(SIG.src_subitemgrp_cd AS BIGNUMERIC), 0) AS subitemgroup_id,
 RMA.price_label_damage_reason_id,
 RMA.rma_labels
FROM ldl_p_lew_mart_lead.t_esl_price_label_store_rma_1 AS RMA
 LEFT JOIN ldl_p_lew_bil_ac.v_subitemgroup_1 AS SIG ON RMA.client_id = SIG.client_id AND RMA.sub_item_grp_sid = SIG.sub_item_grp_sid
   
 LEFT JOIN ldl_p_lew_bil_ac.v_itemgroup_international_1 AS ITG ON SIG.item_grp_int_sid = ITG.item_grp_int_sid;