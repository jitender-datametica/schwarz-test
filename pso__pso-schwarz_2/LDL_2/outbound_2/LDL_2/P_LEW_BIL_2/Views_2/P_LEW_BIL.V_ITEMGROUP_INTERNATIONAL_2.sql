CREATE OR REPLACE VIEW ldl_p_lew_bil.v_itemgroup_international_2 AS SELECT IGI.client_id,
 IGI.item_grp_int_sid,
 IGI.src_itemgrp_int_cd,
 IGI.src_itemgrp_int_id,
 IGI.item_grp_int_name,
 IGI_LIDL.item_grp_int_descr_long AS itemgroup_desc_lidl_long,
 IGI_DEFAULT.item_grp_int_descr_long AS itemgroup_desc_default_long,
 IGI_LIDL.item_grp_int_descr AS itemgroup_desc_lidl,
 IGI_DEFAULT.item_grp_int_descr AS itemgroup_desc_default,
 IGI_DEFAULT.lang_cd,
 IGI_LIDL.lang_sid
FROM ldl_p_lew_core_ac.v_itemgroup_international_2 AS IGI
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS LIDLCTRY ON IGI.client_id = LIDLCTRY.country_sid
 LEFT JOIN ldl_p_lew_core_ac.v_itemgroup_international_descr_2 AS IGI_DEFAULT ON LIDLCTRY.country_sid = IGI_DEFAULT.client_id
     AND LIDLCTRY.lang_sid = IGI_DEFAULT.lang_sid AND IGI.item_grp_int_sid = IGI_DEFAULT.item_grp_int_sid
 LEFT JOIN ldl_p_lew_core_ac.v_itemgroup_international_descr_2 AS IGI_LIDL ON IGI.item_grp_int_sid = IGI_LIDL.item_grp_int_sid
     AND IGI_LIDL.lang_sid = 2 AND IGI.client_id = IGI_LIDL.client_id;